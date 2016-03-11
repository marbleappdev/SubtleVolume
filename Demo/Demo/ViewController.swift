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

  let volume = SubtleVolume(style: .Plain)

  override func viewDidLoad() {
    super.viewDidLoad()

    volume.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: 4)
    volume.barTintColor = .whiteColor()
    volume.barBackgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
    volume.animation = .FadeIn
    view.addSubview(volume)
  }

}
