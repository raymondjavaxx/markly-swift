//
//  ViewController.swift
//  DemoApp
//
//  Created by Ramon Torres on 6/14/21.
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
        self.view.backgroundColor = .systemBackground

        view.addSubview(textView)

        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
            textView.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16)
        ])

        let text = "Features:\n\n* It supports lists\n* Like *this* one\n\nIt also supports *bold text*."
        print(NSAttributedString.markly(text))
        textView.attributedText = .markly(text)
    }

}
