//
//  TableViewMasterController.swift
//  My Test Project
//
//  Created by Adriaan van Weije on 14/06/2018.
//  Copyright © 2018 Adriaan van Weije. All rights reserved.
//

import UIKit

class TableViewMasterController: UIViewController, TableViewSideBarDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
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

        //searchBar.search
        rightSideBarView.setDelegate(self)
        
        if embeddedVC != nil {
            
            let buttonTitles = embeddedVC!.countryLetters()

            rightSideBarView.addButtons(buttonTitles)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search for: \(searchText)")
        
        if embeddedVC != nil {
            
            //embeddedVC?.updateSearchResults(for: UISearchController(searchResultsController: nil))
            embeddedVC?.updateSearch(searchText)
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
