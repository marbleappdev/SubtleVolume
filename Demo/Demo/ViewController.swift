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

    var volume = SubtleVolume()

    override func viewDidLoad() {
        super.viewDidLoad()

        volume.frame = CGRect(x: 8, y: 40, width: view.frame.size.width - 16, height: 10)
        view.addSubview(volume)
    }
    
}
