//
//  RegistrationFormViewController.swift
//  Astrovedh
//
//  Created by Sourabh Jain on 16/03/21.
//  Copyright © 2021 Krash. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegistrationFormViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
        
    let registerFormPlaceholnder: [String] = ["Name", "Address", "Mobile Number", "Landline number", "dob", "bachlerors degree", "master's degree", "any other qualification", "email id", "Skills", "Experience", "Long bio", "Short bio", "Are you working or any other portel? if yes then name them", "certificate of skills", "Account details", "Adhaar Number", "PAN number", "photograph for profiles", "languages Known", "father's / husband's name", "an introduction short video about yourself", "Number you wish to spend on the app"]
    //  MARK:- IBOutlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var landlineNumberTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var bachlerordegreeTextField: UITextField!
    @IBOutlet weak var masterdegreeTextField: UITextField!
    @IBOutlet weak var anyOtherdegreeTextField: UITextField!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var skillsTextField: UITextField!
    @IBOutlet weak var experienceTextField: UITextField!
    @IBOutlet weak var longBioTextField: UITextField!
    @IBOutlet weak var shortBioTextField: UITextField!
    @IBOutlet weak var workinganywereTextField: UITextField!
    @IBOutlet weak var certificateTextField: UITextField!
    @IBOutlet weak var accountDetailsTextField: UITextField!
    @IBOutlet weak var adhaarNumberTextField: UITextField!
    @IBOutlet weak var PANNoTextField: UITextField!
    @IBOutlet weak var PhotoTextField: UITextField!
    @IBOutlet weak var languageKnownTextField: UITextField!
    @IBOutlet weak var fatherNameTextField: UITextField!
    @IBOutlet weak var introVideoTextField: UITextField!
    @IBOutlet weak var numberSpendTextField: UITextField!
    
    @IBOutlet weak var SubmitBtn: UIButton!
    
    var emailAddress: String = String()
//    var FIRUid: String = String()
    var mobileNumber = String()
    
    let alertMSG: String = "Once admin approves your request you will be able to use the app"

    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    //  MARK:- UISetup
    private func setupUI() {
        if let phoneNumber = userDefaults.object(forKey: ConstantKeys.mobileNumberKey) as? String {
//        let uid = userDefaults.object(forKey: ConstantKeys.uid) as? String{
//            emailAddress = email
            mobileNumber = phoneNumber
//            FIRUid = uid
        }
        self.SubmitBtn.layer.cornerRadius = 5
        nameTextField.placeholder = "Name"
        addressTextField.placeholder = "Address"
        self.mobileNumberTextField.placeholder = "Mobile Number"
        self.landlineNumberTextField.placeholder = "Landline Number"
        self.dobTextField.placeholder = "DOB"
        self.bachlerordegreeTextField.placeholder = "Bachleror's degree"
        self.masterdegreeTextField.placeholder = "Master's degree"
        self.anyOtherdegreeTextField.placeholder = "any other qualification"
        self.emailIdTextField.placeholder = "email id"
        self.skillsTextField.placeholder = "Skills"
        self.experienceTextField.placeholder = "Experience"
        self.longBioTextField.placeholder = "Long Bio"
        self.shortBioTextField.placeholder = "Short Bio"
        self.workinganywereTextField.placeholder = "Are you working or any other portel? if yes then name them"
        self.certificateTextField.placeholder = "certificate of skills"
        self.accountDetailsTextField.placeholder = "Account details"
        self.adhaarNumberTextField.placeholder = "Adhaar Number"
        self.PANNoTextField.placeholder = "PAN Number"
        self.PhotoTextField.placeholder = "photograph for profiles"
        self.languageKnownTextField.placeholder = "languages Known"
        self.fatherNameTextField.placeholder = "father's / husband's name"
        self.introVideoTextField.placeholder = "an introduction short video about yourself"
        self.numberSpendTextField.placeholder = "Number you wish to spend on the app"
        
        self.mobileNumberTextField.text = mobileNumber
    }
    
    //  MARK:- IBActions
    
    @IBAction func onClickBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func onClickSubmitBtn(_ sender: UIButton) {
        guard let userName = nameTextField.text else{return}
//        guard let userName = nameTextField.text else{return}

        let alertController = UIAlertController(title: "Successfully registered!!", message: alertMSG, preferredStyle: .actionSheet)
        guard let FIRuser = Auth.auth().currentUser?.uid else{return}
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (UIAlertActionOK) in
            self.addUserinFirebase(uid: FIRuser, userName: userName)
            guard let DashBoardVC = self.storyboard?.instantiateViewController(withIdentifier: ConstantKeys.DashBoardVC) as? DashBoardViewController else{return}
            self.present(DashBoardVC, animated: true, completion: nil)

        }
        
        let cancelBtn = UIAlertAction(title: "Exit", style: .cancel) { (UIAlertActionCancel) in}
        
        alertController.addAction(okAction)
        alertController.addAction(cancelBtn)
        
        self.present(alertController, animated: true, completion: nil)

        
        
    }
    
    func addUserinFirebase(uid: String, userName: String) {
        userDefaults.setValue(userName, forKey: ConstantKeys.displayName)
        userDefaults.synchronize()
            let time = [".sv": "timestamp"]
    
            let userDetails = [
                "createdAt": time,
                "name": userName,
                "email": emailAddress,
                "OSType": "iPhone"
    
            ] as Dictionary<String,Any>
        
        Database.database().reference().child("Users").child(uid).setValue(userDetails)
        }

}

