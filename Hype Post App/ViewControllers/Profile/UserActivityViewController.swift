//
//  AllPostsContainer.swift
//  Hype Post App
//
//  Created by C4Q on 2/4/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

enum contentTypes {
    case allPosts, allComments
}

class UserActivityViewController: UIViewController, UITableViewDelegate, UIScrollViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 100
        }
    }
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var segmentedView: UIView!
    @IBOutlet weak var editProfileButtonView: UIView!
    
    // At this offset the Header stops its transformations
    let headerStopOffset:CGFloat = 200 - 64
    let hiddenLabelDistanceToTop:CGFloat = 30.0
    /*********************************************/
    
    var headerBlurImageView:UIImageView!
    var headerImageView:UIImageView!
    @IBOutlet weak var constraintHeightHeaderImages: NSLayoutConstraint!
    var contentToDisplay : contentTypes = .allPosts
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
         tableView.contentInset = UIEdgeInsetsMake(headerView.frame.height, 0, 0, 0)
//        setupSettingsButton()
        
        editProfileButtonView.layer.cornerRadius = 15
        editProfileButtonView.layer.borderWidth = 1
        editProfileButtonView.borderColor = UIColor.darkGray
        
    }
    
    override func viewWillLayoutSubviews() {
        
        profileImage.layer.cornerRadius = 20
        profileImage.clipsToBounds = true
        
        // Header - Image
        headerImageView = UIImageView(frame: headerView.bounds)
        headerImageView?.image = #imageLiteral(resourceName: "fate-stay-night-saber-armored-ruler-fate-apocrypha-fate-grand-order-omgmuchlove-anime-7962")
        headerImageView?.contentMode = UIViewContentMode.scaleAspectFill
        headerView.insertSubview(headerImageView, belowSubview: headerLabel)
        
        // Header - Blurred Image
        headerBlurImageView = UIImageView(frame: headerView.bounds)
        headerBlurImageView?.image = #imageLiteral(resourceName: "fate-stay-night-saber-armored-ruler-fate-apocrypha-fate-grand-order-omgmuchlove-anime-7962").blur(radius: 10, tintColor: UIColor.clear, saturationDeltaFactor: 0.7)
        headerBlurImageView?.contentMode = .scaleAspectFill
        headerBlurImageView?.alpha = 0.0
        /////
        headerView.insertSubview(headerBlurImageView, belowSubview: headerLabel)
    }
    
    private func setupSettingsButton() {
        let btn = UIButton(frame: CGRect(x: 4, y: 20, width: 44, height: 44))
        btn.setImage(#imageLiteral(resourceName: "Menu"), for: .normal)
        btn.tintColor = UIColor.white
        
        //ADDS BUTTON TO ALL VIEWS
        UIApplication.shared.keyWindow?.addSubview(btn)
        
        //LOCKS BUTTON TO HEADER (dissappears on scroll up)
        //        headerView.insertSubview(btn, belowSubview: headerLabel)
        headerView.clipsToBounds = true
    }
    
    public static func storyboardINstance() -> UserActivityViewController {
        let storyboard = UIStoryboard(name: "ProfileView", bundle: nil)
        let allPostsViewController = storyboard.instantiateViewController(withIdentifier: "UserActivityViewController") as! UserActivityViewController
        return allPostsViewController
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
           // UIScreen.main.bounds.width * 0.5628 + 32
//        UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath)
        return cell
    }
}

extension UserActivityViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y + headerView.bounds.height
        var profileImageTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        // PULL DOWN
        if offset < 0 {
            let headerScaleFactor:CGFloat = -(offset) / headerView.bounds.height
            let headerSizevariation = ((headerView.bounds.height * (1.0 + headerScaleFactor)) - headerView.bounds.height)/2
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            //Hide views if scrolled super fast
            headerView.layer.zPosition = 0
            headerLabel.isHidden = true
        }
            //SCROLLING
        else {
            //HEADER CONTAINER
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-headerStopOffset, -offset), 0)
           
            //HIDDEN LABEL
            headerLabel.isHidden = false
            let alignToNameLabel = -offset + handleLabel.frame.origin.y + headerView.frame.height + headerStopOffset
            headerLabel.frame.origin = CGPoint(x: headerLabel.frame.origin.x, y: max(alignToNameLabel, hiddenLabelDistanceToTop + headerStopOffset))
        
            //BLUR
            headerBlurImageView?.alpha = min (1.0, (offset - alignToNameLabel)/hiddenLabelDistanceToTop)
            
            //PROFILE IMAGE
            // Slow down the animation
            let profileImageScaleFactor = (min(headerStopOffset, offset)) / profileImage.bounds.height / 9.4
            let profileImageSizeVariation = ((profileImage.bounds.height * (1.0 + profileImageScaleFactor)) - profileImage.bounds.height) / 2.0
            
            profileImageTransform = CATransform3DTranslate(profileImageTransform, 0, profileImageSizeVariation, 0)
            profileImageTransform = CATransform3DScale(profileImageTransform, 1.0 - profileImageScaleFactor, 1.0 - profileImageScaleFactor, 0)
            
            if offset <= headerStopOffset {
                if profileImage.layer.zPosition < headerView.layer.zPosition{
                    headerView.layer.zPosition = 0
                }
                
            }else {
                if profileImage.layer.zPosition >= headerView.layer.zPosition{
                    headerView.layer.zPosition = 2
                }
            }
        }
        
        // Apply Transformations
        headerView.layer.transform = headerTransform
        profileImage.layer.transform = profileImageTransform
        
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
