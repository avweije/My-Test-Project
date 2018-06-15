//
//  LanguagesController.swift
//  My Test Project
//
//  Created by Adriaan van Weije on 12/06/2018.
//  Copyright © 2018 Adriaan van Weije. All rights reserved.
//

import UIKit

protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)
}

class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0

    let titleLabel = UILabel()
    let arrowLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowLabel)
        
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.borderWidth = 0.5
        contentView.layer.cornerRadius = 3
        contentView.layer.masksToBounds = true
        
        //contentView.backgroundColor = UIColor.darkGray

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader)))

        // arrowLabel must have fixed width and height
        arrowLabel.widthAnchor.constraint(equalToConstant: 12).isActive = true
        arrowLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.addConstraints([
            NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 10)])
        contentView.addConstraints([
            NSLayoutConstraint(item: arrowLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: arrowLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: -10)])

    }
        
    @objc public func tapHeader(gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
            return
        }
        delegate?.toggleSection(self, section: cell.section)
    }

    func setCollapsed(_ collapsed: Bool) {
        // Animate the arrow rotation (see Extensions.swf)
        //arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
        if collapsed {
            arrowLabel.transform = CGAffineTransform.identity
        } else {
            arrowLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        }
    }
}

class LanguagesController: UITableViewController, CollapsibleTableViewHeaderDelegate {

    //private var countriesByLetter = Dictionary<String,[String]>()
    private var countriesByLetter = Dictionary<String,[(Name: String, Code: String)]>()
    private var sections = [(Key: String, Collapsed: Bool)]()
    private var selectedCountry = Locale.current.regionCode
    
    // MARK: Public Functions
    
    public func countryLetters() -> [String] {
        return Array(countriesByLetter.keys).sorted()
    }
    
    public func scrollTo(_ sectionKey: String) {
        
        if let section = sections.index(where: { $0.Key == sectionKey } ) {
        
            let rect = tableView.rect(forSection: section)
        
            tableView.scrollRectToVisible(rect, animated: true)
        }
    }
    
    // MARK:
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadCountries()

        tableView.estimatedSectionHeaderHeight = 40.0
        tableView.sectionHeaderHeight = 40.0

        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(CollapsibleTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "Header")
        
        /*
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.tableHeaderView = view
        
        tableView.addConstraints([
            NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: tableView, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)])
        
        
        
        print("tableHeader: \(String(describing: view.frame))")
        */
        
        print("selectedCountry: \(String(describing: selectedCountry))")
    }
    
    private func loadCountries() {
        //var countryArray = [String]()
        var countryArray = [(Name: String, Code: String)]()
        
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            //countryArray.append(name)
            countryArray.append((Name: name, Code: code))
        }
        
        countryArray.sort(by: { $0.Name < $1.Name })
        
        //let letterArray = countryArray.filter { }
        //let letterArray = countryArray.map { $0[$0.startIndex] }
        
        countriesByLetter = Dictionary(grouping: countryArray, by: { String($0.Name[$0.Name.startIndex]) })
        
        //print("countries: \(String(describing: countriesByLetter))")
        
        for key in Array(countriesByLetter.keys).sorted() {
            sections.append((Key: key, Collapsed: false))
        }

        //print("sections: \(String(describing: sections))")
        
        //print("count: \(countriesByLetter.count)")
        //print("count(A): \(String(describing: countriesByLetter["A"]?.count))")

        //String.fir
        //print("countriesKeys: \(String(describing: countriesKeys))")
        //print("countriesByLetter: \(String(describing: countriesByLetter))")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: CollapsableTableViewDelegate
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].Collapsed
        
        // Toggle collapse
        sections[section].Collapsed = collapsed
        header.setCollapsed(collapsed)
        
        // Reload the whole section
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("section: \(section)")

        //return countriesByLetter[sections[section].Key]!.count
        
        return sections[section].Collapsed ? 0 : countriesByLetter[sections[section].Key]!.count
    }

    /*
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].Key
    }
    */
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "Header")

        header.titleLabel.text = sections[section].Key
        header.arrowLabel.text = ">"
        header.setCollapsed(sections[section].Collapsed)
        header.section = section
        header.delegate = self

        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].Collapsed ? 0 : UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let country = countriesByLetter[sections[indexPath.section].Key]?[indexPath.row]
        
        if country?.Code == selectedCountry {
            
            cell.accessoryType = .checkmark
            
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
        }

    }

    func emojiFlag(_ countryCode: String) -> String {
        var string = ""
        var country = countryCode.uppercased()
        for uS in country.unicodeScalars {
            let s = Unicode.Scalar(127397 + uS.value)
            string.append(s!.description)
        }
        return string
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        //cell.textLabel?.text = languageArray[indexPath.row]
        //print("row: \(indexPath.row)")
        
        //cell.textLabel?.text = "\(indexPath.section) : \(indexPath.row)"
        if let country = countriesByLetter[sections[indexPath.section].Key]?[indexPath.row] {
            // set the flag ?
            let flag = emojiFlag(country.Code)

            cell.textLabel?.text = "\(flag) \(country.Name)"
        }
        
        if cell.isSelected {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        /*
        if country?.Code == selectedCountry {
            cell.isSelected = true
            print("country is selected: \(selectedCountry)")
        }
        */
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCountry = countriesByLetter[sections[indexPath.section].Key]?[indexPath.row].Code
        
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.accessoryType = .none
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        print("prepareForSeque")
    }

}
