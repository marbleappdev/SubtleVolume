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
    var volumeOrigin: CGFloat = UIApplication.shared.statusBarFrame.height
    if #available(iOS 11.0, *) {
      volumeOrigin = additionalSafeAreaInsets.top
    }
    
    volume.frame = CGRect(x: 0, y: volumeOrigin, width: UIScreen.main.bounds.width, height: volumeHeight)
    volume.barTintColor = .white
    volume.barBackgroundColor = UIColor.white.withAlphaComponent(0.3)
    volume.animation = .fadeIn
    view.addSubview(volume)
    
    NotificationCenter.default.addObserver(volume, selector: #selector(SubtleVolume.resume), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
  }

  @IBAction func minusAction() {
    do {
      try volume.decreaseVolume(animated: true)
    } catch {
      print("The demo must run on a real device, not the simulator")
    }
  }

  @IBAction func plusAction() {
    do {
      try volume.setVolumeLevel(volume.volumeLevel + 0.05, animated: true)
    } catch {
      print("The demo must run on a real device, not the simulator")
    }
  }
  
}
