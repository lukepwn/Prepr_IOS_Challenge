//
//  AppDelegate.swift
//  LukeDam_IOS_Challenge
//
//  Created by Luke on 2020-05-09.
//  Copyright © 2020 Luke Dam. All rights reserved.
//

import UIKit
import SQLite3

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var databasename : String? = "myDB.db"
    var databasepath : String?
    var people : [MyData] = []
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let documentpath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let documentsDir = documentpath[0]
        
        databasepath = documentsDir.appending("/" + databasename!)
        
        print("database path is: " + databasepath!)
        checkAndCreateDatabase()
        readDataFromDatabase()
        
        return true
    }
    
    func checkAndCreateDatabase() {
        let filemanager = FileManager.default
        let success = filemanager.fileExists(atPath: databasepath!)
        
        if success {
            return
        }
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databasename!)
        
        try? filemanager.copyItem(atPath: databasePathFromApp!, toPath: databasepath!)
        
    }
    
    func readDataFromDatabase ()  {
        people.removeAll()
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(self.databasepath, &db) == SQLITE_OK {
            print ("successfully opened at \(self.databasepath!)")
            
            var queryStatement : OpaquePointer? = nil
            var queryString : String = "select * from tb1"
            
            if (sqlite3_prepare_v2(db, queryString, -1, &queryStatement, nil)) == SQLITE_OK {
                
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    
                    let id : Int = Int(sqlite3_column_int(queryStatement, 0))
                    let cname = sqlite3_column_text(queryStatement, 1)
                    let cdate = sqlite3_column_text(queryStatement, 2)
                    let caddress = sqlite3_column_text(queryStatement, 3)
                    
                    let name = String(cString: cname!)
                    let date = String(cString: cdate!)
                    let address = String(cString: caddress!)
                    
                    let data : MyData = .init()
                    data.initWithData(theRow: id, theName: name, theDate: date, theAddress: address)
                    people.append(data)
                    
                    print("query result: ")
                    print("\(id) | \(name) | \(date) | \(address))")
                }
                
                sqlite3_finalize(queryStatement)
                
            }
            else {
                print ("select statement could not be prepared")
                
            }
            
            sqlite3_close(db)
            
        }
        else {
            print ("unable to open")
            
        }
        
    }
    
    func insertIntoDatabase (person: MyData) -> Bool {
        var db : OpaquePointer? = nil
        var returnCode : Bool = true
        
        if sqlite3_open (self.databasepath, &db) == SQLITE_OK {
            print("successfully opened db at \(self.databasepath)")
            var insertStatement : OpaquePointer? = nil
            var insertStatementString : String = "insert into tb1 values(NULL, ?, ?, ?)"
            
            if (sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK) {
                
                let nameStr = person.name! as NSString
                let dateStr = person.date! as NSString
                let addressStr = person.address! as NSString
              
                sqlite3_bind_text(insertStatement, 1, nameStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, dateStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, addressStr.utf8String, -1, nil)
                
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    
                    let rowID = sqlite3_last_insert_rowid(db)
                    print("successful insert row at \(rowID)")
                    
                }
                else {
                    print("could not insert row")
                    returnCode = false
                }
                
                sqlite3_finalize(insertStatement)
            }
            else {
                print("insert statement could not be prepared")
                returnCode = false
            }
            sqlite3_close(db)
            
        }
        else {
            print("unable to open db")
            returnCode = false
        }
        
        return returnCode
    }
    
    func deleteFromDatabase (person: MyData) -> Bool {
        var db : OpaquePointer? = nil
        var returnCode : Bool = true
        
        if sqlite3_open (self.databasepath, &db) == SQLITE_OK {
            
            var deleteStatement : OpaquePointer? = nil
            var deleteStatementString : String = "delete from tb1 where id = ?"
            
            if (sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK) {
            
                print("successfully opened db at \(self.databasepath)")
            
                
                if sqlite3_step(deleteStatement) == SQLITE_DONE {
                    
                    let rowID = sqlite3_last_insert_rowid(db)
                    print("successful deleted row at \(rowID)")
                    
                }
                else {
                    print("could not delete row")
                    returnCode = false
                }
                
                sqlite3_finalize(deleteStatement)
            }
            else {
                print("delete statement could not be prepared")
                returnCode = false
            }
            sqlite3_close(db)
            
        }
        else {
        print("unable to open db")
        returnCode = false
        }

    return returnCode
    }

    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

