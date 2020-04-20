//
//  SignUpViewController.swift
//  NetworkSignUp
//
//  Created by 이성근 on 13/03/2020.
//  Copyright © 2020 Draw_corp. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!

    @IBOutlet weak var emailTextFiled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.layer.cornerRadius = signUpButton.layer.bounds.size.height / 2
    }

    @IBAction func signUpAction(_ sender: Any) {
        let param = ["name" : nameTextFiled.text ?? "" ,
                    "password" : passwordTextFiled.text ?? "",
                    "email" : emailTextFiled.text ?? ""
                    ]
        guard let url = URL(string: "http://localhost:3000/userInfo") else {return}
        var request = URLRequest.init(url:url)
        request.httpMethod = "POST"
        request.httpBody = param.queryString.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { (data, httpresponse, error) in
            if let data = data {
                do{
                    let encoder = JSONDecoder()
                    let user = try encoder.decode(LoginUser.self, from: data)
                    UserInfo.shared.info = user
                    print("data == > \(user)")
                    NotificationCenter.default.post(name: .loginSucess, object: nil)

                    DispatchQueue.main.async {                                            self.dismiss(animated: true, completion: nil)
                    }

                }catch{
                    print("ERROR -> \(error)")
                }
            }
        }.resume()


        
    }

    @IBAction func dismissAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
