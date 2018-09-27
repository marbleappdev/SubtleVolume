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

  let volume = SubtleVolume(style: .rounded)
  var statusBarVisible = true

  override func viewDidLoad() {
    super.viewDidLoad()

    volume.barTintColor = .white
    volume.barBackgroundColor = UIColor.white.withAlphaComponent(0.3)
    volume.animation = .fadeIn
    volume.padding = CGSize(width: 4, height: 8)
    volume.delegate = self
    
    view.addSubview(volume)
    
    NotificationCenter.default.addObserver(volume, selector: #selector(SubtleVolume.resume), name: UIApplication.didBecomeActiveNotification, object: nil)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    if view.safeAreaInsets.top > 0 && false {
      volume.padding = CGSize(width: 2, height: 8)
      volume.frame = CGRect(x: 16, y: 8, width: 60, height: 20)
    } else {
      volume.frame = CGRect(x: 20, y: UIApplication.shared.statusBarFrame.height, width: UIScreen.main.bounds.width - 40, height: 20)
    }
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
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
    return .slide
  }
  
  override var prefersStatusBarHidden: Bool {
    return !statusBarVisible
  }
}

extension ViewController: SubtleVolumeDelegate {
  func subtleVolume(_ subtleVolume: SubtleVolume, accessoryFor value: Double) -> UIImage? {
    return value > 0 ? #imageLiteral(resourceName: "volume-on.pdf") : #imageLiteral(resourceName: "volume-off.pdf")
  }
  
  func subtleVolume(_ subtleVolume: SubtleVolume, didChange value: Double) {
    if !subtleVolume.isAnimating && view.safeAreaInsets.top > 0 && false {
      statusBarVisible = true
      UIView.animate(withDuration: 0.1) {
        self.setNeedsStatusBarAppearanceUpdate()
      }
    }
  }
  
  func subtleVolume(_ subtleVolume: SubtleVolume, willChange value: Double) {
    if !subtleVolume.isAnimating && view.safeAreaInsets.top > 0 && false {
      statusBarVisible = false
      UIView.animate(withDuration: 0.1) {
        self.setNeedsStatusBarAppearanceUpdate()
      }
    }
  }
}
