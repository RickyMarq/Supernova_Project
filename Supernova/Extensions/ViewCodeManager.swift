//
//  ViewCodeManager.swift
//  01
//
//  Created by Henrique Marques on 17/10/22.
//

import UIKit

public protocol ViewCode {
    func initViewCode()
    func configureSubViews()
    func configureConstraints()
    func configureAdditionalBehaviors()
    func configureAccessibility()
}

public extension ViewCode {
    func initViewCode() {
        configureSubViews()
        configureConstraints()
        configureAdditionalBehaviors()
        configureAccessibility()
    }
}

