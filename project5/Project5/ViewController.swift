//
//  ViewController.swift
//  Project5
//
//  Created by TwoStraws on 14/08/2016.
//  Copyright © 2016 Paul Hudson. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
	var allWords = [String]()
	var usedWords = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(startGame))

		if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
			if let startWords = try? String(contentsOfFile: startWordsPath) {
				allWords = startWords.components(separatedBy: "\n")
			}
		} else {
			allWords = ["silkworm"]
		}

		startGame()
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return usedWords.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
		cell.textLabel?.text = usedWords[indexPath.row]
		return cell
	}

    @objc func startGame() {
		title = allWords.randomElement()
		usedWords.removeAll(keepingCapacity: true)
		tableView.reloadData()
	}

	@objc func promptForAnswer() {
		let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
		ac.addTextField()

		let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] action in
			let answer = ac.textFields![0]
			self.submit(answer: answer.text!)
		}

		ac.addAction(submitAction)

		present(ac, animated: true)
	}

	func isPossible(word: String) -> Bool {
		var tempWord = title!.lowercased()

		for letter in word {
			if let pos = tempWord.range(of: String(letter)) {
				tempWord.remove(at: pos.lowerBound)
			} else {
				return false
			}
		}

		return true
	}

	func isOriginal(word: String) -> Bool {
		return !usedWords.contains(word)
	}

	func isReal(word: String) -> Bool {
		let checker = UITextChecker()
		let range = NSMakeRange(0, word.utf16.count)
		let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        if (word.count < 3){
        print("Word under 3 chars")
            return false
        }
        
        if (word as AnyObject === title as AnyObject?){
            //print("the words are similar")
            return false
        }

		return misspelledRange.location == NSNotFound
	}

	func submit(answer: String) {
		let lowerAnswer = answer.lowercased()

		//let errorTitle: String
		//let errorMessage: String

		if isPossible(word: lowerAnswer) {
			if isOriginal(word: lowerAnswer) {
				if isReal(word: lowerAnswer) {
					usedWords.insert(answer, at: 0)

					let indexPath = IndexPath(row: 0, section: 0)
					tableView.insertRows(at: [indexPath], with: .automatic)
					return
                    
                    
                } else {
                    showErrorMessage(errorMessage: "You can't just make them up, you know!", errorTitle: "Word not recognised")
                    
				}
			} else {
                showErrorMessage(errorMessage: "Word used already", errorTitle: "Be more original!")
				
			}
		} else {
            showErrorMessage(errorMessage: "You can't spell that word from '\(title!.lowercased())'!", errorTitle: "Word not possible")
			
		}

	}
    
    func showErrorMessage(errorMessage: String, errorTitle: String){
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        
    }
}
