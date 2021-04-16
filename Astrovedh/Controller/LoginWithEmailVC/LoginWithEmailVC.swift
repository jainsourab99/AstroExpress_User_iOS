//
//  LoginWithEmailVC.swift
//  Astrovedh
//
//  Created by Sourabh Jain on 22/03/21.
//  Copyright © 2021 Krash. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginWithEmailVC: UIViewController {
    let userDefaults = UserDefaults.standard
    
    //  MARK:- IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reEnterPasswordTextField: UITextField!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var loginSignupBtn: UIButton!




    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    //  MARK:- Setup UI
    
    private func setupUI() {
        self.loginSignupBtn.layer.cornerRadius = 5
        passwordTextField.isSecureTextEntry = true
        reEnterPasswordTextField.isSecureTextEntry = true
    }
    
    //  MARK:- IBActions
    
    @IBAction func onClickloginBtn(_ sender: UIButton) {
        
        guard let emailAddress = emailTextField.text else{return}
        guard let password = passwordTextField.text else{return}
        guard let reEnterPassword = reEnterPasswordTextField.text else{return}
        
        if CheckValidation.sharedInstance.isValidEmailAddress(emailAddressString: emailAddress) == false {
            Toast.short(message: CheckValidation.sharedInstance.emailCheckMsg , success: "1", failer: "0")
            return
        } else if CheckValidation.sharedInstance.isValidPassword(withString: password) == false {
            Toast.long(message: CheckValidation.sharedInstance.isValidPasswordMsg , success: "1", failer: "0")
            return
        } else if reEnterPassword != password {
            Toast.long(message: CheckValidation.sharedInstance.reEnterPasswordMsg , success: "1", failer: "0")
            return
        }
        else {
            //  Get auth instance
            //  attemt sing in
            FirebaseAuth.Auth.auth().signIn(withEmail: emailAddress, password: password) { [weak self] (result, error) in
                guard let strongSelf = self else {
                    return
                }
                guard error == nil else {
                    //  show account creation
                    strongSelf.showCreateAccount(email: emailAddress, password: password)
                    
                    return
                }
                print("You have signed in")
                guard let OTPVarificationVC = strongSelf.storyboard?.instantiateViewController(withIdentifier: ConstantKeys.RegistrationFormVC) as? RegistrationFormViewController else{return}
        //        registerFormVC.mobileNumber = "\((countryDetail?.phoneCode)!)\(mobileNumberTextField.text!)"
                OTPVarificationVC.emailAddress = emailAddress
                strongSelf.present(OTPVarificationVC, animated: true, completion: nil)
            }
 
        }

    }
    
    //  If account does not exist
    func showCreateAccount(email: String, password: String) {
        let alert = UIAlertController(title: "Create account", message: "Would you like to create an account", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { [weak self](alert) in
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                guard let strongSelf = self else {
                    return
                }
                guard error == nil else {
                    //  show account creation
                    
                    return
                }
                guard let OTPVarificationVC = strongSelf.storyboard?.instantiateViewController(withIdentifier: ConstantKeys.RegistrationFormVC) as? RegistrationFormViewController else{return}
        //        registerFormVC.mobileNumber = "\((countryDetail?.phoneCode)!)\(mobileNumberTextField.text!)"
                OTPVarificationVC.emailAddress = email
                let user = Auth.auth().currentUser
                let uid = user?.uid
                    strongSelf.userDefaults.setValue(email, forKey: ConstantKeys.emailIDKey)
                        strongSelf.userDefaults.setValue(password, forKey: ConstantKeys.passwordKey)
                strongSelf.userDefaults.setValue(uid, forKey: ConstantKeys.uid)
//                strongSelf.addUserinFirebase(uid: uid)
                    strongSelf.userDefaults.synchronize()

                

                strongSelf.present(OTPVarificationVC, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert) in
            
        }))
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func onClickBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
//    func addUserinFirebase(uid: String?) {
//        let time = [".sv": "timestamp"]
//
//        let userDetails = [
//            "createdAt": time,
//
//        ]
//
//    }
    


}
