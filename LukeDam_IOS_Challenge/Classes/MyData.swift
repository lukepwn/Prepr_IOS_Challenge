//
//  MyData.swift
//  LukeDam_IOS_Challenge
//
//  Created by Luke on 2020-05-09.
//  Copyright © 2020 Luke Dam. All rights reserved.
//
import UIKit

class MyData: NSObject {
    
    var id : Int?
    var name : String?
    var date: String?
    var address : String?

    func initWithData(theRow i : Int, theName n : String,  theDate d : String, theAddress a : String) {

        id = i
        name = n
        date = d
        address = a
        
    }
    
    func initWithData2(theName n : String,  theDate d : String, theAddress a : String) {

        name = n
        date = d
        address = a
        
    }
    
    func deleteData(theRow i : Int) {
        id = i
        
    }
}
