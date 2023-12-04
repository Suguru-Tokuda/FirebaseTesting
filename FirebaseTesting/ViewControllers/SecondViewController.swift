//
//  SecondViewController.swift
//  FirebaseTesting
//
//  Created by Suguru Tokuda on 12/4/23.
//

import UIKit

class SecondViewController: UIViewController {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Second View"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        return label
    }()
    
    var crashBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        btn.setTitleColor(.label, for: .normal)
        btn.layer.borderColor = UIColor.systemBlue.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        btn.layer.backgroundColor = UIColor.systemBlue.cgColor
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.setTitle("Crash", for: .normal)

        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension SecondViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(crashBtn)
        
        crashBtn.addTarget(self, action: #selector(handleCrashBtnTap), for: .touchUpInside)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        let titleLabelConstraints = [
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.2)
        ]
        
        let crashBtnConstraints = [
            crashBtn.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            crashBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            crashBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]

        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(crashBtnConstraints)
    }
}

extension SecondViewController {
    @objc func handleCrashBtnTap() {
        assert(1 == 2, "Maths failure!")
    }
}
