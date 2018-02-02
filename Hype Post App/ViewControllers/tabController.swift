//
//  tabController.swift
//  Hype Post App
//
//  Created by C4Q on 2/2/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Material


class tabController: TabsController{
open override func prepare() {
    super.prepare()
    tabBar.setLineColor(Color.red.base, for: .selected) // or tabBar.lineColor = Color.orange.base
    tabBar.setTabItemsColor(Color.grey.base, for: .normal)
    tabBar.setTabItemsColor(Color.red.base, for: .selected)
    tabBar.setTabItemsColor(Color.green.base, for: .highlighted)
    tabBar.translatesAutoresizingMaskIntoConstraints = false
    tabBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    
    tabBarAlignment = .top
    tabBar.tabBarStyle = .auto
    tabBar.dividerColor = nil
    tabBar.lineHeight = 5.0
    tabBar.lineAlignment = .bottom
    //        tabBar.backgroundColor = Color.blue.darken2
}
}
