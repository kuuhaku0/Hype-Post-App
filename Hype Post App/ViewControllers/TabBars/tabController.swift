//
//  tabController.swift
//  Hype Post App
//
//  Created by C4Q on 2/2/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Material


class tabController: TabsController {
open override func prepare() {
    super.prepare()
    tabBar.setLineColor(Color.darkGray, for: .selected) // or tabBar.lineColor = Color.orange.base
    tabBar.setTabItemsColor(Color.grey.base, for: .normal)
    tabBar.setTabItemsColor(Color.darkGray, for: .selected)
    tabBar.setTabItemsColor(Color.green.base, for: .highlighted)
    
    tabBar.snp.makeConstraints { (make) in
        make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        make.centerX.equalTo(view.snp.centerX)
    }
    
    tabBarAlignment = .top
    tabBar.tabBarStyle = .auto
    tabBar.dividerColor = nil
    tabBar.lineHeight = 5.0
    tabBar.lineAlignment = .bottom
    

    //        tabBar.backgroundColor = Color.blue.darken2
    }

}
