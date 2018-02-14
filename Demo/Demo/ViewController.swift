//
//  ViewController.swift
//  Demo
//
//  Created by Andrea Mazzini on 05/03/16.
//  Copyright © 2016 Fancy Pixel. All rights reserved.
//

import UIKit
import SubtleVolume

class ViewController: UIViewController {

  let volume = SubtleVolume(style: .plain)

  override func viewDidLoad() {
    super.viewDidLoad()

    let volumeHeight: CGFloat = 4
    var volumeOrigin: CGFloat = UIApplication.shared.statusBarFrame.height - volumeHeight
    if #available(iOS 11.0, *) {
      volumeOrigin = additionalSafeAreaInsets.top - volumeHeight
    }
    
    volume.frame = CGRect(x: 0, y: volumeOrigin, width: view.frame.width, height: volumeHeight)
    volume.barTintColor = .white
    volume.barBackgroundColor = UIColor.white.withAlphaComponent(0.3)
    volume.animation = .fadeIn
    view.addSubview(volume)
    
    NotificationCenter.default.addObserver(volume, selector: #selector(SubtleVolume.resume), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
  }

  @IBAction func minusAction() {
    try! volume.decreaseVolume(animated: true)
  }

  @IBAction func plusAction() {
    try! volume.setVolumeLevel(volume.volumeLevel + 0.05, animated: true)
  }
  
}
