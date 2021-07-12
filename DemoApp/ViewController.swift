//
//  ViewController.swift
//  DemoApp
//
//  Created by Ramon Torres on 6/14/21.
//  Copyright (c) 2021 Ramon Torres
//

import UIKit
import Markly

class ViewController: UIViewController {

    let textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.dataDetectorTypes = .link
        return textView
    }()

    override func viewDidLoad() {
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = .systemBackground
        } else {
            self.view.backgroundColor = .white
        }

        view.addSubview(textView)

        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            textView.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16)
        ])

        let text = "Features:\n" +
                   "\n" +
                   "* It supports lists\n" +
                   "* Like *this* one\n" +
                   "\n" +
                   "It also supports *bold text*.\n" +
                   "\n" +
                   "Links are handled by the data detector:\n" +
                   "\n" +
                   "https://github.com/"

        textView.attributedText = NSAttributedString.markly(text)
    }

}
