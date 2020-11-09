//
//  WebViewController.swift
//  Project16
//
//  Created by Леонид Хабибуллин on 09.11.2020.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate { // Challenge 3
    
    var webView: WKWebView!
    
    var progressView:UIProgressView!
    
//    var url: URL
    
    var selectedCity: String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) // .flexibleSpace даёт изменяемое пространство, не может быть нажато поэтому два nil
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        let back = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(webView.goBack))
        let forward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(webView.goForward))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()


        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton, spacer, refresh, back, forward]
        
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        switch selectedCity {
        case "London":
            let url = URL(string: "https://ru.wikipedia.org/wiki/%D0%9B%D0%BE%D0%BD%D0%B4%D0%BE%D0%BD")!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        default:
            let url = URL(string: "https://ru.wikipedia.org")!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
        
//        let url = URL(string: "https://" + selectedWebsite!)!
//        guard let url2 = url else {return}
        
//            webView.load(URLRequest(url: url2))
//            webView.allowsBackForwardNavigationGestures = true

    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }


}
