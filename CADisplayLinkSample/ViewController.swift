//
//  ViewController.swift
//  CADisplayLinkSample
//
//  Created by Keisuke Shoji on 2017/04/20.
//  Copyright © 2017年 Keisuke Shoji. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var percentageLabel: UILabel!
    @IBOutlet private weak var barWrapperView: UIView!
    @IBOutlet private weak var barWidthConstraint: NSLayoutConstraint!
    private var displayLink: CADisplayLink!
    private let duration: TimeInterval = 0.5
    private let matching: CGFloat = 60.0
    private var startTimeInterval: TimeInterval = 0.0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupDisplayLink()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        startAnimation()
    }

    private func setupDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateTimer))
        if #available(iOS 10.0, *) {
            displayLink.preferredFramesPerSecond = 60
        } else {
            displayLink.frameInterval = 1
        }
        displayLink.isPaused = true
        displayLink.add(to: .current, forMode: .commonModes)
    }

    @objc private func startAnimation() {
        startTimeInterval = Date.timeIntervalSinceReferenceDate
        displayLink.isPaused = false
    }

    @objc private func stopAnimation() {
        displayLink.isPaused = true
    }

    @objc private func updateTimer() {
        let elapsed: TimeInterval = Date.timeIntervalSinceReferenceDate - startTimeInterval
        let progress: CGFloat = (elapsed > duration) ? 1.0 : CGFloat(elapsed / duration)
        let percentage: Int = Int(progress * matching)
        percentageLabel.text = "\(percentage)"
        barWidthConstraint.constant = barWrapperView.frame.width * progress * matching / 100.0

        if progress == 1.0 {
            displayLink.isPaused = true
        }
    }
}
