//
//  ProgressView.swift
//  CADisplayLinkSample
//
//  Created by Keisuke Shoji on 2017/04/20.
//  Copyright © 2017年 Keisuke Shoji. All rights reserved.
//

import UIKit

@IBDesignable final class ProgressView: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var percentageLabel: UILabel!

    private let lineLayer: CAShapeLayer = CAShapeLayer()
    private let baseLineLayer: CAShapeLayer = CAShapeLayer()
    private let duration: TimeInterval = 1.0
    private var displayLink: CADisplayLink!
    private var startTimeInterval: TimeInterval = 0.0

    var matching: CGFloat = 100.0
    var points: (p1: CGPoint, p2: CGPoint)?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupDisplayLink()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setupContentView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        setupContentView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setupBaseLineLayerPath()
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

    private func setupContentView() {
        Bundle.main.loadNibNamed("ProgressView", owner: self)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        setupLineLayer()
    }

    private func setupLineLayer() {
        baseLineLayer.strokeColor = UIColor.lightGray.cgColor
        baseLineLayer.lineWidth = 6.0
        baseLineLayer.strokeStart = 0.0
        baseLineLayer.strokeEnd = 1.0
        baseLineLayer.lineCap = kCALineCapRound
        layer.addSublayer(baseLineLayer)

        lineLayer.strokeColor = UIColor.red.cgColor
        lineLayer.lineWidth = 6.0
        lineLayer.strokeStart = 0.0
        lineLayer.strokeEnd = 0.0
        lineLayer.lineCap = kCALineCapRound
    }

    private func setupBaseLineLayerPath() {
        let path: CGMutablePath = CGMutablePath()
        let start: CGPoint = CGPoint(x: 0.0, y: 66.0)
        let end: CGPoint = CGPoint(x: frame.width, y: 66.0)
        path.move(to: start)
        path.addLine(to: end)
        baseLineLayer.path = path
    }

    func startAnimation() {
        let path: CGMutablePath = CGMutablePath()
        let start: CGPoint = CGPoint(x: 0.0, y: 66.0)
        let end: CGPoint = CGPoint(x: frame.width * matching / 100.0, y: 66.0)
        path.move(to: start)
        path.addLine(to: end)
        lineLayer.path = path
        layer.addSublayer(lineLayer)

        startTimeInterval = Date.timeIntervalSinceReferenceDate
        displayLink.isPaused = false
    }

    @objc private func updateTimer() {
        let elapsed: TimeInterval = Date.timeIntervalSinceReferenceDate - startTimeInterval
        let progress: CGFloat = (elapsed > duration) ? 1.0 : CGFloat(elapsed / duration)
        let computedProgress: CGFloat
        if let (p1, p2) = points {
            let t: CGFloat = progress
            // cubic bezier
            computedProgress = 3.0 * (1.0 - t) * (1.0 - t) * t * p1.y + 3 * (1.0 - t) * t * t * p2.y + t * t * t
        } else {
            computedProgress = progress
        }
        let percentage: Int = Int(computedProgress * matching)
        percentageLabel.text = "\(percentage)"
        lineLayer.strokeEnd = computedProgress

        if progress == 1.0 {
            displayLink.isPaused = true
        }
    }
}
