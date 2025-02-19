//
//  HomeVC.swift
//  desktopBrowserMY
//
//  Created by Chan Thai Thong on 25/1/25.
//

import UIKit
import WebKit

class HomeVC: UIViewController {
    
    let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
        setupWebView()
    }
    
    fileprivate func configureUI() {
        view.backgroundColor = .green
    }
    
    fileprivate func setupWebView() {
        view.addSubview(webView)
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.109 Safari/537.36"
        guard let url = URL(string: "https://www.google.com") else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }


}

