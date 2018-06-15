//
//  TableViewMasterController.swift
//  My Test Project
//
//  Created by Adriaan van Weije on 14/06/2018.
//  Copyright © 2018 Adriaan van Weije. All rights reserved.
//

import UIKit

class TableViewMasterController: UIViewController, TableViewSideBarDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var rightSideBarView: TableViewSideBar!
    
    private var embeddedVC: LanguagesController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("segue: \(String(describing: segue))")
        
        if let vc = segue.destination as? LanguagesController {
            self.embeddedVC = vc
        }

        /*
        if let vc = segue.destination as? LanguagesController,
            segue.identifier == "EmbedSegue" {
            self.embeddedViewController = vc
        }
        */
    }
    
    func buttonTapped(buttonTitle: String) {
        
        embeddedVC?.scrollTo(buttonTitle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad")
        
        //rightSideBarView = TableViewSideBar.init(buttonTitles: buttonTitles)
        
        //let buttonTitles = ["A","B","C","D","E","F"]
        
        //let buttonTitles = containerView.inputViewController.
        //containerView.embedded
        
        rightSideBarView.setDelegate(self)
        
        if embeddedVC != nil {
            
            let buttonTitles = embeddedVC!.countryLetters()

            rightSideBarView.addButtons(buttonTitles)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
