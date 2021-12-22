//
//  DetailViewController.swift
//  Project1-3
//
//  Created by Bernardo Cuervo on 20/12/21.
//  Copyright © 2021 Bernardo Cuervo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    //@IBOutlet var imageView: UIImageView!
    var selectedImage : String?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //https://stackoverflow.com/questions/29421726/swift-how-to-get-the-string-before-a-certain-character
        if let index = selectedImage!.firstIndex(of: "@") {
            let firstPart = selectedImage!.prefix(upTo: index)
            
            title = String(firstPart)
            
        }
        
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }

        // Do any additional setup after loading the view.
        print(selectedImage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     */
    
    
    @objc func shareTapped() {
        
        if let index = selectedImage!.firstIndex(of: "@") {
            let firstPart = selectedImage!.prefix(upTo: index)
            
            let name = [firstPart]
            
            let vc = UIActivityViewController(activityItems: name, applicationActivities: [])
            vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            present(vc, animated: true, completion: nil)
            
        }
   
        
    }
 

}
