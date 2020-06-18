//
//  MessageFeedCell.swift
//  LoveverySampleApp
//
//  Created by Corey Davis on 6/15/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

class MessageFeedCell: UITableViewCell {

    // MARK: - Properties

    static let identifier: String = "messageCell"

    lazy var container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .lightGray
        container.layer.cornerRadius = 5.0

        return container
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5.0

        return stackView
    }()

    lazy var titleStack: UIStackView = {
        let titleStack = UIStackView()
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        titleStack.axis = .horizontal
        titleStack.distribution = .fillEqually
        titleStack.spacing = 5.0

        return titleStack
    }()

    lazy var userLabel: UILabel = {
        let userLabel = UILabel()
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        userLabel.font = UIFont(name: "Avenir-Book-Bold", size: 15)
        userLabel.contentMode = .center
        userLabel.layer.borderColor = UIColor.black.cgColor
        userLabel.layer.borderWidth = 1.0
        userLabel.layer.cornerRadius = 5.0
        userLabel.textAlignment = .center

        return userLabel
    }()

    lazy var subjectLabel: UILabel = {
        let subjectLabel = UILabel()
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        subjectLabel.font = UIFont(name: "Avenir-Book", size: 12)
        subjectLabel.textAlignment = .center

        return subjectLabel
    }()

    lazy var messageTextView: UITextView = {
        let messageTextView = UITextView()
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
        messageTextView.font = UIFont(name: "Avenir-Book", size: 12)
        messageTextView.layer.borderColor = UIColor.black.cgColor
        messageTextView.layer.borderWidth = 1.0
        messageTextView.layer.cornerRadius = 5.0
        messageTextView.setContentCompressionResistancePriority(.required, for: .vertical)

        return messageTextView
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Lifecycle

    override func layoutSubviews() {
        applyDesign()
    }

    // MARK: - Public

    /// configure cell with a MessageResponse object
    /// - Parameter message: MessageResponse to use for configuration
    func configure(with message: Message?) {
        userLabel.text = message?.userName.capitalized
        subjectLabel.text = message?.details.subject?.uppercased()
        messageTextView.text = message?.details.message
    }
}

extension MessageFeedCell {

    // MARK: - Design

    private func applyDesign() {
        addContainer()
        addStackView()
        addTitleStack()
        addUserLabel()
        addSubjectLabel()
        addMessageTextView()
    }

    private func addContainer() {
        contentView.addSubview(container)
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            container.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }

    private func addStackView() {
        container.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5),
            stackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -5)
        ])
    }

    /// add title stack view to the top of the cell
    private func addTitleStack() {
        stackView.addArrangedSubview(titleStack)
    }

    /// add userName label to the left of the titleStack view
    private func addUserLabel() {
        titleStack.addArrangedSubview(userLabel)
    }

    /// add subject lable to the right of the titleStack view
    private func addSubjectLabel() {
        titleStack.addArrangedSubview(subjectLabel)
    }

    /// add messageTextView to the bottom of the stackContainer view
    private func addMessageTextView() {
        stackView.addArrangedSubview(messageTextView)
        NSLayoutConstraint.activate([
            messageTextView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            messageTextView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
            messageTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
