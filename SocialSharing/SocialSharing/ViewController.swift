//
//  ViewController.swift
//  SocialSharing
//
//  Created by Admin on 05/01/19.
//  Copyright © 2019 VISHAL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    

}

