//
//  HomeVC.swift
//  desktopBrowserMY
//
//  Created by Chan Thai Thong on 25/1/25.
//

import UIKit
import WebKit

class HomeVC: UIViewController {
    let webView: WKWebView = {
        let v = WKWebView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let addressView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .black
        v.layer.cornerRadius = 18
        v.layer.borderWidth = 3
        v.layer.borderColor = UIColor.white.cgColor
        return v
    }()
    let addressTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = .white
        tf.attributedPlaceholder = NSAttributedString(
            string: "Enter your Url here...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        tf.returnKeyType = .go
        return tf
    }()
    let subAddressTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let goButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "goButton"), for: .normal)
        return btn
    }()
    let refreshButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "refreshButton"), for: .normal)
        return btn
    }()
    let progressView: UIProgressView = {
        let v = UIProgressView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureWebView()
        setupDelegate()
    }
    
    fileprivate func setupViews() {
        progressView.progressTintColor = UIColor.purple.withAlphaComponent(0.5)
        view.addSubview(progressView)
        webView.uiDelegate = self
        view.addSubview(webView)
        view.addSubview(addressView)
        addressView.addSubview(addressTextField)
        view.addSubview(goButton)
        view.addSubview(refreshButton)
        // view arrangement setup
        addressView.keyboardLayoutGuide.followsUndockedKeyboard = true
        view.bringSubviewToFront(progressView)
        // setup auto layout constraints
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 8),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            addressView.topAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -40),
            addressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addressView.widthAnchor.constraint(equalToConstant: 230),
            addressView.heightAnchor.constraint(equalToConstant: 36),
            addressTextField.topAnchor.constraint(equalTo: addressView.topAnchor),
            addressTextField.centerXAnchor.constraint(equalTo: addressView.centerXAnchor),
            addressTextField.bottomAnchor.constraint(equalTo: addressView.bottomAnchor),
            addressTextField.leadingAnchor.constraint(equalTo: addressView.leadingAnchor, constant: 10),
            addressTextField.trailingAnchor.constraint(equalTo: addressView.trailingAnchor, constant: -10),
            goButton.leadingAnchor.constraint(equalTo: addressView.trailingAnchor, constant: 12),
            goButton.centerYAnchor.constraint(equalTo: addressView.centerYAnchor),
            goButton.widthAnchor.constraint(equalToConstant: 36),
            goButton.heightAnchor.constraint(equalToConstant: 36),
            refreshButton.trailingAnchor.constraint(equalTo: addressView.leadingAnchor, constant: -12),
            refreshButton.centerYAnchor.constraint(equalTo: addressView.centerYAnchor),
            refreshButton.widthAnchor.constraint(equalToConstant: 36),
            refreshButton.heightAnchor.constraint(equalToConstant: 36)
        ])
        // setup gestures
        goButton.addTarget(self, action: #selector(handleGoTapped), for: .touchUpInside)
        refreshButton.addTarget(self, action: #selector(handleRefreshTapped), for: .touchUpInside)
        
        // setup observers
        webView.addObserver(self, forKeyPath: "estimatedProgress", context: nil)
    }
    
    fileprivate func setupDelegate() {
        addressTextField.delegate = self
    }
    
    fileprivate func configureWebView() {
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36"
        guard let url = URL(string: "https://www.google.com") else { return }
        webView.load(URLRequest(url: url))
    }
    
    @objc func handleGoTapped() {
        guard let text = addressTextField.text else { return }
        guard let url = URL(string: "https://www.\(String(describing: text))") else { return }
        url.isReachable { success in
            if success {
                DispatchQueue.main.async {
                    self.webView.load(URLRequest(url: url))
                }
            } else {
                if let searchUrl = URL(string: "https://www.google.com/search?q=\(text.replacingOccurrences(of: " ", with: "+"))") {
                    DispatchQueue.main.async {
                        self.webView.load(URLRequest(url: searchUrl))
                    }
                    
                }
                    
            }
        }
    }
    
    @objc func handleRefreshTapped() {
        webView.reload()
    }
    
}

extension HomeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        handleGoTapped()
        return false
    }
}

extension HomeVC: WKUIDelegate {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            print(webView.estimatedProgress)
            progressView.progress = Float(webView.estimatedProgress)
            if progressView.progress == 1.0 {
                UIView.animate(withDuration: 3.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
                    self.progressView.alpha = 0
                }
            } else {
                progressView.alpha = 1
            }
        }
    }
}
