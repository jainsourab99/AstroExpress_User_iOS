//
//  EditProfileViewController.swift
//  Astrovedh
//
//  Created by Sourabh Jain on 14/04/21.
//  Copyright © 2021 Krash. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class EditProfileViewController: UIViewController {
    
    //  MARK:- IBOutlets
    @IBOutlet weak var saveDetailsBtn: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var birthTimeTextField: UITextField!
    @IBOutlet weak var BirthPlaceTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    //  MARk:- SetupUI
    
    private func setupUI() {
        saveDetailsBtn.layer.cornerRadius = 5
        if let number = userDefaults.object(forKey: ConstantKeys.mobileNumberKey) as? String {
            phoneTextField.text = "\(number)"
        }
    }

}
