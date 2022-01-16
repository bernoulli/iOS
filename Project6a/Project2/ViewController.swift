//
//  ViewController.swift
//  Project2
//
//  Created by Bernardo Cuervo on 12/12/21.
//  Copyright © 2021 Bernardo Cuervo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var numberOfQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "russia", "spain", "uk", "us", "poland"]
       
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        title = "texto de prueba"
        
        //https://javedmultani16.medium.com/creating-uibarbuttonitem-ios-9747a37e589a
        //https://www.hackingwithswift.com/articles/118/uiactivityviewcontroller-by-example
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(scoreTapped))
        
        let backImage = UIImage(named: "icons8-marcador-50")
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(backImage?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: (backImage?.size.width)!-1, bottom: 0, right: 0)), for: [], barMetrics: .default)
        
        askQuestion()
        
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        numberOfQuestions += 1
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + " - Score: \(score)" + " nq: \(numberOfQuestions)"
        
    }
    
    func score(action: UIAlertAction! = nil){
        title = ""
    }
    
    @objc func scoreTapped(){
        
        print("el score es: \(score)")
        
        let ac = UIAlertController(title: nil, message: "Your score is \(score)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: score))
        
        present(ac, animated: true)
    }
    
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        //var title2: String
        
        if sender.tag == correctAnswer{
            title = "Correct"
            score += 1
            
            
        }else{
            title = "Wrong! That’s the flag of: " + countries[sender.tag].description
            score -= 1
        }
        
        if numberOfQuestions == 3 {
            title = "3 questios: your final score is: \(score)"
        }
        
    
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        ac.addAction(UIAlertAction(title: "Close", style: .destructive, handler: askQuestion))
        
        present(ac, animated: true)
        
        
        
    }
    

}

