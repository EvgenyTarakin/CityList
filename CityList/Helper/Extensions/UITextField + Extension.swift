//
//  UITextField + Extension.swift
//  CityList
//
//  Created by Евгений Таракин on 24.07.2025.
//

import UIKit

extension UITextField {
    func set() {
        textColor = .black
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        hideHelpWord()
        setLeftPadding()
        addToolBarWithDoneButton()
    }
    
    func hideHelpWord() {
        autocorrectionType = .no
        spellCheckingType = .no
        keyboardAppearance = .light
    }
    
    func setLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    func addToolBarWithDoneButton() {
        let toolbar = UIToolbar()
        toolbar.backgroundColor = .white
        toolbar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                          target: nil,
                                          action: nil)
        let doneButton = UIBarButtonItem(title: "Готово",
                                         style: .done,
                                         target: self,
                                         action: #selector(doneButtonAction))
        toolbar.setItems([spaceButton, doneButton], animated: false)
        autocorrectionType = .no
        spellCheckingType = .no
        inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction() {
        resignFirstResponder()
    }
}
