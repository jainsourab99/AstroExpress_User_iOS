//
//  WalletsViewController.swift
//  Astrovedh
//
//  Created by Sourabh Jain on 16/04/21.
//  Copyright © 2021 Krash. All rights reserved.
//

import UIKit

class WalletsViewController: UIViewController {
    
    //  MARK:- IBOUtlets
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var rechargeLabel: UILabel!
    @IBOutlet weak var rechargeBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    //  MARK:- SetupUI
    
    private func setupUI() {
        rechargeBtn.layer.cornerRadius = 5
        rechargeBtn.layer.borderWidth = 2
    }
    

}
