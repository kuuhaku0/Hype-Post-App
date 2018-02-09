//
//  DynamicFeedTableViewCell.swift
//  Hype Post App
//
//  Created by C4Q on 2/8/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Material

protocol DynamicFeedTableViewCellDelegate : class {
    func dynamicFeedTableViewCellDidFlagPost(_ sender: DynamicFeedTableViewCell)
    func dynamicFeedTableViewCellLikedPost(_ sender: DynamicFeedTableViewCell)
    func dynamicFeedTableViewCellCommentPressed(_ sender: DynamicFeedTableViewCell)
    func dynamicFeedTableViewCellDislikedPist(_ sender: DynamicFeedTableViewCell)
    func refreshTableView()
}

class DynamicFeedTableViewCell: TableViewCell {
    
    // Header
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var headerContainer: UIView!
    @IBOutlet weak var goToUserProfileButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView! {
        didSet {
            profileImage.layer.shadowRadius = 10
            profileImage.shadowColor = .gray
            profileImage.layer.shadowOpacity = 1
            profileImage.layer.shadowOffset = CGSize(width: 3, height: 3)
            
            profileImage.borderColor = Color.white
            profileImage.borderWidthPreset = .border3
            profileImage.layer.cornerRadius = profileImage.bounds.height / 2
            profileImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var moreDetailButton: UIButton!
    
    // Header - Actions
    @IBAction func goToUserProfile(_ sender: UIButton) {
        //TODO: - SEGUE
    }
    @IBAction func moreDetail(_ sender: UIButton) {
        moreMenu()
    }
    
    // Content
    @IBOutlet weak var postImage: UIImageView! {
        didSet {
            postImage.image = #imageLiteral(resourceName: "fate-stay-night-saber-armored-ruler-fate-apocrypha-fate-grand-order-omgmuchlove-anime-7962")
        }
    }
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postBody: UILabel!
    /******************************************/
    @IBOutlet weak var votesStack: UIStackView!
    @IBOutlet weak var upVoteButton: UIButton!
    @IBAction func upvoteButtonPressed(_ sender: UIButton) {
        upvoting()
    }
    @IBOutlet weak var downVoteButton: UIButton!
    @IBOutlet weak var upVoteCountLabel: UILabel!
    @IBAction func downVoteButtonPressed(_ sender: UIButton) {
    }
    /******************************************/
    @IBOutlet weak var commentStack: UIStackView!
    @IBAction func commentButtonPressed(_ sender: UIButton) {
        //TODO: - GOTO COMMENTS
        self.delegate?.dynamicFeedTableViewCellCommentPressed(self)
    }
    /******************************************/
    
    internal var aspectConstraint: NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                postImage.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                postImage.addConstraint(aspectConstraint!)
            }
        }
    }
    
    weak var delegate: DynamicFeedTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - FUNCTIONAL METHODS
    public func configureCell(post: Post) {
        
        upVoteCountLabel.text = String(post.upVotes)
        timeLabel.text = post.time.components(separatedBy: "+0000").joined()
        username.text = post.byUser
        postBody.text = post.body
        postTitle.text = post.header
    }
    
    fileprivate func upvoting(){
        self.delegate?.dynamicFeedTableViewCellLikedPost(self)
    }
    
    fileprivate func moreMenu(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in})
        alert.addAction(UIAlertAction(title: "Flag Post", style: .destructive) { _ in
            self.delegate?.dynamicFeedTableViewCellDidFlagPost(self)})
        alert.addAction(UIAlertAction(title: "Flag User", style: .destructive) { _ in})
        alert.show()
    }
    // Delgate method
    func setCustomImage(image: UIImage) {
        let aspect = image.size.width / image.size.height
        let constraint = NSLayoutConstraint(item: postImage, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: postImage, attribute: NSLayoutAttribute.height, multiplier: aspect, constant: 0.0)
        constraint.priority = UILayoutPriority(rawValue: 999)
        aspectConstraint = constraint
        postImage.image = image
        
        // call this to refresh table
        delegate?.refreshTableView()
    }
}

extension UIAlertController {
    func show() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.windowLevel = UIWindowLevelAlert
        window.makeKeyAndVisible()
        window.rootViewController?.present(self, animated: true, completion: nil)
    }
}
