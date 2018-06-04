//
//  ViewController.swift
//  My Test Project
//
//  Created by Adriaan van Weije on 27/05/2018.
//  Copyright © 2018 Adriaan van Weije. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var genderComboBox: AWComboBox!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var genderComboBox2: AWComboBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        birthDatePicker.layer.borderColor = UIColor.black.cgColor
        birthDatePicker.layer.borderWidth = 1
        
        addBorder(birthDatePicker, side: .Top, color: .white)
        //addBorder(birthDatePicker, side: .Bottom, color: .orange)

        addBorder(birthDatePicker, side: .Left, color: .white)
        //addBorder(birthDatePicker, side: .Right, color: .brown)
        
        //
        //genderComboBox = AWComboBox(self.view)
        print("self.view: \(self.view)")
        
        genderComboBox.setParentView(self.view)
        
        genderComboBox2.dataSource = ["Man","Vrouw","Transgender","Bankstel","Stoel","Autootje"]
        genderComboBox2.setParentView(self.view)

        print("dataSource: \(genderComboBox2.dataSource)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        let width: CGFloat = 1.0
        
        switch side {
        case .Left:
            path.move(to: CGPoint(x: (width / 2), y: width / 2))
            path.addLine(to: CGPoint(x: (width / 2), y: view.frame.size.height - width / 2))
            print("Left")
        case .Top:
            path.move(to: CGPoint(x: width / 2, y: width / 2))
            path.addLine(to: CGPoint(x: view.frame.size.width - width / 2, y: width / 2))
            print("Top")
        case .Right:
            path.move(to: CGPoint(x: view.frame.size.width - 2 - width / 2, y: width / 2))
            path.addLine(to: CGPoint(x: view.frame.size.width - 2 - width / 2, y: view.frame.size.height - width / 2))
            print("Right")
        case .Bottom:
            path.move(to: CGPoint(x: 0, y: view.frame.size.height))
            path.addLine(to: CGPoint(x: view.frame.size.width, y: view.frame.size.height))
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

