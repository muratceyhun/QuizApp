//
//  QuizViewController.swift
//  QuizzApp
//
//  Created by Murat Ceyhun Korpeoglu on 5.01.2023.
//

import UIKit

class QuizViewController: UIViewController {
    
    
    @IBOutlet var label: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var gameModels = [Question]()
    var currentQuestion: Question?

    override func viewDidLoad() {
        super.viewDidLoad()
        arrangeQuestions()
        configureUI(question: gameModels.first!)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    private func configureUI(question: Question) {
        label.text = question.text
        currentQuestion = question
        tableView.delegate = self
        tableView.dataSource = self
        
    }



    private func controlAnswers(answer: Answer, question: Question) -> Bool {

        return question.answers.contains(where: { $0.text == answer.text}) && answer.correct
    }


    private func arrangeQuestions() {

        gameModels.append(Question(text: "What is the synonym of verb -miss-?", answers: [

            Answer(text: "testimony", correct: false),
            Answer(text: "crave for", correct: true),
            Answer(text: "meditate", correct: false),
            Answer(text: "bring about", correct: false)
        ]))

        gameModels.append(Question(text: "What is the synonym of adjective -irreversible-?", answers: [

            Answer(text: "indomitable", correct: false),
            Answer(text: "malefic", correct: false),
            Answer(text: "otiose", correct: false),
            Answer(text: "irrevocable", correct: true)
        ]))

        gameModels.append(Question(text: "What is not the synonym of noun -procrastination-?", answers: [

            Answer(text: "postponement", correct: false),
            Answer(text: "delay", correct: false),
            Answer(text: "defer", correct: false),
            Answer(text: "derive", correct: true)
        ]))

    }


}


struct Question {
    let text: String
    let answers: [Answer]
}

struct Answer {
    let text: String
    let correct: Bool // true or false
}

extension QuizViewController: UITableViewDelegate {

}



extension QuizViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion?.answers.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath)
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row].text
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let question = currentQuestion else { return }
        let answer = question.answers[indexPath.row]

        if controlAnswers(answer: answer, question: question) {
            
           
            
            if let index = gameModels.firstIndex(where: { $0.text == question.text }) {
              
                
                if index < (gameModels.count - 1) {
                    let alert = UIAlertController(title: "*GREAT*", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Next Question", style: .destructive))
                    present(alert, animated: true)
                    let nextQuestion = gameModels[(index+1)]
                    configureUI(question: nextQuestion)
                    tableView.reloadData()
                    
                } else {
                     
                    let actionSheet = UIAlertController(title: "Game is over", message: "", preferredStyle: .actionSheet)
                    actionSheet.addAction(UIAlertAction(title: "Bact to Menu", style: .cancel))
                    present(actionSheet, animated: true, completion: nil)
                    
//                    let alert = UIAlertController(title: "Game is over", message: "", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Finish", style: .cancel))
//                    present(alert, animated: true)
                    
                }
                
            }
            
        } else {
            let alert = UIAlertController(title: "Wrong Answer", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Try again !", style: .destructive))
            present(alert, animated: true)
            
        }
        
    }
    
}
