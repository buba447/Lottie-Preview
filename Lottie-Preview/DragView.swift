//
//  DragView.swift
//  Lottie-Preview
//
//  Created by Brandon Withrow on 2/11/19.
//  Copyright © 2019 YurtvilleProds. All rights reserved.
//

import Foundation
import Cocoa

protocol DragViewDelegate {
  var acceptedFileExtensions: [String] { get }
  func dragView(dragView: DragView, didDragFileWith URL: URL)
}

class DragView: NSView {
  
  init() {
    super.init(frame: .zero)
    registerForDraggedTypes([NSPasteboard.PasteboardType.fileURL, NSPasteboard.PasteboardType.URL])
  }
  
  required init?(coder decoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private var fileTypeIsOk = false
  private var acceptedFileExtensions: [String] {
    return delegate?.acceptedFileExtensions ?? []
  }
  
  var delegate: DragViewDelegate?
  
  override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
    if checkExtension(drag: sender) {
      fileTypeIsOk = true
      return .copy
    } else {
      fileTypeIsOk = false
      return []
    }
  }

  override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
    guard let draggedFileURL = sender.draggedFileURL else {
      return false
    }
    
    delegate?.dragView(dragView: self, didDragFileWith: draggedFileURL)
    
    return true
  }
  
  func checkExtension(drag: NSDraggingInfo) -> Bool {
    guard let url = drag.draggedFileURL else {
      return false
    }
    let suffix = url.pathExtension.lowercased()
    return acceptedFileExtensions.contains(suffix)
  }
}

extension NSDraggingInfo {
  var draggedFileURL: URL? {
    guard let board = draggingPasteboard.propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray,
      let path = board[0] as? String
      else { return nil }
    
    return URL(fileURLWithPath: path)
  }
}
