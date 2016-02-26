//
//  ViewController.swift
//  RMM
//
//  Created by wei chih tsai on 2016/1/14.
//  Copyright © 2016年 ECG. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import SwiftyUserDefaults

class LoginVC: UIViewController {

    @IBOutlet var usernameTextBox: UITextField!
   
    @IBOutlet var passwordTextbox: UITextField!
    
    
    let log =  LogSwift.logger
    
    let authServ =  AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInBtn(sender: UIButton) {
        
        log.debug("sign in RMM");

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

//        let deviceMgmtVC = storyBoard.instantiateViewControllerWithIdentifier("DeviceMgmtVC")as! DeviceMgmtVC


        let loginVC = storyBoard.instantiateViewControllerWithIdentifier("LoginVC")as! LoginVC

//                let tabBarController: UITabBarController = storyboard!.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
        
        
//        let navigationController = storyBoard.instantiateViewControllerWithIdentifier("NavigationCtrlToLogin") as! UINavigationController

//        navigationController.navigationBarHidden = false;
        
        if self.usernameTextBox.text == "" || self.passwordTextbox.text == "" {
                
            var alertController =
            UIAlertController(
                title: "Error",
                message: "Username and Password are required!!",
                preferredStyle: UIAlertControllerStyle.Alert)

            
//            var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            var okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
//            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }else{
                    authServ.login(
                        self.usernameTextBox.text!,
                        password: self.passwordTextbox.text!,
                        completionHandler: {
                    (userModel,error) in
            
                        self.log.debug("login callback")
                        self.log.debug("JSON = \(userModel);")
            //            self.log.debug(userModel?.getName())
            
            //                Defaults[.user] = userModel
            
                             self.performSegueWithIdentifier("goToTabbar", sender: self)
                    } )
        }

        log.debug("sign in DONE")
    }
}

