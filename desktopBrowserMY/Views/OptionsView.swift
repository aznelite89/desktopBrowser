//
//  optionsView.swift
//  desktopBrowserMY
//
//  Created by Chan Thai Thong on 24/2/25.
//
import UIKit

protocol OptionsViewDelegate: AnyObject {
    func toggleJS()
}

class OptionsView: UIView {
    
    weak var delegate: OptionsViewDelegate?
    
    static var sharedView: OptionsView = {
        let v = OptionsView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .black
        v.layer.cornerRadius = 20
        return v
    }()
    let jsView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .red
        return v
    }()
    let jsLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.text = "Enable Javascript"
        return lbl
    }()
    let jsToggle: UISwitch = {
        let s = UISwitch()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.isOn = true
        return s
    }()
    
    func animateIn(parentView: UIView) {
        parentView.addSubview(OptionsView.sharedView)
        OptionsView.sharedView.addSubview(jsView)
        jsView.addSubview(jsLabel)
        jsView.addSubview(jsToggle)
        NSLayoutConstraint.activate([
            OptionsView.sharedView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            OptionsView.sharedView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            OptionsView.sharedView.heightAnchor.constraint(equalTo: parentView.heightAnchor, multiplier: 0.4),
            OptionsView.sharedView.widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 0.7),
            jsView.leadingAnchor.constraint(equalTo: OptionsView.sharedView.leadingAnchor, constant: 8),
            jsView.topAnchor.constraint(equalTo: OptionsView.sharedView.topAnchor, constant: 16),
            jsView.trailingAnchor.constraint(equalTo: OptionsView.sharedView.trailingAnchor, constant: -8),
            jsView.heightAnchor.constraint(equalToConstant: 32),
            jsLabel.leadingAnchor.constraint(equalTo: jsView.leadingAnchor),
            jsLabel.centerYAnchor.constraint(equalTo: jsView.centerYAnchor),
            jsToggle.trailingAnchor.constraint(equalTo: jsView.trailingAnchor),
            jsToggle.centerYAnchor.constraint(equalTo: jsView.centerYAnchor)
        ])
        
        // animate in to show option view
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
