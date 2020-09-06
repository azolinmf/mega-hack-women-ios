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
    @IBOutlet weak var titleLabel: UILabel!
    
    var loginString: NSString = "Outras formas de login"
    var loginMutableString = NSMutableAttributedString()
    var newUser = true
    var currentUserHomeID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelUI()
        
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
        
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.2
        subtitleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.minimumScaleFactor = 0.2
    }

}
