//
//  RegisterViewController.swift
//  MyApp
//
//  Created by Marcos Cerioni on 28/10/2021.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var userSignUp: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var passwordNotEqual: UILabel!
    var viewModel: RegisterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Color1")
        
        emailError.isHidden = true
        passwordError.isHidden = true
        passwordNotEqual.isHidden = true
        viewModel = RegisterViewModel()
    }
    
    @IBAction func registerButton(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        
        viewModel.buttonRegisterTouch(userTF: userSignUp, passTF: newPassword, passCheckTF: repeatPassword)
                
        emailError.isHidden = true
        passwordError.isHidden = true
        passwordNotEqual.isHidden = true

        if viewModel.errorNumber.contains(1) {
            emailError.isHidden = false
            self.userSignUp.shake()
        }
        if viewModel.errorNumber.contains(2) {
            emailError.text = "The email is already in use"
            emailError.isHidden = false
            self.userSignUp.shake()
        }
        if viewModel.errorNumber.contains(3) {
            self.newPassword.shake()
            passwordError.isHidden = false
        }
        if viewModel.errorNumber.contains(4) {
            self.repeatPassword.shake()
            passwordNotEqual.isHidden = false
        }
        
        if viewModel.validUser {
            viewModel.savedData()
            goToMainViewController()
            viewModel.validUser = false
        }
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    var counter: Int = 0
    var colorsCount: Int = 3
    @IBAction func facebookButton(_ sender: Any) {
        let color: String = "Color"
        let colorname: String = color + "\(counter)"
        counter += 1
        facebook.backgroundColor = UIColor(named: colorname)
        if counter > colorsCount { counter = 1 }
    }

}
