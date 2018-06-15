//
//  TableViewSideBar.swift
//  My Test Project
//
//  Created by Adriaan van Weije on 14/06/2018.
//  Copyright © 2018 Adriaan van Weije. All rights reserved.
//

import UIKit

protocol TableViewSideBarDelegate {
    func buttonTapped(buttonTitle: String)
}

class TableViewSideBar: UIView {

    // MARK: Properties
    private var currentOrientation: UIPrintInfoOrientation?
    private var outerStackView = UIStackView(frame: CGRect.zero)
    private var stackView = UIStackView(frame: CGRect.zero)
    private var buttons = [UIButton]()
    private var delegate: TableViewSideBarDelegate?
    
    var view: UIView?
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initAW()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initAW()
    }
    
    /*
    init(buttonTitles: [String]) {
        super.init(frame: CGRect.zero)
        
        initAW()
        
        addButtons(buttonTitles)
        
        setConstraints()
    }
    */
    
    private func initAW() {

        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("*** layoutSubviews")
        
        // if we changed to portrait
        if UIDevice.current.orientation.isPortrait {
            if currentOrientation != .portrait {
                // remember the current orientation
                currentOrientation = .portrait
                
                outerStackView.axis = .horizontal
                stackView.axis = .vertical
                
                reassignNextButtons()
            }
        // if we changed to landscape
        } else {
            if currentOrientation != .landscape {
                // remember the current orientation
                currentOrientation = .landscape
                
                outerStackView.axis = .vertical
                stackView.axis = .horizontal
                
                reassignNextButtons()
            }
        }
    }
    
    private func reassignNextButtons() {
        var size = CGFloat(0), maxSize = CGFloat(0)
        
        print("*** reassignNextButtons")
        
        // determine the button size and sidebar size
        if UIDevice.current.orientation.isPortrait {
            size = buttons[0].sizeThatFits(CGSize(width: 8, height: 8)).height
            maxSize = self.frame.height
        } else {
            size = buttons[0].sizeThatFits(CGSize(width: 8, height: 8)).width
            maxSize = self.frame.width
        }
        
        print("size: \(size), maxSize: \(maxSize)")

        // determine the number of buttons per 'page'
        if size > 0, maxSize > 0 {
            
            let cnt = Int(maxSize / size)
            
            print("Buttons per page: \(cnt)")
            
            
            // remove the current next/previous buttons
            for btn in buttons.filter( { $0.currentTitle == ".." } ) {
                
                stackView.removeArrangedSubview(btn)
                
                if let index = buttons.index(of: btn) { buttons.remove(at: index) }
            }
            
            // safety break, if we cant fit 3 buttons on a 'page', it wont work..
            if cnt < 3 { return }
            
            // if there are any 'pages'
            if cnt < buttons.count {
            
                // add the new next/previous buttons
                var i = 0
                
                while i < buttons.count {
                    
                    if i > 0, i%cnt == 0 {
                        
                        print("i: \(i), cnt: \(cnt) [Next Page]")
                        
                        var btnNext = createButton("..")
                        
                        btnNext.tag = min(i + cnt, buttons.count + 2)
                        btnNext.isHidden = i > cnt
                        btnNext.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
                        
                        buttons.insert(btnNext, at: i-1)
                        
                        stackView.insertArrangedSubview(btnNext, at: i-1)
                        
                        print("i: \(i), cnt: \(cnt) [Previous Page]")
                        
                        btnNext = createButton("..")
                        
                        btnNext.tag = i - cnt
                        btnNext.isHidden = true
                        btnNext.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
                        
                        buttons.insert(btnNext, at: i)
                        
                        stackView.insertArrangedSubview(btnNext, at: i)

                        i += 1
                    }
                    
                    buttons[i].isHidden = i > cnt

                    i += 1

                }
            }
        }
    }
    
    private func setConstraints() {

        //print("buttons: \(buttons.count)")
        //var btns = buttons
        
        /*
        if buttons.count > 0 {
            
            let size = buttons[0].sizeThatFits(CGSize(width: 8, height: 8))
            print("size (before): \(String(describing: size))")
            
            //stackView.addArrangedSubview(buttons[0])
            
            //btns.remove(at: 0)

            //size = buttons[0].sizeThatFits(CGSize(width: 8, height: 8))
            //print("size (added): \(String(describing: size))")
            
            //buttons[0].sizeToFit()
            //print("frame (sizeToFit): \(String(describing: buttons[0].frame))")

            let maxSize = self.frame.height
            
            print("size: \(size), maxSize: \(maxSize)")
            
            if size.height > 0, maxSize > 0 {
                
                let cnt = Int(maxSize / size.height) - 1
                
                //let cnt = 5
                
                print("Number of visible buttons: \(cnt)")
                
                if cnt < buttons.count {
                    
                    var i = cnt
                    
                    print("count: \(buttons.count)")
                    
                    while i < buttons.count {
                        
                        //
                        if i%cnt == 0 {
                            
                            // NEXT PAGE
                            
                            print("i: \(i), cnt: \(cnt) [Next Page]")

                            var btnNext = createButton("..")
                            
                            btnNext.tag = min(i + cnt, buttons.count + 2)
                            
                            btnNext.isHidden = i > cnt

                            btnNext.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
                            
                            buttons.insert(btnNext, at: i-1)
                            
                            
                            // PREVIOUS PAGE
                            
                            //
                            print("i: \(i), cnt: \(cnt) [Previous Page]")
                            
                            btnNext = createButton("..")
                            
                            btnNext.tag = i - cnt
                            
                            btnNext.isHidden = true
                            
                            btnNext.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
                            
                            buttons.insert(btnNext, at: i)
                            
                            i += 1
                        }
                        
                        buttons[i].isHidden = true
                        
                        i += 1
                    }
                    
                    print("i: \(i), count: \(buttons.count)")
                }
            }
        }
        */
        
        stackView = UIStackView(arrangedSubviews: buttons)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        //stackView.spacing = 5
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        outerStackView = UIStackView(frame: CGRect.zero)
        outerStackView.axis = .horizontal
        outerStackView.alignment = .leading
        outerStackView.distribution = .fill
        outerStackView.translatesAutoresizingMaskIntoConstraints = false

        outerStackView.addArrangedSubview(stackView)
        
        self.addSubview(outerStackView)

        self.addConstraints([
            NSLayoutConstraint(item: outerStackView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: outerStackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: outerStackView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: outerStackView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)])
        
    }
    
    // MARK: Public Functions
    public func setDelegate(_ view: TableViewSideBarDelegate) {
        self.delegate = view
    }
    
    public func addButtons(_ buttonTitles: [String]) {
        
        for title in buttonTitles {
            
            let btn = createButton(title)
            
            //btn.heightAnchor.constraint(equalTo: btn.widthAnchor).isActive = true

            btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

            buttons.append(btn)
        }
        
        setConstraints()
    }
    
    private func createButton(_ title: String) -> UIButton {
        let btn = UIButton(type: .custom)
        
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitleColor(UIColor.white, for: .highlighted)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        btn.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        btn.contentHorizontalAlignment = .center
        btn.contentVerticalAlignment = .center
        
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.layer.cornerRadius = 2
        btn.layer.masksToBounds = true
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        //btn.heightAnchor.constraint(equalTo: btn.widthAnchor).isActive = true
        
        return btn
    }
    
    // MARK: Events
    @objc private func buttonTapped(sender: UIButton) {
        print("buttonTapped: \(String(describing: sender))")
        
        if delegate != nil {
            
            // delegate.someFunctionName?
            delegate?.buttonTapped(buttonTitle: sender.currentTitle!)
            
        }
    }
    
    @objc private func nextButtonTapped(sender: UIButton) {
        
        if let index = buttons.index(of: sender) {
            
            print("nextButtonTapped: \(index), \(sender.tag)")

            if sender.tag < index {
                
                print("MakeVisible: \(sender.tag) - \(index)")
                
                for i in sender.tag..<index {
                    
                    buttons[i].isHidden = false
                }
                
                print("MakeInvisible: \(index) - \(index + (index-sender.tag))")
                
                for i in index..<min(index + (index-sender.tag), buttons.count) {
                    
                    buttons[i].isHidden = true
                }
            } else {
                
                if let firstVisible = buttons.index(where: { $0.isHidden == false }) {
                
                    print("MakeInvisble: \(firstVisible) - \(index+1)")

                    for i in firstVisible..<index+1 {
                    
                        buttons[i].isHidden = true
                    }
                }
                
                print("MakeVisible: \(index+1) - \(sender.tag)")
                
                for i in index+1..<sender.tag {
                    
                    buttons[i].isHidden = false
                }

            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
