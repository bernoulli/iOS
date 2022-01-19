//
//  DetailViewController.swift
//  Project7
//
//  Created by Bernardo Cuervo on 17/01/22.
//  Copyright © 2022 Bernardo Cuervo. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        
        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <meta name ="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; background-color: #6495ED;} </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
        
        

        // Do any additional setup after loading the view.
    }
    
    @objc func showCredits(){
        
        //print("el score es: \(score)")
        
        let ac = UIAlertController(title: nil, message: "the data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        
        present(ac, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
