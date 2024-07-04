//
//  AlertVC.swift
//  GetMoviesUIKit
//
//  Created by Medunan Skyraan  on 04/07/24.
//

import Foundation
import UIKit

class AlertVC: UIViewController {
    
    let containerView = UIView()
    let titleLabel1 = OBTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel1 = OBTitleLabel(textAlignment: .center, fontSize: 15)
    let actionButton = OBButton(backgroundColor: .systemPink, title: "Ok")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle  = title
        self.message     = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()

    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel1)
        titleLabel1.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel1.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel1.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel1.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureActionButton() {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel1)
        messageLabel1.text = message ?? "Unable to complete request"
        messageLabel1.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel1.topAnchor.constraint(equalTo: titleLabel1.bottomAnchor, constant: 8),
            messageLabel1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel1.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel1.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }


}
