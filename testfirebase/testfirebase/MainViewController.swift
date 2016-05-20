//
//  MainViewController.swift
//  testfirebase
//
//  Created by Tri Vo on 5/19/16.
//  Copyright © 2016 acumen. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var subview: UIView!
    
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPwd: UITextField!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        subview = UIView()
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func btnFacebookLogin_Touched(sender: AnyObject) {
        if self.infoValidation() {
            NetworkHelper.sharedInstance.getConfigFile()
        } else {
            print("log error");
        }
        
        
    }
    
    
    // MARK: - Text Field Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func infoValidation() -> Bool {
        let username : String = txtUsername.text!
        let pwd : String = txtPwd.text!
        
        
        if username.isEmpty || pwd.isEmpty {
            return false
        }
        
        return true
    }
}
