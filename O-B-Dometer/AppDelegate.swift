//
//  AppDelegate.swift
//  O-B-Dometer
//
//  Created by Connor Critchley on 4/1/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let abrevArray = ["AL", "AK", "AZ", "AR", "AS", "CA", "CO", "CT", "DE", "DC", "FL",
                      "GA", "GU", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI",
                      "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "MP", "OH",
                      "OK", "OR", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "TT", "UT", "VT", "VA", "VI",
                      "WA", "WV", "WI", "WY"]
    let stateArray = ["Alabama", "Alaska", "Arizona", "Arkansas", "American Samoa", "California",
                      "Colorado", "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia",
                      "Guam", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana",
                      "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Montana",
                      "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York",
                      "North Carolina", "North Dakota", "Northern Mariana Islands", "Ohio", "Oklahoma", "Oregon",
                      "Pennsylvania", "Puerto Rico", "Rhode Island", "South Carolina", "South Dakota",
                      "Tennessee", "Texas", "Trust Territories", "Utah", "Vermont", "Virginia", "Virgin Islands",
                      "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    var currentState = ""
    var oldState = ""
    var latitude = ""
    var longitude = ""
    var uid = ""
    var dataArray = Array(repeating: 0, count: 57)
    //creation of shared persistent data object
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        var i = 0 //loop index
        for key in abrevArray {
            //initalize data array with local data
            dataArray[i] = UserDefaults.standard.integer(forKey: key)
            i += 1 //increment
        }
        currentState = UserDefaults.standard.string(forKey: "currentState") ?? ""
        oldState = UserDefaults.standard.string(forKey: "oldState") ?? ""
        return true
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

