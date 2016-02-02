//
//  SignUpViewController.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 28/01/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController , UITextFieldDelegate {
    
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var guestLoginButton: UIButton!
    @IBOutlet weak var vcCloseButton: UIButton!
    @IBOutlet weak var emailLabel : UILabel!
    @IBOutlet weak var passwordLabel : UILabel!
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailLabel.hidden = true
        passwordLabel.hidden = true
        
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        setUpTextfields()
        buttonsSetup()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func setUpTextfields()
    {
        let border = CALayer()
        border.borderColor = UIColor.blackColor().CGColor
        border.frame = CGRect(x: 0, y: emailTextfield.frame.size.height - 1.0, width: emailTextfield.frame.size.width, height: emailTextfield.frame.size.height)
        border.borderWidth = 2.0
        
        emailTextfield.layer.addSublayer(border)
        emailTextfield.layer.masksToBounds = true
        
        let border2 = CALayer()
        border2.borderColor = UIColor.blackColor().CGColor
        border2.borderWidth = 2.0
        border2.frame = CGRect(x: 0, y: passwordTextfield.frame.size.height-1.0, width: passwordTextfield.frame.size.width, height: passwordTextfield.frame.size.height)
        passwordTextfield.layer.addSublayer(border2)
        passwordTextfield.layer.masksToBounds = true
        
        

    }

    func buttonsSetup()
    {
        
        signInButton.layer.borderWidth = 0.0
        signInButton.layer.borderColor = UIColor.grayColor().CGColor
        guestLoginButton.layer.borderWidth = 0.5
        guestLoginButton.layer.borderColor = UIColor.grayColor().CGColor
    }
    
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == emailTextfield {
            emailLabel.hidden = false
        }
        if textField == passwordTextfield {
            passwordLabel.hidden = false
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == emailTextfield {
            passwordTextfield.becomeFirstResponder()
            return true
        } else {
            //TODO : implement login logic
            return true
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if emailTextfield.isFirstResponder() {
            emailTextfield.resignFirstResponder()
        }
        if passwordTextfield.isFirstResponder()
        {
            passwordTextfield.resignFirstResponder()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
