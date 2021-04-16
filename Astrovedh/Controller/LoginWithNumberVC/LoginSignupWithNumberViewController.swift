//
//  LoginSignupViewController.swift
//  Astrovedh
//
//  Created by Sourabh Jain on 16/03/21.
//  Copyright © 2021 Krash. All rights reserved.
//

import UIKit
import FirebaseAuth
import CountryPickerView
//let userTableName = "Users"
let userTableName = "Astrologers"

let chatTableName = "chats"
let databaseURL = "https://astrovedh-67f19-default-rtdb.firebaseio.com"

class LoginSignupWithNumberViewController: UIViewController {
    
    //  MARK:- IBOutlets
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    @IBOutlet weak var loginSignupBtn: UIButton!
    
    var countryDetail: String = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    //  MARK:- Setup UI
    
    private func setupUI() {
        
        self.loginSignupBtn.layer.cornerRadius = 5
        
        countryCodeTextField.layer.borderColor = UIColor.black.cgColor
        countryCodeTextField.layer.borderWidth = 2
        
        mobileNumberTextField.layer.borderColor = UIColor.black.cgColor
        mobileNumberTextField.layer.borderWidth = 2
        
        let cpv = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
        countryDetail = cpv.selectedCountry.phoneCode
        
        countryCodeTextField.leftView = cpv
        countryCodeTextField.leftViewMode = .always
        
        self.mobileNumberTextField.keyboardType = UIKeyboardType.numberPad
        self.mobileNumberTextField.becomeFirstResponder()
        
        
    }
    
    //  MARK:- IBActions
    
    @IBAction func onClickBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickLoginBtnPressed(_ sender: UIButton) {
        if((mobileNumberTextField.text?.isEmpty)! || !CheckValidation.sharedInstance.isValidPhoneNo(value: mobileNumberTextField.text!)){
            Toast.short(message: "Please enter valid Mobile Number", success: "1", failer: "0")
            return
        } else {
            //            guard let registerFormVC = storyboard?.instantiateViewController(withIdentifier: ConstantKeys.RegistrationFormVC) as? RegistrationFormViewController else{return}
            ////            registerFormVC.mobileNumber = "\((countryDetail?.phoneCode)!)\(mobileNumberTextField.text!)"
            //            self.present(registerFormVC, animated: true, completion: nil)
            guard let mobileNumber = mobileNumberTextField.text else{return}
            let mobileNumberWithCode = "\(countryDetail)\(mobileNumber)"
            userDefaults.setValue(mobileNumberWithCode, forKey: ConstantKeys.mobileNumberKey)
            
            PhoneAuthProvider.provider().verifyPhoneNumber("\(countryDetail)\(mobileNumber)", uiDelegate: nil) { (verificationID, error) in
                if error == nil {
                    // Do Something
                    print("verification Code",verificationID?.debugDescription ?? "None")
                    guard let id = verificationID else{return}
                    userDefaults.setValue(id, forKey: ConstantKeys.verificationIDKey)
                    userDefaults.synchronize()
                    guard let OTPVarificationVC = self.storyboard?.instantiateViewController(withIdentifier: ConstantKeys.OTPVarificationVC) as? OTPVarificationViewController else{return}
                    //            registerFormVC.mobileNumber = "\((countryDetail?.phoneCode)!)\(mobileNumberTextField.text!)"
                    self.present(OTPVarificationVC, animated: true, completion: nil)
                } else {
                    print("Unable to get secret Verification Number: \(error?.localizedDescription)")
                }
            }
        }
        
    }
    
    
}
