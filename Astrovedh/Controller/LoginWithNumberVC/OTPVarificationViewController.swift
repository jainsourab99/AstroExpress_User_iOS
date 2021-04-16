//
//  OTPVarificationViewController.swift
//  Astrovedh
//
//  Created by Sourabh Jain on 24/03/21.
//  Copyright © 2021 Krash. All rights reserved.
//

import UIKit
import FirebaseAuth

class OTPVarificationViewController: UIViewController {
    
    //  MARK:- IBOutlets
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var enterOTPTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    var enteredEmailAddress: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    //  MARK:- UISetup
    
    private func setupUI() {
        self.loginBtn.layer.cornerRadius = 5
        self.loginBtn.layer.borderWidth = 3
        self.loginBtn.layer.borderColor = UIColor.black.cgColor
        emailLabel.text = enteredEmailAddress
        self.enterOTPTextField.keyboardType = .phonePad
        self.enterOTPTextField.becomeFirstResponder()
    }
    
    //  MARK:- IBActions
    
    @IBAction func onClickBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickContinueBtn(_ sender: UIButton) {
        
        guard let otpCode = enterOTPTextField.text else { return }
        if otpCode.count < 6 {
            Toast.short(message: "Please enter valid otp code", success: "1", failer: "0")
            return
        } else {
            guard let verificationID = userDefaults.string(forKey: ConstantKeys.verificationIDKey) else {return}
            userDefaults.setValue(true, forKey: ConstantKeys.isOTPVerifiedKey)
            let crendential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: otpCode)
            
            Auth.auth().signIn(with: crendential) { (success, error) in
                if error == nil {
                    print(success)
                    print("user sign in..")
                    guard let DashBoardVC = self.storyboard?.instantiateViewController(withIdentifier: ConstantKeys.DashBoardVC) as? DashBoardViewController else{return}
//                    RegistrationFormVC.emailAddress = self.enteredEmailAddress
//                    let navigationHomeVc = UINavigationController(rootViewController: DashBoardVC)
//                    navigationHomeVc.modalPresentationStyle = .fullScreen
                    self.present(DashBoardVC, animated: true, completion: nil)
                    
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
        //        guard let RegistrationFormVC = storyboard?.instantiateViewController(withIdentifier: ConstantKeys.RegistrationFormVC) as? RegistrationFormViewController else{return}
        //        RegistrationFormVC.emailAddress = enteredEmailAddress
        //        self.present(RegistrationFormVC, animated: true, completion: nil)
    }
    
    
}
