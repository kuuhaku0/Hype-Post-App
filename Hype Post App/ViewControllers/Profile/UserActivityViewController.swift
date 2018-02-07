//
//  AllPostsContainer.swift
//  Hype Post App
//
//  Created by C4Q on 2/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

enum contentTypes {
    case allPosts, allComments
}

class UserActivityViewController: UIViewController, UITableViewDelegate {
    // Storyboard is great
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var segmentedView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var statsContainerView: UIView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var editProfileButtonView: UIView!
    @IBOutlet weak var constraintHeightHeaderImages: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 100 //experimental
        }
    }
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: // All comments
            selectedSegment = 0
        case 1: // All posts
            selectedSegment = 1
        default:
            break
        }
    }
    @IBAction func editProfileButtonPressed(_ sender: UIButton) {
        //TODO: Present settingsVC
    }
    
    // At this offset the Header stops its transformations
    private let headerStopOffset:CGFloat = 200 - 64
    private let hiddenLabelDistanceToTop:CGFloat = 30.0
    private var contentToDisplay: contentTypes = .allPosts // might need this later
    private var selectedSegment = 0 {
        didSet {
            tableView.reloadData()
        }
    }
    private var posts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var headerBlurImageView: UIImageView = {
        let biv = UIImageView()
        biv.alpha = 0.0
        biv.contentMode = .scaleAspectFill
        biv.image = #imageLiteral(resourceName: "fate-stay-night-saber-armored-ruler-fate-apocrypha-fate-grand-order-omgmuchlove-anime-7962").blur(radius: 10, tintColor: UIColor.clear, saturationDeltaFactor: 1)
        return biv
    }()
    
    private lazy var headerImageView: UIImageView = {
        let hiv = UIImageView()
        hiv.image = #imageLiteral(resourceName: "fate-stay-night-saber-armored-ruler-fate-apocrypha-fate-grand-order-omgmuchlove-anime-7962")
        hiv.contentMode = .scaleAspectFill
        return hiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(headerView.frame.height, 0, 0, 0)
        //setupSettingsButton()
    }
    
    private func loadData() {
        DBService.manager.getAllPosts {(posts) in
            self.posts = posts
        }
    }
    
    private func setupUI() {
        
        // Header - Profile image
        profileImage.layer.borderWidth = 4.5
        profileImage.borderColor = .white
        profileImage.layer.cornerRadius = 20
        profileImage.clipsToBounds = true
        
        // Header - Edit profile button
        editProfileButton.layer.borderColor = UIColor.gray.cgColor
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.cornerRadius = 14
        
        headerView.clipsToBounds = true
        
        // Header - imageView
        headerView.insertSubview(headerImageView, belowSubview: headerLabel)
        headerImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(view.snp.leading)
            make.top.equalTo(headerView.snp.top)
            make.height.equalTo(headerView.snp.height)
            make.trailing.equalTo(view.snp.trailing)
        }
        // Header - blurImageView
        headerView.insertSubview(headerBlurImageView, belowSubview: headerLabel)
        headerBlurImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.view.snp.leading)
            make.top.equalTo(headerView.snp.top)
            make.height.equalTo(headerView.snp.height)
            make.trailing.equalTo(self.view.snp.trailing)
        }
    }
    
    // Not sure if I want the button
    private func setupSettingsButton() {
        let btn = UIButton(frame: CGRect(x: 4, y: 20, width: 44, height: 44))
        btn.setImage(#imageLiteral(resourceName: "Menu"), for: .normal)
        btn.tintColor = UIColor.white
        
        // ADDS BUTTON TO ALL VIEWS
        UIApplication.shared.keyWindow?.addSubview(btn)
        
        // LOCKS BUTTON TO HEADER (dissappears on scroll up)
        // headerView.insertSubview(btn, belowSubview: headerLabel)
    }
    
    public static func storyboardInstance() -> UserActivityViewController {
        let storyboard = UIStoryboard(name: "ProfileView", bundle: nil)
        let allPostsViewController = storyboard.instantiateViewController(withIdentifier: "UserActivityViewController") as! UserActivityViewController
        return allPostsViewController
    }
}

//MARK: - TABLEVIEW METHODS
extension UserActivityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //TODO: return the corresponding correct amount of cells
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        // UIScreen.main.bounds.width * 0.5628 + 32 //for testing purposes
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath)
        let post = posts[indexPath.row]
        
        if selectedSegment == 0 {
            cell.textLabel?.text = post.header
            cell.detailTextLabel?.text = post.body
        } else if selectedSegment == 1 {
            cell.textLabel?.text = "ayyyyyyyeeeee"
            cell.detailTextLabel?.text = "sdfgsdfgsdfgsdfgsdfgsdfg"
        }
        return cell
    }
}

// MARK: - SCROLLING INTERACTIONS
// Basically all the fancy stuff goes on here
extension UserActivityViewController: UIScrollViewDelegate {
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y + headerView.bounds.height
        var profileImageTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        // PULL DOWN
        if offset < 0 {
            let headerScaleFactor: CGFloat = -(offset) / headerView.bounds.height
            let headerSizevariation = ((headerView.bounds.height * (1.0 + headerScaleFactor)) - headerView.bounds.height)/2
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            // Hide views if scrolled super fast
            headerView.layer.zPosition = 0
            headerLabel.isHidden = true
        }
            // SCROLLING
        else {
            // HEADER CONTAINER
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-headerStopOffset, -offset), 0)
            
            // HIDDEN LABEL
            headerLabel.isHidden = false
            let alignToNameLabel = -offset + handleLabel.frame.origin.y + headerView.frame.height + headerStopOffset
            headerLabel.frame.origin = CGPoint(x: headerLabel.frame.origin.x, y: max(alignToNameLabel, hiddenLabelDistanceToTop + headerStopOffset))
            
            // BLUR
            headerBlurImageView.alpha = min(1.0, (offset - alignToNameLabel)/hiddenLabelDistanceToTop)
            
            // PROFILE IMAGE
            // Slow down the animation
            let profileImageScaleFactor = (min(headerStopOffset, offset)) / profileImage.bounds.height / 3.4
            let profileImageSizeVariation = ((profileImage.bounds.height * (1.0 + profileImageScaleFactor)) - profileImage.bounds.height) / 2
            
            profileImageTransform = CATransform3DTranslate(profileImageTransform, 0, profileImageSizeVariation, 0)
            profileImageTransform = CATransform3DScale(profileImageTransform, 1.0 - profileImageScaleFactor, 1.0 - profileImageScaleFactor, 0)
            
            if offset <= headerStopOffset {
                if profileImage.layer.zPosition < headerView.layer.zPosition {
                    headerView.layer.zPosition = 0
                }
                
            } else {
                if profileImage.layer.zPosition >= headerView.layer.zPosition {
                    headerView.layer.zPosition = 2
                }
            }
        }
        
        // Apply Transformations
        headerView.layer.transform = headerTransform
        profileImage.layer.transform = profileImageTransform
        
        // MARK: - Segmented control offset *Maybe put as section header?, not sure if it works with multiple sections*
        // Segment control
        let segmentViewOffset = profileView.bounds.height - segmentedView.bounds.height - offset
        var segmentTransform = CATransform3DIdentity
        
        // Scroll the segment view until its offset reaches the same offset at which the header stopped shrinking
        segmentTransform = CATransform3DTranslate(segmentTransform, 0, max(segmentViewOffset, -headerStopOffset), 0)
        segmentedView.layer.transform = segmentTransform
        
        // Set scroll view insets just underneath the segment control
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(segmentedView.bounds.maxY, 0, 0, 0)
    }
}


