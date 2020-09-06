//
//  LoginViewController.swift
//  MegaHack
//
//  Created by Maria Fernanda Azolin on 03/09/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit
import AuthenticationServices
import GoogleSignIn
import Firebase

class LoginViewController: UIViewController, GIDSignInDelegate {
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var siwaView: UIView!
    @IBOutlet weak var anotherLoginButton: UIButton!
    var loginString: NSString = "Outras formas de login"
    var loginMutableString = NSMutableAttributedString()
    var newUser = true
    var currentUserHomeID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelUI()
        buttonUI()
        
        appleSignInConfig()
        
        googleSignInConfig()
        
        DAOFireBase.load {
            print("finished getting data from firebase")
        }
    }
    
    func googleSignInConfig() {
        GIDSignIn.sharedInstance().clientID = "1042550771993-4m62k24fim50lmr6envmffkj40pgb3no.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        signInButton.style = GIDSignInButtonStyle.wide
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            if user.profile.hasImage {
                Profile.shared.photo = user.profile.imageURL(withDimension: 50)
            }
            
            for element in Model.instance.accounts {
                if element.userID == user.userID {
                    newUser = false
                    currentUserHomeID = element.homeID
                }
            }
            
            if newUser {
                Profile.shared.userID = user.userID
                sendToNewHomeViewController()
            } else {
                Profile.shared.userID = user.userID
                Profile.shared.name = user.profile.givenName
                Profile.shared.homeName = getHomeName(userID: user.userID)
                
                //pegar tudo as tarefas tbm
                
                sendToTasksViewController()
            }
            
        } else {
          print("\(error.localizedDescription)")
        }
    }
    
    func getHomeName(userID: String) -> String {
        for element in Model.instance.homes {
            if element.homeID == currentUserHomeID {
                return element.name
            }
        }
        return "Minha casa"
    }
    
    func sendToTasksViewController() {
       if let tabbar = (storyboard?.instantiateViewController(withIdentifier: "tabBar") as? UITabBarController) {
            tabbar.modalPresentationStyle = .fullScreen
            self.present(tabbar, animated: true, completion: nil)
        }
    }
    
    func sendToNewHomeViewController() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "newHome") as! NewHomeViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func labelUI() {
        let boldText = "sobrecarregado"
        let fontBold = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        let attrs = [NSAttributedString.Key.font : fontBold]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        let normalText = "Se todos fizerem um pouquinho, ninguém fica "
        let normalString = NSMutableAttributedString(string:normalText)
        normalString.append(attributedString)
        
        subtitleLabel.attributedText = normalString
    }
    
    func buttonUI() {
        loginMutableString = NSMutableAttributedString(string: loginString as String, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12.0, weight: .semibold)])
        loginMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.MyTheme.orange, range: NSRange(location:17,length:5))
        loginMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.MyTheme.darkGray, range: NSRange(location:0,length:16))
        anotherLoginButton.setAttributedTitle(loginMutableString, for: .normal)
    }
}

extension LoginViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // return the current view window
        return self.view.window!
    }
}

extension LoginViewController : ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("authorization error")
        guard let error = error as? ASAuthorizationError else {
            return
        }
        
        switch error.code {
        case .canceled:
            // user press "cancel" during the login prompt
            print("Canceled")
        case .unknown:
            // user didn't login their Apple ID on the device
            print("Unknown")
        case .invalidResponse:
            // invalid response received from the login
            print("Invalid Respone")
        case .notHandled:
            // authorization request not handled, maybe internet failure during login
            print("Not handled")
        case .failed:
            // authorization failed
            print("Failed")
        @unknown default:
            print("Default")
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userID = appleIDCredential.user
            
            // optional, might be nil
            let email = appleIDCredential.email
            
            // optional, might be nil
            let givenName = appleIDCredential.fullName?.givenName
            
            // optional, might be nil
            let familyName = appleIDCredential.fullName?.familyName
            
            // optional, might be nil
            let nickName = appleIDCredential.fullName?.nickname
            
            /*
             useful for server side, the app can send identityToken and authorizationCode
             to the server for verification purpose
             */
            var identityToken : String?
            if let token = appleIDCredential.identityToken {
                identityToken = String(bytes: token, encoding: .utf8)
            }
            
            var authorizationCode : String?
            if let code = appleIDCredential.authorizationCode {
                authorizationCode = String(bytes: code, encoding: .utf8)
            }
            
            // do what you want with the data here
        }
    }
    
    func appleSignInConfig() {
        let siwaButton = ASAuthorizationAppleIDButton()
        siwaButton.translatesAutoresizingMaskIntoConstraints = false
        siwaView.addSubview(siwaButton)
        NSLayoutConstraint.activate([
            siwaButton.leadingAnchor.constraint(equalTo: siwaView.safeAreaLayoutGuide.leadingAnchor, constant: 0.0),
            siwaButton.trailingAnchor.constraint(equalTo: siwaView.safeAreaLayoutGuide.trailingAnchor, constant: 0.0),
            siwaButton.widthAnchor.constraint(equalTo: signInButton.safeAreaLayoutGuide.widthAnchor),
            siwaButton.heightAnchor.constraint(equalTo: signInButton.safeAreaLayoutGuide.heightAnchor)
        ])
        siwaButton.addTarget(self, action: #selector(appleSignInTapped), for: .touchUpInside)
    }
    
    @objc func appleSignInTapped() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        // request full name and email from the user's Apple ID
        request.requestedScopes = [.fullName, .email]
        
        // pass the request to the initializer of the controller
        let authController = ASAuthorizationController(authorizationRequests: [request])
        
        // similar to delegate, this will ask the view controller
        // which window to present the ASAuthorizationController
        authController.presentationContextProvider = self
        
        // delegate functions will be called when user data is
        // successfully retrieved or error occured
        authController.delegate = self
        
        // show the Sign-in with Apple dialog
        authController.performRequests()
    }
}

