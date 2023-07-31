//
//  ViewController.swift
//  TodoApp
//
//  Created by Jinyong Park on 2023/07/31.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let centerY = self.view.center.y - titleLabel.bounds.height - 20
        let scaling = CGAffineTransform(scaleX: 2.0, y: 2.0)
        let translation = CGAffineTransform(translationX: 0, y: centerY)
        self.titleLabel.transform = scaling.concatenating(translation)

        UIView.animate(
            withDuration: 1.0,
            delay: 0.5,
            usingSpringWithDamping: 100,
            initialSpringVelocity: 10
        ) {
            self.titleLabel.transform = .identity
        }
    }
}
