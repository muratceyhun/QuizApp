//
//  MainViewController.swift
//  QuizzApp
//
//  Created by Murat Ceyhun Korpeoglu on 5.01.2023.
//

//-MenuVC
//-QuizVC
//-AnswerObject
//-QuestionObject


//MARK: -To pass other VC




import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startGame() {
        
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "quizViewController") as! QuizViewController
        destinationVC.modalPresentationStyle = .fullScreen
        present(destinationVC, animated: true, completion: nil)
    }
}



