//
//  optionsView.swift
//  desktopBrowserMY
//
//  Created by Chan Thai Thong on 24/2/25.
//
import UIKit

class OptionsView: UIView {
    
    static var sharedView: OptionsView = {
        let v = OptionsView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .black
        v.layer.cornerRadius = 20
        return v
    }()
    
    func animateIn(parentView: UIView) {
        parentView.addSubview(OptionsView.sharedView)
        NSLayoutConstraint.activate([
            OptionsView.sharedView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            OptionsView.sharedView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            OptionsView.sharedView.heightAnchor.constraint(equalTo: parentView.heightAnchor, multiplier: 0.4),
            OptionsView.sharedView.widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 0.7)
        ])
        
        OptionsView.sharedView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        OptionsView.sharedView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            OptionsView.sharedView.alpha = 1
            OptionsView.sharedView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.3, animations: {
            OptionsView.sharedView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            OptionsView.sharedView.alpha = 0
        }) { (success) in
            OptionsView.sharedView.removeFromSuperview()
        }
    }
    
}
