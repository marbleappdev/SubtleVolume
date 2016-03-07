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

  var volume = SubtleVolume(style: SubtleVolumeStyle.Plain)

  override func viewDidLoad() {
    super.viewDidLoad()

    volume.frame = CGRect(x: 0, y: 10, width: view.frame.size.width, height: 4)
    volume.barTintColor = .redColor()
    volume.animation = .SlideDown
    view.addSubview(volume)
  }

}
