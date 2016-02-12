//
//  SignUpViewController.swift
//  CollegeConnect
//
//  Created by Rohit Gurnani on 12/02/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import UIKit
import SwiftValidator

class SignUpViewController: UIViewController,  UITextFieldDelegate , ValidationDelegate{
    
    
    @IBOutlet weak var collegePickerView : UIPickerView!
    @IBOutlet weak var hostelPickerView : UIPickerView!
    @IBOutlet weak var emailTextfield : UITextField!
    @IBOutlet weak var passwordTextfield : UITextField!
    @IBOutlet weak var fullnameTextfield : UITextField!
    @IBOutlet weak var mobileNumberTextfield : UITextField!
    @IBOutlet weak var rollNoTextfield : UITextField!
    @IBOutlet weak var localiteHosteliteSegControl : UISegmentedControl!
    @IBOutlet weak var signUpButton : UIButton!
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    let validator = Validator()
    let user = User(userName: "", password: "")
    let networkHelper = NetworkingHelper.sharedInstance
    var activeTextField : UITextField? = UITextField()
    

    override func viewDidAppear(animated: Bool) {
        emailTextfield.becomeFirstResponder()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collegePickerView.dataSource = self
        collegePickerView.delegate = self
        
        validator.registerField(emailTextfield, rules: [RequiredRule(), EmailRule()])
        validator.registerField(passwordTextfield, rules: [RequiredRule(), MinLengthRule(length: 6)])
        validator.registerField(fullnameTextfield, rules: [RequiredRule(), FullNameRule()])
        validator.registerField(mobileNumberTextfield, rules: [MinLengthRule(length: 10)])
        
        
        collegePickerView.selectRow(1, inComponent: 0, animated: true)
        hostelPickerView.selectRow(1, inComponent: 0, animated: true)
        
        setUpTextFields()
        activityIndicator.hidden = true
        
        //setting up notifications for keyboard
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeShown:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        notificationCenter.addObserver(self,
            selector: "keyboardWillBeHidden:",
            name: UIKeyboardWillHideNotification,
            object: nil)

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
    
    
    func setUpTextFields() {
        setBottomBorderFortextfield(emailTextfield)
        setBottomBorderFortextfield(passwordTextfield)
        setBottomBorderFortextfield(fullnameTextfield)
        setBottomBorderFortextfield(mobileNumberTextfield)
        setBottomBorderFortextfield(rollNoTextfield)
        
        signUpButton.layer.borderColor = UIColor.blackColor().CGColor
        signUpButton.layer.shadowColor = UIColor.darkGrayColor().CGColor
        signUpButton.layer.shadowOffset = CGSize(width: -5.0, height: -5.0)
        signUpButton.layer.borderWidth = 0.5
        
    }
    
    func setBottomBorderFortextfield(textfield : UITextField){
       
        let border = CALayer()
        border.borderColor = UIColor.blackColor().CGColor
        border.frame = CGRect(x: 0, y: textfield.frame.size.height - 1.0, width: textfield.frame.size.width, height: textfield.frame.size.height)
        border.borderWidth = 2.0
        
        textfield.layer.addSublayer(border)
        textfield.layer.masksToBounds = true
    }
    

    @IBAction func didChooseHosteliteOrLocalite(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            hostelPickerView.userInteractionEnabled = true
            hostelPickerView.alpha = 1.0
        }
        else
        {
            UIView.animateWithDuration(1.0, animations:{
                    self.hostelPickerView.userInteractionEnabled = false
                    self.hostelPickerView.alpha = 0.5
            })
            
        }
    }
    
    
    @IBAction func signupBtnTapped(sender: AnyObject) {
        
        //checking specifically for college and thus rollno.
        if collegePickerView.selectedRowInComponent(0) == 1 {
            if let rollNo = rollNoTextfield.text {
                if rollNo == "" {
                    showError("Roll No empty",focusOn : rollNoTextfield)
                    return
                }
            }
            else
            {
                showError("Roll No empty",focusOn : rollNoTextfield)
                return
            }
        }
        
        //now first validate all other fields. and then jump to corresponding success and failure methods
        validator.validate(self)
        activityIndicator.startAnimating()
        activityIndicator.hidden = false
    }
    
    func validationSuccessful() {
        //assign user properties before performing network request
        assignUserProperties()
        
        //make network request for signup
        makeSignUpRequest()
        
    }
    
    
    func validationFailed(errors: [UITextField : ValidationError]) {
        debugPrint(errors)
        for (field,error) in validator.errors {
            
            field.layer.borderColor = UIColor.redColor().CGColor
            field.layer.borderWidth = 1.0
            
            let alertController = UIAlertController(title: "Invalid data", message: error.errorMessage, preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(okAction)
            
            presentViewController(alertController, animated: true, completion: {
                self.activityIndicator.stopAnimating()
            })
            field.becomeFirstResponder()
            break

        }
        
        
        
    }
    
    func showError(message : String, focusOn : AnyObject)
    {
        let alertController = UIAlertController(title: "Oops, something went wrong.", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        focusOn.becomeFirstResponder()
        
        activityIndicator.stopAnimating()
    }
    
    func assignUserProperties()
    {
        self.user.fullName = fullnameTextfield.text!
        self.user.userName = emailTextfield.text!
        self.user.password = passwordTextfield.text!.sha1()
        
        if let mobilenum = mobileNumberTextfield.text {
            self.user.mobileNumber = mobilenum
        }
        else
        {
            self.user.mobileNumber = ""
        }
        
        //if user is svnit-ian
        if collegePickerView.selectedRowInComponent(0) == 1{
            self.user.collegeName = "NIT-Surat"
            self.user.rollNo = rollNoTextfield.text!
            
            if localiteHosteliteSegControl.selectedSegmentIndex == 0 {
                self.user.hosteliteOrLocalite = true
                self.user.hostelName = DataModel.sharedInstance.SVNIThostels[hostelPickerView.selectedRowInComponent(0)]
            }
            else
            {
                self.user.hosteliteOrLocalite = false
                self.user.hostelName = ""
            }
        }//if user is not svnitian
        else {
            self.user.collegeName = "Other"
            self.user.hosteliteOrLocalite = false
            self.user.hostelName = ""
            
        }
        
    }
    
    func makeSignUpRequest() {
        
        networkHelper.makeSignUpRequest(self.user){
            (message)->Void in
            
            if message == "Success" {
                //current position is sign up is successful from server side. Current user has been updated to reflect that. Now do all the ui related stuff here
               self.signUpWasSuccessful()
                
            }
            else if message == "Failure" {
                //current position is sign up hasn't been successful, mostly due to network. so cover up for it by throwing an error and making the user try again.
                self.signUpWasFailure()
                
            }
            else {
                //current position is sign up request was successful but returned an error code. handle it here
                self.signUpWasSuccessfulButError(message)
            }
        }
    }
    
    func signUpWasSuccessful() {
        activityIndicator.startAnimating()
        activityIndicator.hidden = true
        performSegueWithIdentifier("SignUpSuccessful", sender: nil)
    }
    
    func signUpWasFailure() {
        
        let alertController = UIAlertController(title: "Oops, something went wrong.", message: "We couldn't complete your request. Please check your internet connection and try again", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
        activityIndicator.stopAnimating()
    }
    
    func signUpWasSuccessfulButError(error : String) {
        
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction func hideKeyboard(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == emailTextfield {
            emailTextfield.resignFirstResponder()
            passwordTextfield.becomeFirstResponder()
        }
        else if textField == passwordTextfield {
            passwordTextfield.resignFirstResponder()
            fullnameTextfield.becomeFirstResponder()
        }
        else if textField == fullnameTextfield {
            fullnameTextfield.resignFirstResponder()
            mobileNumberTextfield.becomeFirstResponder()
        }
        else if textField == mobileNumberTextfield {
            mobileNumberTextfield.resignFirstResponder()
            rollNoTextfield.becomeFirstResponder()
        }
        else if textField == rollNoTextfield {
            rollNoTextfield.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        activeTextField = nil
//        scrollView.scrollEnabled = false
    }
    
    
    // Called when the UIKeyboardDidShowNotification is sent.
    func keyboardWillBeShown(sender: NSNotification) {
        let info: NSDictionary = sender.userInfo!
        let value: NSValue = info.valueForKey(UIKeyboardFrameBeginUserInfoKey) as! NSValue
        let keyboardSize: CGSize = value.CGRectValue().size
        let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your app might not need or want this behavior.
        var aRect: CGRect = self.view.frame
        aRect.size.height -= keyboardSize.height
        let activeTextFieldRect: CGRect? = activeTextField?.frame
        let activeTextFieldOrigin: CGPoint? = activeTextFieldRect?.origin
        if (!CGRectContainsPoint(aRect, activeTextFieldOrigin!)) {
            scrollView.scrollRectToVisible(activeTextFieldRect!, animated:true)
        }
    }
    
    // Called when the UIKeyboardWillHideNotification is sent
    func keyboardWillBeHidden(sender: NSNotification) {
        let contentInsets: UIEdgeInsets = UIEdgeInsetsZero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
}

extension SignUpViewController : UIPickerViewDataSource {
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == collegePickerView {
        return DataModel.sharedInstance.colleges[row]
        }
        else {
            return DataModel.sharedInstance.SVNIThostels[row]
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == collegePickerView {
        return DataModel.sharedInstance.colleges.count
        }
        else {
            return DataModel.sharedInstance.SVNIThostels.count
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        activeTextField = textField
    }
    
    
    
    
    
}

extension SignUpViewController : UIPickerViewDelegate {
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == collegePickerView  && pickerView.userInteractionEnabled {
            if row == 0 {
                pickerView.selectRow(1, inComponent: 0, animated: true)
                
                hostelPickerView.userInteractionEnabled = true
                hostelPickerView.alpha = 1.0
                
                localiteHosteliteSegControl.selectedSegmentIndex = 0
                localiteHosteliteSegControl.userInteractionEnabled = true
                localiteHosteliteSegControl.alpha = 1.0
                
                rollNoTextfield.userInteractionEnabled = true
                rollNoTextfield.alpha = 1.0
            }
            else
            {
                user.collegeName = DataModel.sharedInstance.colleges[row]
                if row == 1 {
                    hostelPickerView.userInteractionEnabled = true
                    hostelPickerView.alpha = 1.0
                    
                    localiteHosteliteSegControl.selectedSegmentIndex = 0
                    localiteHosteliteSegControl.userInteractionEnabled = true
                    localiteHosteliteSegControl.alpha = 1.0
                    
                    rollNoTextfield.userInteractionEnabled = true
                    rollNoTextfield.alpha = 1.0
                    
                    
                            }
                else if row == DataModel.sharedInstance.colleges.count - 1 {
                    hostelPickerView.userInteractionEnabled = false
                    hostelPickerView.alpha = 0.5
                    
                    localiteHosteliteSegControl.userInteractionEnabled = false
                    localiteHosteliteSegControl.alpha = 0.5
                    localiteHosteliteSegControl.selectedSegmentIndex = 0
                    rollNoTextfield.userInteractionEnabled = false
                    rollNoTextfield.alpha = 0.5

                    
                }
                else
                {
                    hostelPickerView.userInteractionEnabled = false
                    hostelPickerView.alpha = 0.5
                    
                    localiteHosteliteSegControl.userInteractionEnabled = false
                    localiteHosteliteSegControl.alpha = 0.5
                    
                    rollNoTextfield.userInteractionEnabled = true
                    rollNoTextfield.alpha = 1.0

                    
                }
            }
        }
        
        if pickerView == hostelPickerView && pickerView.userInteractionEnabled {
            if row == 0 {
                pickerView.selectRow(1, inComponent: 0, animated: true)
            }
            else
            {
                user.hostelName = DataModel.sharedInstance.SVNIThostels[row]
            }
        }
        
    }
}

//MARK: Validator
extension Validator {
    /*  this extension/hack was created because the validation library does not provide the returned
    ValidationErrors ordered in the same way we added them or in the way they are being displayed on screen */
    /// return the errors ordered by the frame (y coordinate)
    typealias ValidatorErrorsTuple = (UITextField,ValidationError)
    var errorsOrdered: [ValidatorErrorsTuple] {
        get {
            let errorArray = errors.sort({
                $0.0.frame.origin.y < $1.0.frame.origin.y
            })
            return  errorArray
        }
    }
}
