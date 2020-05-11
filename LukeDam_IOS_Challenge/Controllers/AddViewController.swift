//
//  AddViewController.swift
//  LukeDam_IOS_Challenge
//
//  Created by Luke on 2020-05-09.
//  Copyright © 2020 Luke Dam. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var lbdateString: UILabel!
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func dateChanged (_ : AnyObject) {
        let dt = DateFormatter()
        dt.dateFormat = "dd-MM-yyyy"
        lbdateString.text = dt.string(from:datePicker.date)
    }
    
    @IBAction func addPerson (sender: UIButton) {
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        let person : MyData = .init()
        person.initWithData2(theName: tfName.text!, theDate: lbdateString.text!, theAddress: tfAddress.text!)
        
        let returnCode = mainDelegate.insertIntoDatabase(person: person)
        
        var returnMSG : String = tfName.text!
        
        if returnCode == false {
            returnMSG = "person add failed"
        }
        let alertController = UIAlertController(title: "SQLite Add", message: returnMSG, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dt = DateFormatter()
        dt.dateFormat = "dd-MM-yyyy"
        lbdateString.text = dt.string(from:datePicker.date)
        
        btnSubmit.layer.borderWidth = 1
        self.tfName.delegate = self
        self.tfAddress.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
