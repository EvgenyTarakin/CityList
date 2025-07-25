//
//  UISheetPresentationController + Extension.swift
//  WebcamChecker
//
//  Created by Евгений Таракин on 13.01.2025.
//

import UIKit

extension UISheetPresentationController.Detent {
    static func fix(_ value: CGFloat) -> UISheetPresentationController.Detent {
        .custom(identifier: Identifier("Fraction:\(value)")) { context in
            return value
        }
    }
}
