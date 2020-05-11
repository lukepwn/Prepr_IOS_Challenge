//
//  ViewController.swift
//  LukeDam_IOS_Challenge
//
//  Created by Luke on 2020-05-09.
//  Copyright © 2020 Luke Dam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTable: UITableView!
    let mainDelegate = UIApplication.shared.delegate as! (AppDelegate)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.people.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell:SiteCell = self.myTable.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")
        
        let rowNum = indexPath.row
        tableCell.primaryLabel.text = mainDelegate.people[rowNum].name
        tableCell.secondaryLabel.text = mainDelegate.people[rowNum].date
        
        tableCell.accessoryType = .disclosureIndicator
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowNum = indexPath.row
        
        // alert controller
        let alertController = UIAlertController(title: mainDelegate.people[rowNum].name, message: mainDelegate.people[rowNum].address, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let locAction = UIAlertAction(title: "Open Google Maps", style: .default, handler: {(action) in
            
            self.performSegue(withIdentifier: "next", sender: nil)
        })
            
        alertController.addAction(cancelAction)
        alertController.addAction(locAction)
        present(alertController, animated: true)
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let modifyAction = UIContextualAction(style: .normal, title: "Delete", handler: {ac, view, success in

            let rowNum = indexPath.row
            let person : MyData = .init()
            person.deleteData(theRow: self.mainDelegate.people[rowNum].id!)
            
            let returnCode = self.mainDelegate.deleteFromDatabase(person: person)
            print("Delete Button pressed")
            
            success(true)
        })
        modifyAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [modifyAction])
        
    }
    
    @IBAction func unwindToHome(sender : UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    


}

