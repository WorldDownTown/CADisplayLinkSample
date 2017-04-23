//
//  ViewController.swift
//  CADisplayLinkSample
//
//  Created by Keisuke Shoji on 2017/04/20.
//  Copyright © 2017年 Keisuke Shoji. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var progressView1: ProgressView!
    @IBOutlet private weak var progressView2: ProgressView!
    @IBOutlet private weak var progressView3: ProgressView!
    @IBOutlet private weak var progressView4: ProgressView!
    @IBOutlet private weak var progressView5: ProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.progressView1.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)

            self.progressView2.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)

            self.progressView3.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)

            self.progressView4.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

            self.progressView5.timingFunction = CAMediaTimingFunction(controlPoints: 0.51, 0.01, 0.61, 1.01)
            self.progressView5.points = (p1: CGPoint(x: 0.51, y: 0.01), p2: CGPoint(x: 0.61, y: 1.01))
        }
    }
}
