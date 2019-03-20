//
//  PreviewViewController.swift
//  Lottie-Preview
//
//  Created by Brandon Withrow on 2/11/19.
//  Copyright © 2019 YurtvilleProds. All rights reserved.
//

import Cocoa
import Lottie

class PreviewViewController: NSViewController {

  
  override func viewDidLoad() {
    super.viewDidLoad()
    FileManager.shared.delegate = self
    
    lottieWrapper.documentView = lottieView
    lottieWrapper.allowsMagnification = true
    lottieWrapper.maxMagnification = 4
    lottieWrapper.minMagnification = 0.5
    canvasView.addSubview(lottieWrapper)
    lottieWrapper.translatesAutoresizingMaskIntoConstraints = false
    lottieView.translatesAutoresizingMaskIntoConstraints = false
    
    lottieWrapper.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    lottieWrapper.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    lottieWrapper.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    lottieWrapper.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
    lottieView.leadingAnchor.constraint(equalTo: lottieWrapper.leadingAnchor).isActive = true
    lottieView.trailingAnchor.constraint(equalTo: lottieWrapper.trailingAnchor).isActive = true
    lottieView.topAnchor.constraint(equalTo: lottieWrapper.topAnchor).isActive = true
    lottieView.bottomAnchor.constraint(equalTo: lottieWrapper.bottomAnchor).isActive = true
    
    dragView.translatesAutoresizingMaskIntoConstraints = false
    dragView.delegate = self
    view.addSubview(dragView)
    dragView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    dragView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    dragView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    dragView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
  override func viewDidAppear() {
    self.view.window?.delegate = self
  }
  
  override var preferredMinimumSize: NSSize {
    return NSSize(width: 400, height: 300)
  }
  
  @IBAction func playButton(_ sender: Any) {
    if lottieView.isAnimationPlaying {
      lottieView.stop()
    } else {
      lottieView.play()
    }
  }
  
  @IBAction func loopButton(_ sender: Any) {
    lottieView.loopMode = lottieView.loopMode == .playOnce ? .loop : .playOnce
  }
  
  @IBOutlet weak var canvasView: NSView!
  
  @IBAction func sliderChanged(_ sender: NSSlider) {
    lottieView.currentProgress = CGFloat(sender.floatValue)
  }
  
  let lottieView = AnimationView()
  let lottieWrapper = NSScrollView()
  let dragView = DragView()
  
  func loadJSON(url: URL?) {
    if let url = url, let animation = Animation.filepath(url.path) {
      lottieView.animation = animation
      lottieWrapper.magnification = 1
    } else {
      lottieView.animation = nil
    }
  }

}

extension PreviewViewController: NSWindowDelegate {
  
  func windowShouldClose(_ sender: NSWindow) -> Bool {
    NSApplication.shared.terminate(self)
    return true
  }
  
}

extension PreviewViewController: FileManagerDelegate {
  func didOpenFile(url: URL?) {
    loadJSON(url: url)
  }
}

extension PreviewViewController: DragViewDelegate {
  var acceptedFileExtensions: [String] {
    return ["json"]
  }
  
  func dragView(dragView: DragView, didDragFileWith URL: URL) {
    loadJSON(url: URL)
  }
}
