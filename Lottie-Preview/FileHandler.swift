//
//  FileHandler.swift
//  Lottie-Preview
//
//  Created by Brandon Withrow on 2/11/19.
//  Copyright © 2019 YurtvilleProds. All rights reserved.
//

import Foundation
import AppKit

protocol FileManagerDelegate {
  func didOpenFile(url: URL?)
}
class FileManager {
  
  static let shared: FileManager = FileManager()
  
  var delegate: FileManagerDelegate?
  
  func showOpenPanel() {
    let panel = NSOpenPanel()
    panel.title = "Select Image"
    panel.allowsMultipleSelection = false
    panel.canChooseDirectories = false
    panel.canChooseFiles = true
    panel.canCreateDirectories = false
    panel.allowedFileTypes = ["json"]
    let url = panel.runModal() == .OK ? panel.urls.first : nil
    self.delegate?.didOpenFile(url: url)
  }
  
  func openFile(url: URL) {
    self.delegate?.didOpenFile(url: url)
  }
  
}
