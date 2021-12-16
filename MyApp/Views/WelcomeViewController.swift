//
//  WelcomeViewController.swift
//  MyApp
//
//  Created by Marcos Cerioni on 29/10/2021.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var imageLogo: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageLogo.image = UIImage(systemName: "person.fill")
        view.backgroundColor = .black
        addImageGestures()
    }
    
    func addImageGestures() {
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        let gesturePinch = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        imageLogo.addGestureRecognizer(gestureTap)
        imageLogo.addGestureRecognizer(gesturePinch)
        imageLogo.isUserInteractionEnabled = true
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        let compile = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
        let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
        let message = "Version: \(version)\n Compile: \(compile)\n \(appName)"
        alertOK(title: "", message: message, action: "OK")
    }
    
    @objc func didPinch(_ sender: UIPinchGestureRecognizer) {
        if let scale = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)) {
            guard scale.a > 1.0 &&  scale.a < 3.0 else { return }
            guard scale.d > 1.0 &&  scale.a < 3.0 else { return }
            sender.view?.transform = scale
            sender.scale = 1.0
        }
    }

    @IBAction func logOutButton(_ sender: Any) {
        dismiss(animated: true)
    }
}
