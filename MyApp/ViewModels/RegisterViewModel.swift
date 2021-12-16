//
//  RegisterViewModel.swift
//  MyApp
//
//  Created by Marcos Cerioni on 15/12/2021.
//

import Foundation

class RegisterViewModel: UIViewController {
    
    let model: Registered = Registered()
    var validUser = false
    var errorNumber = [Int()]
    
    func buttonRegisterTouch(userTF: UITextField, passTF: UITextField, passCheckTF: UITextField) {
        
        guard let user = userTF.text,
             let pass = passTF.text,
             let repeatPass = passCheckTF.text else { return }
        
        let resultMail: Bool = RegisterViewController.checkMail(mailInput: user)
        let resultPass: Bool = RegisterViewController.checkPass(passInput: pass)
        
        if resultMail, resultPass, pass == repeatPass, user != model.user1.user {
            self.validUser = true
        }
        if !resultMail { errorNumber.append(1) }
        if user == model.user1.user { errorNumber.append(2) }
        if !resultPass { errorNumber.append(3) }
        if pass != repeatPass { errorNumber.append(4) }
    }
    
}
