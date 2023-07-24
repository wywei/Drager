//
//  MyViewController.swift
//  Drager
//
//  Created by andy on 2023/7/8.
//

import UIKit

class MyViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftVc = LeftViewController()
        leftView.addSubview(leftVc.view)
        addChild(leftVc)
        
        let rightVc = RightViewController()
        rightView.addSubview(rightVc.view)
        addChild(rightVc)
    
        
    }
    
}
