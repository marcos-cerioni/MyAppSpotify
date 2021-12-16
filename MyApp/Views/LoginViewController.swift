//
//  LoginViewController.swift
//  MyApp
//
//  Created by Marcos Cerioni on 22/10/2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailOrUsername: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var continueOutlet: UIButton!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    var viewModel: LoginViewModel?

    @IBAction func `continue`(_ sender: Any) {
        emailError.isHidden = true
        passwordError.isHidden = true

        viewModel?.buttonLoginTouch(userTF: emailOrUsername, passTF: password)
        
        if viewModel!.errorNumber.contains(1) {
            alertOK(title: "Try again", message: "Incorrect username or password", action: "OK")
        }
        if viewModel!.errorNumber.contains(2) {
            UIView.transition(with: emailError, duration: 0.6, options: .transitionCrossDissolve, animations: {
                self.emailError.isHidden = false
            })
            emailOrUsername.shake()
        }
        if viewModel!.errorNumber.contains(3) {
            UIView.transition(with: passwordError, duration: 0.6, options: .transitionCrossDissolve, animations: {
                self.passwordError.isHidden = false
            })
            password.shake()
        }

        guard let valid = viewModel?.validUser else { return }
        if valid {
            viewModel?.savedData()
            goToMainViewController()
            viewModel?.validUser = false
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Color1")
        continueOutlet.bordered()
        loginLabel.textStle()
        password.tfShadow()
        emailOrUsername.tfShadow()

        emailError.isHidden = true
        passwordError.isHidden = true
        
        emailOrUsername.text = "hola@gmail.com"
        password.text = "queOnda123"
        viewModel = LoginViewModel()
    }
}
