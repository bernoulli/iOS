//
//  ViewController.swift
//  Project4
//
//  Created by Bernardo Cuervo on 21/12/21.
//  Copyright © 2021 Bernardo Cuervo. All rights reserved.
//  https://artisticscoreengraving.wordpress.com/2019/02/26/hacking-with-swift-challenge-4/
//  https://github.com/titanium901/100DaysHackingWithSwift/blob/master/Project4%202/Project4/Controller/TableViewController.swift

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate  {
    
    var websites = ["www.apple.com", "www.hackingwithswift.com", "www.womtic.edu.co"]
    //var websiteToLoad : String?
    var webView: WKWebView!
    var progressView: UIProgressView!
    //var websites = [String]()
    var webIndex = 0
    
    override func loadView(){
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
         
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        //https://www.hackingwithswift.com/example-code/uikit/how-to-add-multiple-uibarbuttonitem-to-a-navigation-bar-using-rightbarbuttonitems
        //https://stackoverflow.com/questions/36351414/swift-uiwebview-back-button-with-navigationbar-back-button
        
        let newBackButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
        let newForwardButton = UIBarButtonItem(title: "Forward", style: .plain , target: self, action: #selector(forward))
        self.navigationItem.leftBarButtonItems = [newBackButton, newForwardButton];
        
        
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        
        
        // Do any additional setup after loading the view.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //title = "Websites"
        //navigationController?.navigationBar.prefersLargeTitles = true
        
        //guard let selectedSite = selectedSite else { return }
        /*
        if let url = URL(string: "https://" + websites[1])
        {
          let urlRequest = URLRequest(url: url)
          webView.load(urlRequest)
        }
        */
        
        let url = URL(string: "https://" + websites[webIndex])!
        
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    
    @objc func openTapped(){
        let ac = UIAlertController(title: "open Page...", message: nil, preferredStyle: .actionSheet )
        
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
                  
        }
        
        ac.addAction(UIAlertAction(title: "cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else {return}
        guard let url = URL(string: "https://" + actionTitle) else {return}
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    //use of KVOs
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                        decisionHandler(.allow)
                        return
                }
            }
            
            
        }
        let alertController = UIAlertController(title: "Warning!", message: "The website is blocked!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
        decisionHandler(.cancel)
    }
    
    func pageNoAvalaible (){
        let ac = UIAlertController(title: "advise", message: "It's blocked!!", preferredStyle: .alert )
        
        ac.addAction(UIAlertAction(title: "cancel", style: .cancel))
        //ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    @objc func back() {
        if(webView.canGoBack) {
             webView.goBack()
        } else {
            self.navigationController!.popViewController(animated:true)
        }
    }
    
    @objc func forward() {
        if(webView.canGoForward) {
             webView.goForward()
        } else {
            self.navigationController!.popViewController(animated:true)
        }
    }



}

