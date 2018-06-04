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
    
    enum borderSide {
        case Left
        case Top
        case Right
        case Bottom
    }
    
    private func addBorder(_ view: UIView, side: borderSide, color: UIColor = UIColor.gray) {
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        
        let width: CGFloat = 5.0
        let offSet = (width / 2)
        
        switch side {
        case .Left:
            path.move(to: CGPoint(x: offSet, y: 0))
            path.addLine(to: CGPoint(x: offSet, y: view.frame.size.height))
            print("Left")
        case .Top:
            path.move(to: CGPoint(x: 0, y: offSet))
            path.addLine(to: CGPoint(x: view.frame.size.width, y: offSet))
            print("Top")
        case .Right:
            path.move(to: CGPoint(x: view.frame.size.width - offSet, y: 0))
            path.addLine(to: CGPoint(x: view.frame.size.width - offSet, y: view.frame.size.height))
            print("Right")
        case .Bottom:
            path.move(to: CGPoint(x: 0, y: view.frame.size.height - offSet))
            path.addLine(to: CGPoint(x: view.frame.size.width, y: view.frame.size.height - offSet))
            print("Bottom")
        }
        
        shapeLayer.strokeStart = 0
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineJoin = kCALineJoinRound
        //shapeLayer.lineDashPattern = [1, 3]
        shapeLayer.path = path.cgPath
        
        view.layer.addSublayer(shapeLayer)
    }
    

}
