//
//  ViewController.swift
//  Question
//
//  Created by 贝蒂小熊 on 2022/2/14.
//

import UIKit


class ViewController: UIViewController {
    var currentQuestionIndex = 0
    var score = 0
    
    @IBOutlet weak var questionLabel: UILabel! {
        didSet {
            questionLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var scheduleViewWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questionLabel.text = questions[0].text
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
        checkAnswer(sender.tag)
        currentQuestionIndex += 1
        nextQuestion()
        //下列代码需放在currentQuestionIndex重置之后
        scheduleLabel.text = "\(currentQuestionIndex + 1) / 13"
        //底部进度条
        scheduleViewWidth.constant = (view.frame.width / 13) * CGFloat(currentQuestionIndex)
    }
    
    func checkAnswer(_ tag: Int) {
        if tag == 1 {
            if questions[currentQuestionIndex].answer == true {
                ProgressHUD.showSuccess("yes", image: UIImage(systemName: "checkmark"), interaction: true)
                score += 1
                updateScore()
            }else {
                ProgressHUD.showError("no", image: UIImage(systemName: "multiply"), interaction: true)
            }
        }else {
            if questions[currentQuestionIndex].answer == true {
                ProgressHUD.showError("no", image: UIImage(systemName: "multiply"), interaction: true)
            }else {
                ProgressHUD.showSuccess("yes", image: UIImage(systemName: "checkmark"), interaction: true)
                score += 1
                updateScore()
            }
        }
    }
    
    func nextQuestion() {
        if currentQuestionIndex <= 12 {
            updateCurrentQuestion()
        }else {
            currentQuestionIndex = 0//重置
            score = 0
            
            let alert = UIAlertController(title: "结束", message: "还要再来一遍吗？", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "再来一遍", style: .default, handler: { _ in
                //self.questionLabel.text = questions[self.currentQuestionIndex].text//可单独提一个函数出来
                //self.scoreLabel.text = "总得分: \(self.score)"
                self.updateCurrentQuestion()
                self.updateScore()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateCurrentQuestion() {
        questionLabel.text = questions[currentQuestionIndex].text
    }
    
    func updateScore() {
        scoreLabel.text = "总得分: \(score)"
    }

}

