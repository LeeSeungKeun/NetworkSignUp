//
//  ViewController.swift
//  NetworkSignUp
//
//  Created by 이성근 on 13/03/2020.
//  Copyright © 2020 Draw_corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userInfo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabel), name: .loginSucess, object: nil)
    }

    @objc func updateLabel(){
        DispatchQueue.main.async {
            self.userInfo.text = UserInfo.shared.info.email
        }
    }

    @IBAction func signInSeugeAction(_ sender: Any) {
        let signInVC = UIStoryboard(name: "SignInVC", bundle: nil).instantiateViewController(identifier: "naviSignIn")
        self.present(signInVC, animated: true, completion: nil)
        
    }
}

