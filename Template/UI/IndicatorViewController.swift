//
//  IndicatorViewController.swift
//  Template
//
//  Created by junya kitayama on 2020/02/07.
//  Copyright © 2020 justwork. All rights reserved.
//

import UIKit

class IndicatorViewController: UIViewController {

    @IBOutlet private weak var indicator: UIActivityIndicatorView! {
        didSet {
            if #available(iOS 13.0, *) {
                self.indicator.style = .large
            } else {
                self.indicator.style = .whiteLarge
            }
        }
    }
    
    @IBOutlet private weak var messageLabel: UILabel!

    func setMessage(message: String) {
        messageLabel.isHidden = false
        messageLabel.text = message
    }
}
