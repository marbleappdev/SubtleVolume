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

    volume.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: 4)
    volume.barTintColor = .white
    volume.barBackgroundColor = UIColor.white.withAlphaComponent(0.3)
    volume.animation = .fadeIn
    view.addSubview(volume)
    
    NotificationCenter.default.addObserver(volume, selector: #selector(SubtleVolume.resume), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
  }
  
  @objc func handleActiveState() {
    volume.resume()
  }

  @IBAction func minusAction() {
    try! volume.decreaseVolume(animated: true)
  }

  @IBAction func plusAction() {
    try! volume.setVolumeLevel(volume.volumeLevel + 0.05, animated: true)
  }
  
}
