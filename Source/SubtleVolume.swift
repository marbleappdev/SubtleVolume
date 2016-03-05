//
//  SubtleVolume.swift
//  SubtleVolume
//
//  Created by Andrea Mazzini on 05/03/16.
//  Copyright © 2016 Fancy Pixel. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

public class SubtleVolume: UIView {

    private let volume = MPVolumeView(frame: CGRect.zero)
    private let overlay = UIView()
    private var volumeLevel = CGFloat(0)

    required public init() {
        super.init(frame: CGRect.zero)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    required override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {
        try! AVAudioSession.sharedInstance().setActive(true)
        volumeLevel = CGFloat(AVAudioSession.sharedInstance().outputVolume)
        AVAudioSession.sharedInstance().addObserver(self, forKeyPath: "outputVolume", options: .New, context: nil)

        backgroundColor = .clearColor()

        volume.setVolumeThumbImage(UIImage(), forState: .Normal)
        volume.userInteractionEnabled = false
        volume.alpha = 0.0001
        volume.showsRouteButton = false

        addSubview(volume)

        overlay.backgroundColor = .blackColor()
        addSubview(overlay)
    }

    public override func layoutSubviews() {
        updateVolume(volumeLevel)
        overlay.frame = frame
        overlay.frame.size.width = frame.size.width * CGFloat(volumeLevel)
        overlay.layer.cornerRadius = frame.size.height / 2
    }

    private func updateVolume(value: CGFloat) {
        volumeLevel = value
        overlay.frame.size.width = frame.size.width * CGFloat(volumeLevel)
    }

    public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        guard let change = change, value = change["new"] as? CGFloat where keyPath == "outputVolume" else { return }

        updateVolume(value)
    }

}
