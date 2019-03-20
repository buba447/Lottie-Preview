//
//  AppDelegate.swift
//  Lottie-Preview
//
//  Created by Brandon Withrow on 2/11/19.
//  Copyright © 2019 YurtvilleProds. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  func applicationDidFinishLaunching(_ aNotification: Notification) {

  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }

  func application(_ sender: NSApplication, openFile filename: String) -> Bool {
    FileManager.shared.openFile(url: URL(fileURLWithPath: filename))
    return true
  }
  
  @IBAction func openFile(_ sender: Any) {
    FileManager.shared.showOpenPanel()
  }
  
}

