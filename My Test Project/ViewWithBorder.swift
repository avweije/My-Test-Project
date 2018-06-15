//
//  ViewWithBorder.swift
//  My Test Project
//
//  Created by Adriaan van Weije on 29/05/2018.
//  Copyright © 2018 Adriaan van Weije. All rights reserved.
//

import UIKit

class ViewWithBorder: UIViewController {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view1.backgroundColor = UIColor.red
        view1.layer.borderWidth = 1
        view1.layer.borderColor = UIColor.black.cgColor
        
        view2.backgroundColor = UIColor.green
        view2.layer.borderWidth = 5
        view2.layer.borderColor = UIColor.black.cgColor
        
        view3.backgroundColor = UIColor.orange
        addBorder(view3, side: .Top, color: .black)
        addBorder(view3, side: .Left, color: .black)
        addBorder(view3, side: .Bottom, color: .black)
        addBorder(view3, side: .Right, color: .black)

        view4.backgroundColor = UIColor.purple
        view4.layer.borderWidth = 1
        view4.layer.borderColor = UIColor.black.cgColor
        
    }
}
