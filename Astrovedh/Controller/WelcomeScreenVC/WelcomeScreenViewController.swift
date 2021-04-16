//
//  WelcomeScreenViewController.swift
//  Astrovedh
//
//  Created by Sourabh Jain on 15/03/21.
//

import UIKit
import Firebase
import FirebaseAuth

let userDefaults = UserDefaults.standard

class WelcomeScreenViewController: UIViewController {
    var messageController: MessagesController?
    
    
    //  MARK:- IBOutlets
    
    @IBOutlet weak var loginBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginBtn.layer.cornerRadius = 5
        self.checkIfUserIsLoggedIn()
    }
    
    //  MARK:- IBActions
    
    @IBAction func onClickloginBtn(_ sender: UIButton) {
        guard let LoginSignupVC = storyboard?.instantiateViewController(withIdentifier: ConstantKeys.LoginSignupVC) as? LoginSignupWithNumberViewController else {return}
        
        self.present(LoginSignupVC, animated: true, completion: nil)
    }
    
    func checkIfUserIsLoggedIn() {
        
        let mobileNumber = userDefaults.value(forKey: ConstantKeys.mobileNumberKey) as? String
        let isOTPVerified = userDefaults.value(forKey: ConstantKeys.isOTPVerifiedKey) as? Bool
//        let user = Auth.auth().currentUser
        if (mobileNumber != nil && isOTPVerified != nil) {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "welcomeScreenSeque", sender: nil)
//                guard let DashBoardVC = self.storyboard?.instantiateViewController(withIdentifier: ConstantKeys.DashBoardVC) as? DashBoardViewController else{return}
////                let navigationHomeVc = UINavigationController(rootViewController: DashBoardVC)
//                    self.definesPresentationContext = true
//                  DashBoardVC.modalPresentationStyle = .overCurrentContext
////                navigationHomeVc.modalPresentationStyle = .fullScreen
//                self.present(DashBoardVC, animated: true, completion: nil)
////                self.present(DashBoardVC, animated: false, completion: nil)
            }
            return
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "welcomeScreenSeque" {
            
            if let destVC = segue.destination as? UINavigationController,
                        let targetController = destVC.topViewController as? DashBoardViewController {
//                targetController.title = "AstroExpress"
                
                    }
        }
    }


}

