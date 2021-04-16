//
//  MsgTextField.swift
//  Astrovedh
//
//  Created by Sourabh Jain on 16/03/21.
//  Copyright © 2021 Krash. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
open class MsgTextField: UITextField, UITextFieldDelegate{
    
    override open func prepareForInterfaceBuilder() {
        setPaddingView()
        setBottamBorder()
    }

    func setPaddingView(){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setBottamBorder(){
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = 0.0
           }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setPaddingView()
        setBottamBorder()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setPaddingView()
        setBottamBorder()
    }
    
    
}
