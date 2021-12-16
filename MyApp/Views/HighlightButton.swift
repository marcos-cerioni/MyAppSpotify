//
//  HighlightButton.swift
//  MyApp
//
//  Created by Marcos Cerioni on 23/11/2021.
//

import UIKit

class HighlightButton: UIButton {

    var icon: UIImage?
    var secondIcon: UIImage?
    var isPlaying = false
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
        self.tintColor = .black
    }
    
    func perfomTwoStateSelection() {
        isPlaying = !isPlaying
        self.setImage(isPlaying ? icon : secondIcon, for: .normal)
        self.setImage(isPlaying ? icon : secondIcon, for: .highlighted)
    }
    
    func setImage(icon: UIImage?) {
        guard let icon = icon else { return }
        self.icon = icon
        self.setImage(icon, for: .normal)
        self.setImage(icon, for: .highlighted)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.white, for: .highlighted)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                backgroundColor = .cyan
            }
            else {
                backgroundColor = .white
            }
            super.isHighlighted = newValue
        }
    }
}
