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

public enum SubtleVolumeStyle {
  case Plain
  case Dashes
  case Dots
}

public enum SubtleVolumeAnimation {
  case None
  case SlideDown
  case FadeIn
}

public protocol SubtleVolumeDelegate {
  func subtleVolume(subtleVolume: SubtleVolume, willChange value: Float)
  func subtleVolume(subtleVolume: SubtleVolume, didChange value: Float)
}

public class SubtleVolume: UIView {

  public var style = SubtleVolumeStyle.Plain
  public var animation = SubtleVolumeAnimation.FadeIn

  public var barBackgroundColor = UIColor.clearColor() {
    didSet {
      backgroundColor = barBackgroundColor
    }
  }

  public var barTintColor = UIColor.whiteColor() {
    didSet {
      overlay.backgroundColor = barTintColor
    }
  }

  public var delegate: SubtleVolumeDelegate?

  private let volume = MPVolumeView(frame: CGRect.zero)
  private let overlay = UIView()
  private var volumeLevel = Float(0)

  convenience public init(style: SubtleVolumeStyle) {
    self.init(frame: CGRect.zero)
  }

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
    volumeLevel = AVAudioSession.sharedInstance().outputVolume
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
    updateVolume(volumeLevel, animated: false)
    overlay.frame = frame
    overlay.frame.size.width = frame.size.width * CGFloat(volumeLevel)
    overlay.layer.cornerRadius = frame.size.height / 2
  }

  private func updateVolume(value: Float, animated: Bool) {
    delegate?.subtleVolume(self, willChange: value)
    volumeLevel = value

    UIView.animateWithDuration(animated ? 0.1 : 0) { () -> Void in
      self.overlay.frame.size.width = self.frame.size.width * CGFloat(self.volumeLevel)
    }

    UIView.animateKeyframesWithDuration(2, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
      UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 0.2, animations: {
        switch self.animation {
        case .None: break
        case .FadeIn:
            self.alpha = 1
        case .SlideDown: break
        }
      })

      UIView.addKeyframeWithRelativeStartTime(0.8, relativeDuration: 0.2, animations: { () -> Void in
        switch self.animation {
        case .None: break
        case .FadeIn:
          self.alpha = 0.0001
        case .SlideDown: break
        }
      })

      }) { _ in
        self.delegate?.subtleVolume(self, didChange: value)
    }
  }

  public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    guard let change = change, value = change["new"] as? Float where keyPath == "outputVolume" else { return }

    updateVolume(value, animated: true)
  }

}
