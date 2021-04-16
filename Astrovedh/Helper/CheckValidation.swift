//
//  CheckValidation.swift
//  Astrovedh
//
//  Created by Sourabh Jain on 17/03/21.
//  Copyright © 2021 Krash. All rights reserved.
//

import Foundation
import UIKit

class CheckValidation {
    static let sharedInstance = CheckValidation()
    let emailCheckMsg = "Please enter valid email address"
    let isValidPasswordMsg = "The password should contain at least 8 characters, including at least one lower case letter, one upper case letter, one number and one punctuation mark"
    let reEnterPasswordMsg = "Please re-enter the password"
    
    //MARK: - Method for Validation phone and Email
    func isValidPhoneNo(value: String) -> Bool {
        let PHONE_REGEX = "^[0-9]{8,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    func isValidPassword(withString password : String) -> Bool {

            let passwordreg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*]).{8,}")
            let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
            return passwordtesting.evaluate(with: password)
        }
}
