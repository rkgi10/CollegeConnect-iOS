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
    
    let validator = Validator()
    let user = User(userName: "", password: "")
    let networkHelper = NetworkingHelper.sharedInstance
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collegePickerView.dataSource = self
        collegePickerView.delegate = self
        
        validator.registerField(emailTextfield, rules: [RequiredRule(), EmailRule()])
        validator.registerField(passwordTextfield, rules: [RequiredRule(), PasswordRule()])
        validator.registerField(fullnameTextfield, rules: [RequiredRule(), FullNameRule()])
        validator.registerField(mobileNumberTextfield, rules: [MinLengthRule(length: 10)])
        
        
        collegePickerView.selectRow(1, inComponent: 0, animated: true)
        hostelPickerView.selectRow(1, inComponent: 0, animated: true)
        
        setUpTextFields()

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
        
        validator.validate(self)
        
    }
    
    func validationSuccessful() {
        assignUserProperties()
        makeSignUpRequest()
        
    }
    
    
    func validationFailed(errors: [UITextField : ValidationError]) {
        
    }
    
    func showError(message : String, focusOn : AnyObject)
    {
        
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
        
        
    }
    
    
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction func hideKeyboard(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
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
