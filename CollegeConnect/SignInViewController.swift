//
//  SignInViewController.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 28/01/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import UIKit
import CryptoSwift

class SignInViewController: UIViewController , UITextFieldDelegate {
    
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var guestLoginButton: UIButton!
    @IBOutlet weak var vcCloseButton: UIButton!
    @IBOutlet weak var emailLabel : UILabel!
    @IBOutlet weak var passwordLabel : UILabel!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    @IBOutlet weak var forgotPasswordButton : UIButton!
    
    
    let networkingHelper = NetworkingHelper()
    
    

    override func viewDidAppear(animated: Bool) {
        emailTextfield.becomeFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInBackground()
        
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
        } else if textField == passwordTextfield {
            signInBtnTapped(textField)
            passwordTextfield.resignFirstResponder()
            return true
        }
        return true
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
    
    
    @IBAction func signInBtnTapped(sender: AnyObject) {
        
       // var wasSignInSuccessful = ""
        
        if emailTextfield.isFirstResponder() {
            emailTextfield.resignFirstResponder()
        }
        
        if passwordTextfield.isFirstResponder() {
            passwordTextfield.resignFirstResponder()
        }
        
        
        if let emailAddress = emailTextfield.text , password = passwordTextfield.text{
            
            //email validation
            if !(emailAddress.isEmail()) {
                showEmailAdressInvalidAlert()
                return
            }
            
            if password.characters.count == 0 {
                showPasswordInvalidAlert()
                return
            }
            
        }
        else {
            showDetailsUnfilledAlert()
        }
        
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
        
        networkingHelper.makeSignInRequest(emailTextfield.text!, withPassword: passwordTextfield.text!.sha1()){
            (message) -> Void in
            
           let wasSignInSuccessful = message            
            print(wasSignInSuccessful)
            
            if wasSignInSuccessful == "Success" {
                self.signInSuccessful()
            }
            else
            {
                if wasSignInSuccessful == "Failure" {
                    self.signInFailure()
                }
                else
                {
                    self.signInError(wasSignInSuccessful)
                }
            }
        }
        
        
        
    }
    
    //this function will be triggered after the network gets the sign-in as successful
    func signInSuccessful(){
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidden = true
        performSegueWithIdentifier("LoginSuccessful", sender: nil)
    
    }
    
    //this function will be triggered after the network gets the sign-in as network failure
    func signInFailure(){
        
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidden = true
        
        let alertController = UIAlertController(title: "Oops, something went wrong.", message: "We couldn't complete your request. Please check your internet connection and try again", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
        

    }
    
    //this function will be triggered after the network gets the sign-in as successful but some error
    func signInError(errorMessage : String){
        
        let alertController = UIAlertController(title: "Error Occured", message: "Our servers seem to be down at the moment. Please try again in some time later.", preferredStyle: .Alert)
        switch errorMessage {
        case "ERR04" : alertController.title = "Incorrect Username"
                       alertController.message = "Please enter a correct username or sign up"
            
        case "ERR05" : alertController.title = "Incorrect Password"
                       alertController.message = "Please enter the correct password for your account or click on the forgot password button"
                        //self.forgotPasswordButton.hidden = false
        default : break
            
        }
        
        //hide the activity indicator
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidden = true
        
        //add action to alert
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    //if all details aren't filled in, this function is triggered
    func showDetailsUnfilledAlert(){
        let alertController = UIAlertController(title: "Error", message: "Please fill in a username and a password.", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { action in
            self.emailTextfield.becomeFirstResponder()
        })
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    //if password is invalid, this function is triggered
    func showPasswordInvalidAlert(){
        let alertController = UIAlertController(title: "Password Invalid", message: "Please enter a valid password.", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { action in
            self.passwordTextfield.becomeFirstResponder()
        })
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    //if email adress is invalid, this function is triggered
    func showEmailAdressInvalidAlert(){
        let alertController = UIAlertController(title: "Email Adress Invalid", message: "The email adress you entered is invalid. Please enter a valid email address.", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { action in
        self.emailTextfield.becomeFirstResponder()
        })
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func loadInBackground()
    {
        networkingHelper.loadEventListInBackground()
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


extension String {
    func isEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,5}$",
            options: [.CaseInsensitive])
        
        return regex.firstMatchInString(self, options:[],
            range: NSMakeRange(0, utf16.count)) != nil
    }
    
    func toBase64()->String{
        
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        
        return data!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
    }
}
