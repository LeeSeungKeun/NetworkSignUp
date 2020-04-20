//
//  SignInViewController.swift
//  NetworkSignUp
//
//  Created by 이성근 on 13/03/2020.
//  Copyright © 2020 Draw_corp. All rights reserved.
//

import UIKit



extension Notification.Name {
     static let loginSucess = Notification.Name(rawValue: "loginSucess")
    static let logOut = Notification.Name(rawValue: "logOut")
}

class SignInViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!

    @IBOutlet weak var userNameTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.layer.cornerRadius = signInButton.bounds.size.height/2
        self.navigationController?.setNavigationBarHidden(true, animated: false)

    }

    func isLoginInfo(_ isUser : Bool) {
        DispatchQueue.main.async {
            if isUser == false {
                let alert = UIAlertController(title: "아이디 또는 패스워드가 잘못되었습니다.", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction.init(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true , completion: nil)
            }else {
//                NotificationCenter.default.post((name: Notification.Name(rawValue: "loginSucess"))
                NotificationCenter.default.post(name: Notification.Name.loginSucess, object: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    @IBAction func signInAPICall(_ sender: Any) {
        // paramter 가공
        // get -- post
        // URLSession NetWork 통신
        let param = ["name": userNameTextFiled.text ?? "",
                     "password" : passwordTextFiled.text ?? ""]
        // query string key:vaue&key:value -> 쿼리스트링이라고 한다.
        let url = "http://localhost:3000/userInfo"
        // my localhost url -> http://localhost:3000/userInfo

        var loginURL = URLComponents(string: url)

        loginURL?.query = param.queryString

        // 순서
        // 1. URLComponents
        // 2. URLComponets.query = 파라미터
        // 3. URLComponets.URL 로 url 을 완성사킨다.
        // 4. URLSession.shared.dataTask 를 사용 한다.
        // 5. 4번에 클로저를 작성한다, ->  data, reponse
        // 6.  모델링이 됫다는 가정하에 JsonDecoder() - > decoer.decoe(type.self , date )
        if let hasUrl = loginURL?.url {
            // URLSession 클로저. -> 다른스레드에서 사용
            URLSession.shared.dataTask(with: hasUrl, completionHandler: { (data , response , error) in
                guard let data = data else {return}

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                    return
                }
                let decoder = JSONDecoder()

                do {
                    let user = try decoder.decode([LoginUser].self, from: data)
                    if let hasUser = user.first {
                         UserInfo.shared.info = hasUser
                        self.isLoginInfo(true)
                        print(UserInfo.shared.info.id)
                    }else{
                        self.isLoginInfo(false)
                    }
                }catch{
                    print("ERROR => \(error)")
                }
            }).resume()
        }else{
            return
        }

    }

    @IBAction func moveToAction(_ sender: Any) {
        let signUpVC = UIStoryboard(name: "SignUpVC", bundle: nil).instantiateViewController(identifier: "signUp")
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }

    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension Dictionary {
    var queryString : String {
        var output = ""
        for (key, value) in self {
            output = output + "\(key)=\(value)&"
        }
        output = String(output.dropLast())
        return output
    }
}




