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

    override func viewDidLoad() {
        super.viewDidLoad()

        progressView2.points = (p1: CGPoint(x: 0.51, y: 0.01), p2: CGPoint(x: 0.61, y: 1.01))

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.progressView1.startAnimation()
            self.progressView2.startAnimation()
        }
    }
}
