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

class FeedTableViewCell: UITableViewCell {

    fileprivate var card: PresenterCard!
    
    /// Conent area.
    var presenterView: UIImageView!
    var content: UILabel!
    
    /// Bottom Bar views.
    var bottomBar: Bar!
    var dateFormatter: DateFormatter!
    var dateLabel: UILabel!
    var favoriteButton: IconButton!
    var shareButton: IconButton!
    
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
        
        preparePresenterView()
        prepareDateFormatter()
        prepareDateLabel()
        prepareFavoriteButton()
        prepareShareButton()
        prepareMoreButton()
        prepareToolbar()
        prepareContentView()
        prepareBottomBar()
        preparePresenterCard()
    }
    
    public func configureCell(post: Post) {
        content.text = post.body
        toolbar.detail = post.header
    }
}

extension  FeedTableViewCell {
    fileprivate func preparePresenterView() {
        presenterView = UIImageView()
        presenterView.image = #imageLiteral(resourceName: "pokemon").resize(toWidth: self.frame.width)
        presenterView.contentMode = .scaleAspectFill
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
        dateLabel.text = dateFormatter.string(from: Date.distantFuture)
    }
    
    fileprivate func prepareFavoriteButton() {
        favoriteButton = IconButton(image: Icon.favorite, tintColor: Color.red.base)
    }
    
    fileprivate func prepareShareButton() {
        shareButton = IconButton(image: Icon.cm.share, tintColor: Color.blueGrey.base)
    }
    
    fileprivate func prepareMoreButton() {
        moreButton = IconButton(image: Icon.cm.moreHorizontal, tintColor: Color.blueGrey.base)
    }
    
    fileprivate func prepareToolbar() {
        toolbar = Toolbar(rightViews: [moreButton])
        
        toolbar.title = "Material"
        toolbar.titleLabel.textAlignment = .left
        
        toolbar.detail = "Build Beautiful Software"
        toolbar.detailLabel.textAlignment = .left
        toolbar.detailLabel.textColor = Color.blueGrey.base
    }
    
    private func prepareContentView() {
        content = UILabel()
        content.numberOfLines = 0
        content.text = "Material is an animation and graphics framework that is used to create beautiful applications."
        content.font = RobotoFont.regular(with: 14)
    }
    
    fileprivate func prepareBottomBar() {
        bottomBar = Bar(leftViews: [favoriteButton], rightViews: [shareButton], centerViews: [dateLabel])
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
        
        self.layout(card).vertically(top: -4, bottom: -4).centerVertically()
        self.layout(card).horizontally(left: 0, right: 0).center()
    }

}
