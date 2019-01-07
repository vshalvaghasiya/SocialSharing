//
//  ViewController.swift
//  SocialSharing
//
//  Created by Admin on 05/01/19.
//  Copyright © 2019 VISHAL. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKLoginKit
import FBSDKCoreKit
import TwitterKit
import Social
import InstagramLogin
class ViewController: UIViewController, FBSDKSharingDelegate {
    
    let clientID = "386bdccc966d4b8b8b0a2793c5036d3b"
    let redirectURI = "http://react95.blogspot.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Button Click Events
    @IBAction func whatsAppButtonClick(_ sender: UIButton) {
        let url  = URL(string: "whatsapp://send?text=Hello%20Friends%2C%20Sharing%20some%20data%20here...%20!")
        if UIApplication.shared.canOpenURL(url!) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url!, options: [:]) { (success) in
                    if success {
                        print("WhatsApp accessed successfully")
                    } else {
                        print("Error accessing WhatsApp")
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    @IBAction func facebookButtonClick(_ sender: UIButton) {
        if FBSDKAccessToken.current() != nil {
            let content = FBSDKShareLinkContent()
            content.contentURL = URL(string: "https://developers.facebook.com")
            let shareDialog = FBSDKShareDialog()
            shareDialog.mode = .native
            shareDialog.shouldFailOnDataError = true
            shareDialog.shareContent = content
            shareDialog.fromViewController = self
            shareDialog.delegate = self
            shareDialog.show()
        } else {
            let fbLoginManager: FBSDKLoginManager = FBSDKLoginManager()
            fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
                if (error == nil){
                    let fbLoginResult: FBSDKLoginManagerLoginResult = result!
                    if fbLoginResult.grantedPermissions != nil {
                        if(fbLoginResult.grantedPermissions.contains("email")){
                            self.facebookLogin()
                        }
                    }
                }
                else{
                    print(error?.localizedDescription ?? "")
                }
            }
        }
    }
    
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!) {
        print("didCompleteWithResults")
    }
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
        print("didFailWithError")
        print(error.debugDescription)
    }
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
        print("sharerDidCancel")
    }
    
    func facebookLogin() {
//        if((FBSDKAccessToken.current()) != nil) {
//            FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id, name, first_name, last_name, picture.type(large), email "]).start(completionHandler: { (connection, result, error) in
//                if result == nil {
//                    print(error?.localizedDescription ?? "")
//                }
//                else{
//                    let userResults = result as! [String : AnyObject]
//                    print(userResults)
//                }
//            })
//        }
        
//        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) {
//            let facebookShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
//            let shareText = "Check out this awesome iOS Programming Blog at blog.apoorvmote.com"
//            facebookShare.setInitialText(shareText)
//            self.present(facebookShare, animated: true, completion: nil)
//        }
//        else {
//            let alert = UIAlertController(title: "Facebook Login Required", message: "Go to Settings -> facebook & login", preferredStyle: UIAlertController.Style.alert)
//            let okAction = UIAlertAction(title: "I Understood", style: UIAlertAction.Style.default, handler: nil)
//            alert.addAction(okAction)
//            self.present(alert, animated: true, completion: nil)
//        }
    }
    
    
    @IBAction func twitterButtonClick(_ sender: UIButton) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
            let twitterShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            let tweet = "Check out this cool Swift Programming blog at blog.apoorvmote.com #swiftlang"
            twitterShare.setInitialText(tweet)
            self.present(twitterShare, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Twitter Login Required", message: "Go to Settings -> twitter & login", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "I Understood", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
//        let composer = TWTRComposer()
//
//        composer.setText("just setting up my Twitter Kit")
//       // composer.setImage(UIImage(named: "twitterkit"))
//
//        composer.show(from: self) { (result) in
//            if (result == .done) {
//                print("Successfully composed Tweet")
//            } else {
//                print("Cancelled composing")
//            }
//        }
        
        // Called from a UIViewController
//        composer.show(from: self.navigationController!) { (result, in
//            if (result == .done) {
//            print("Successfully composed Tweet")
//            } else {
//            print("Cancelled composing")
//            }
//        }
    }
    
    @IBAction func instagramButtonClick(_ sender: UIButton) {
        let vc = InstagramLoginViewController(clientId: clientID, redirectUri: redirectURI)
//        let vc = InstagramLoginViewController(clientID: clientID, redirectURI: redirectURI) { accessToken, error in
//            guard let accessToken = accessToken else {
//                print("Failed login: " + error!.localizedDescription)
//                return
//            }
//
//            self.navigationController?.popViewController(animated: true)
//            // Do your stuff ...
//        }
        vc.scopes = [.basic, .publicContent]
        vc.progressViewTintColor = UIColor.green
        show(vc, sender: self)
    }
    
    
}

