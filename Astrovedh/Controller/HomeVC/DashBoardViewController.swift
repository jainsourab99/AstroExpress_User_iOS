//
//  DashBoardViewController.swift
//  Astrovedh
//
//  Created by Sourabh Jain on 27/03/21.
//  Copyright © 2021 Krash. All rights reserved.
//

import UIKit

class DashBoardViewController: UIViewController {
    var messageController : MessagesController?

    
    //  MARK:- IBOutlets
    @IBOutlet weak var displayCollectionView: UICollectionView!
    
    var labelText: Array<String> = ["Chat", "Call", "Get Detailed Report", "Query"]

    
//    @IBOutlet weak var chatBtn: UIButton!
//    @IBOutlet weak var callBtn: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .blue
        
        self.setupUI()
    }
    
    //  MARk:- SetupUI
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        tabBarItem.title = "Home"
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 5
        displayCollectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    //  MARK:- IBActions
    
//    @IBAction func onClickChatBtn(_ sender: UIButton) {
//        let MessageController = MessagesController()
////        newMessageController.messagesController = self
//        // put user name onto nav bar
//        self.messageController?.fetchUserAndSetupNavbarTitle()
//        self.messageController?.observeUserMessages()
//        let navController = UINavigationController(rootViewController: MessageController)
//        navController.modalPresentationStyle = .fullScreen
//        present(navController, animated: true, completion: nil)
//    }


}

extension DashBoardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labelText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  let cell: DashBoardCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashBoardCollectionViewCell", for: indexPath) as? DashBoardCollectionViewCell {
            cell.cellLabel.text = labelText[indexPath.row]
            cell.layer.cornerRadius = 15
            return cell
        } else {
            return DashBoardCollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexPath = indexPath.row
        switch indexPath {
        case cellSellectiondidTap.Chat.rawValue:
            debugPrint(cellSellectiondidTap.Chat.rawValue)
            
            let MessageController = MessagesController()
            //        newMessageController.messagesController = self
            // put user name onto nav bar
            self.messageController?.fetchUserAndSetupNavbarTitle()
            self.messageController?.observeUserMessages()
            //            let navController = UINavigationController(rootViewController: MessageController)
            //            navController.modalPresentationStyle = .fullScreen
            MessageController.hidesBottomBarWhenPushed = true

            self.navigationController?.pushViewController(MessageController, animated: true)
        
//        case cellSellectiondidTap.offers.rawValue:
//            if let offerVC = storyboard?.instantiateViewController(withIdentifier: ConstantKeys.UserOffersVC) as? UserOffersViewController {
//                offerVC.title = "Offers"
//                self.navigationController?.pushViewController(offerVC, animated: true)
//            }
            
//        case cellSellectiondidTap.Query.rawValue:
//            if let queryVC = storyboard?.instantiateViewController(withIdentifier: ConstantKeys.UserQueryViewController) as? UserQueryViewController {
//                queryVC.title = "Query"
//                self.navigationController?.pushViewController(queryVC, animated: true)
//            }
//
//        case cellSellectiondidTap.Settings.rawValue:
//            if let settingVC = storyboard?.instantiateViewController(withIdentifier: ConstantKeys.SettingViewController) as? SettingViewController {
//                settingVC.title = "Settings"
//                self.navigationController?.pushViewController(settingVC, animated: true)
//            }
        default:
            Toast.short(message: "Page under Construction", success: "1", failer: "0")
        }
    }
    
}

extension DashBoardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 20.0, bottom: 30, right: 20.0)//here your custom value for spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem - 30, height:widthPerItem - 50)
    }
}


enum cellSellectiondidTap: Int {
    case Chat = 0, Call, GetDetailReview, Query
    
}
