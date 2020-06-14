//
//  AuthorDetailsEmptyView.swift
//  TheBlog
//
//  Created by Marcio Garcia on 10/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit
import DesignSystem

class AuthorDetailsEmptyView: UIView {

    typealias actionHandlerType = (UIButton) -> Void
    private lazy var messageLabel: UILabel = { return UILabel() }()
    private lazy var actionButton: UIButton = { return UIButton() }()
    private var messageText: String
    private var actionTitle: String?
    private var actionHandler: actionHandlerType?
    private var shouldDisplayActionButton = false

    init(messageText: String, actionTitle: String?, actionHandler: actionHandlerType?) {
        self.messageText = messageText
        self.actionTitle = actionTitle
        self.actionHandler = actionHandler
        super.init(frame: CGRect.zero)

        if actionTitle != nil && actionHandler != nil {
            self.shouldDisplayActionButton = true
        }

        setupViewConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view should be implemented with view coding")
    }

    // MARK: Actions

    @objc func actionButtonTapped(_ sender: UIButton) {
        actionHandler?(sender)
    }
}

extension AuthorDetailsEmptyView: ViewCodingProtocol {
    func buildViewHierarchy() {
        addSubview(messageLabel)
        if shouldDisplayActionButton {
            addSubview(actionButton)
        }
    }

    func setupConstraints() {
        messageLabel.constraint {[
            $0.centerYAnchor.constraint(equalTo: centerYAnchor),
            $0.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]}

        if shouldDisplayActionButton {
            actionButton.constraint {[
                $0.centerXAnchor.constraint(equalTo: centerXAnchor),
                $0.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16)
            ]}
        }
    }

    func configureViews() {
        messageLabel.text = messageText

        if shouldDisplayActionButton {
            actionButton.setTitle(actionTitle, for: .normal)
            actionButton.setTitleColor(.blue, for: .normal)
            actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        }
    }
}
