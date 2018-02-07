//
//  FeedTableViewCell.swift
//  Hype Post App
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Material
import SnapKit

class FeedTableViewCell: TableViewCell {

    fileprivate var card: PresenterCard!
    
    /// Conent area.
    var presenterView: UIImageView!
    var contentContainer: UIView!
    var content: UILabel!
    lazy var postTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    /// Bottom Bar views.
    var bottomBar: Bar!
    var dateFormatter: DateFormatter!
    var dateLabel: UILabel!
    var upvoteButton: IconButton!
    var downvoteButton: IconButton!
    var hypeAmount: UILabel!
    var shareButton: IconButton!
    var addCommentButton: IconButton!
    var spacing: UILabel!
    var profileImage: UIImageView!
//    lazy var profileImage: UIImageView = {
//        let iv = UIImageView()
//        iv.clipsToBounds = true
//        iv.image = #imageLiteral(resourceName: "fate-stay-night-saber-armored-ruler-fate-apocrypha-fate-grand-order-omgmuchlove-anime-7962")
//        iv.contentMode = .scaleToFill
//        iv.layer.cornerRadius = iv.bounds.height / 2
//        return iv
//    }()
    
    /// Toolbar views.
    fileprivate var toolbar: Toolbar!
     var moreButton: IconButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "FeedCell")
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupViews() {
        self.backgroundColor = Color.grey.lighten5
        self.selectionStyle = .none
        
        prepareProfileImage()
        preparePresenterView()
        prepareDateFormatter()
        prepareDateLabel()
        prepareToolBarButtons()
        prepareShareButton()
        prepareMoreButton()
        prepareToolbar()
        prepareContentView()
        prepareBottomBar()
        preparePresenterCard()
    }
    
    public func configureCell(post: Post) {
        content.text = post.body
        toolbar.title = post.header
        toolbar.detail = post.time.components(separatedBy: "+0000").joined()
    }
}

extension  FeedTableViewCell {
    fileprivate func preparePresenterView() {
        presenterView = UIImageView()
        presenterView.image = #imageLiteral(resourceName: "pokemon").resize(toWidth: self.frame.width)
        presenterView.contentMode = .scaleAspectFill
    }
    
    fileprivate func prepareProfileImage() {
        profileImage = UIImageView()
        profileImage.image = #imageLiteral(resourceName: "fate-stay-night-saber-armored-ruler-fate-apocrypha-fate-grand-order-omgmuchlove-anime-7962").resize(toWidth: 40)
        profileImage.contentMode = .scaleAspectFill
    }
    
    fileprivate func prepareDateFormatter() {
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
    }
    
    fileprivate func prepareDateLabel() {
        dateLabel = UILabel()
        dateLabel.font = RobotoFont.regular(with: 12)
        dateLabel.textColor = Color.blueGrey.base
        dateLabel.textAlignment = .center
        dateLabel.text = dateFormatter.string(from: Date())
    }
    
    fileprivate func prepareToolBarButtons() {
        addCommentButton = IconButton(image: #imageLiteral(resourceName: "icons8-topic-filled-50"), tintColor: Color.blueGrey.base)
        spacing = UILabel()
        spacing.text = " "
        
        upvoteButton = IconButton(image: #imageLiteral(resourceName: "icons8-slide-up-filled-50"), tintColor: Color.red.base)
        upvoteButton.title = " 12"
        hypeAmount = UILabel()
        hypeAmount.textAlignment = .center
        hypeAmount.sizeToFit()
        hypeAmount.text = "12"
        hypeAmount.font = RobotoFont.regular(with: 14)
        hypeAmount.textColor = Color.grey.base
        downvoteButton = IconButton(image: #imageLiteral(resourceName: "icons8-down-button-filled-50"), tintColor: Color.red.base)
    }
    
    fileprivate func prepareShareButton() {
        shareButton = IconButton(image: Icon.cm.share, tintColor: Color.grey.darken1)
    }
    
    fileprivate func prepareMoreButton() {
        moreButton = IconButton(image: Icon.cm.moreHorizontal, tintColor: Color.blueGrey.base)
        moreButton.addTarget(self, action: #selector(moreMenu), for: .touchUpInside)
    }
    
    
    @objc fileprivate func moreMenu(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
        })
        
        alert.addAction(UIAlertAction(title: "Flag Post", style: .destructive) { _ in
        })
      
        alert.addAction(UIAlertAction(title: "Flag User", style: .destructive) { _ in
        })
        
        alert.show()
    }
    
    fileprivate func prepareToolbar() {
        toolbar = Toolbar(rightViews: [moreButton])
        toolbar.title = "Username"
        toolbar.titleLabel.textAlignment = .left
        
        toolbar.detail = dateLabel.text
        toolbar.detailLabel.textAlignment = .left
        toolbar.detailLabel.textColor = Color.blueGrey.base
    }
    
    fileprivate func prepareContentView() {
        content = UILabel()
        content.numberOfLines = 0
        content.text = "yo pokemon is awesome!!!!"
        content.font = RobotoFont.regular(with: 14)
    }
    
    fileprivate func preparePostTitle() {
        
    }
    
    fileprivate func prepareBottomBar() {
        bottomBar = Bar(leftViews: [upvoteButton,downvoteButton], rightViews: [addCommentButton,shareButton], centerViews: [])
    }
    
    fileprivate func preparePresenterCard() {
        card = PresenterCard()
        card.toolbar = toolbar
        card.toolbarEdgeInsetsPreset = .wideRectangle2
        
        card.presenterView = presenterView
        card.contentView = content
        card.contentViewEdgeInsetsPreset = .square3
        card.bottomBar = bottomBar
        card.bottomBarEdgeInsetsPreset = .wideRectangle2
        card.bottomBar?.contentEdgeInsets = UIEdgeInsets(top: 0, left: -11, bottom: 0, right: -9)
        self.layout(card).vertically(top: 4, bottom: 4).centerVertically()
        self.layout(card).horizontally(left: 0, right: 0).center()
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
