//
//  AppDelegate.swift
//  RadioScanner
//
//  Created by Brendan Perry on 9/19/24.
//

import UIKit
import shared
import PDFKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        application.beginReceivingRemoteControlEvents()
        
//        Task {
//            let policeRepo = CCPoliceActivityRepository()
//            if let result = try? await policeRepo.getActivitiesPdfDataForDate(day: 19, month: 9, year: 24) {
//                let data = result.toData()
//                let pdf = PDFDocument(data: data)
//                if let pdfString = pdf?.string {
//                    let result = policeRepo.readPdfStringData(data: pdfString, day: 19, month: 9, year: 24)
//                    
//                    print(result)
//                }
//            }
//        }
        
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

