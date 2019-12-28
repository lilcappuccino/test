//
//  WebViewViewViewController.swift
//  TestINNOVATIONS
//
//  Created by dewill on 26.12.2019.
//  Copyright © 2019 lilcappucc. All rights reserved.
//

import UIKit
import WebKit

//Using WebView for opening PDF File by url
class WebViewViewController: UIViewController {
    
    //   MARK:-> Outlet
    @IBOutlet weak var webView: WKWebView!
    
    var link: String?
    
    //MARK:-> Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadData()
    }
    
    private func loadData(){
        guard let pdfLink = link , let url = URL(string: pdfLink) else { return }
        webView.load(URLRequest(url: url))
        
    }
    
    
}
