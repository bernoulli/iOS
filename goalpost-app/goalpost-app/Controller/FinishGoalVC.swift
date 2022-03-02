//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Bernardo Cuervo on 13/02/22.
//  Copyright © 2022 Bernardo Cuervo. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    var goalDescription: String!
    var goalType: GoalType!
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGoalBtn.bindToKeyboard()
        pointsTextField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func createBtWasPressed(_ sender: Any) {
        //Pass data into core data GoalModel
        
        if pointsTextField.text != "" {
            self.save { (complete) in
                if complete {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
        
        
    }
    
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            try managedContext.save()
            print("Sucessfully saved data.")
            completion(true)
    
        } catch {
            debugPrint("Could no save:  \(error.localizedDescription)")
            completion(false)
        }
        
        
        
    }
    
}
