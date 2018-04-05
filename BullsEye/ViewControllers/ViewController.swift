//
//  ViewController.swift
//  BullsEye
//
//  Created by Kristopher Valas on 4/2/18.
//  Copyright © 2018 Kristopher Valas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Global variables
    var sliderValue : Int = 0
    var targetValue : Int = 0
    var total : Int = 0
    var score : Int = 0
    var round : Int = 10
    var roundScore : Int = 0
    var count : Int = 1
    var highScore : Int = 0
    var winnerName : String = ""
   
    //Storboard outlets
    @IBOutlet weak var slider : UISlider!
    @IBOutlet weak var targetLabel : UILabel!
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var roundLabel : UILabel!
    @IBOutlet weak var highScoreLabel : UILabel!
    
    //Global Constants
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderValue = lroundf(slider.value)
        randomize()
        updateLabels()
        updateSliderImage()
        if let highScore = userDefaults.value(forKey: "highScoreNumber") as? Int {
            self.highScore = highScore
            if let pastWinnerName = userDefaults.value(forKey: "highScoreName") as? String {
                highScoreLabel.text = "\(pastWinnerName) \(highScore)"
            }
        }else {
            highScoreLabel.text = "No high scores yet!"
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomize(){
        targetValue = Int(arc4random_uniform(100)) + 1
    }
    
    @IBAction func sliderMoved(_ slider : UISlider) {
        sliderValue = lroundf(slider.value)
        print(sliderValue)
    }

    @IBAction func hitMePressed(_ sender: Any) {
        
        if round > 0 {
            score += calculateScore()
            round -= 1
            showAlert()
            randomize()
            updateLabels()
        }else {
            gameOver()
        }

    }
    
    @IBAction func startOverPressed(_ sender: Any){
        score = 0
        round = 10
        randomize()
        updateLabels()
    }
    
    func gameOver() {
        if score > highScore {
            //winner
            newHighScore()
            print(winnerName)

        }else {
            //alert game over! You did not beat the high score!

        }
        let alertVC = UIAlertController(title: "Game over!", message: "Play again?", preferredStyle: .alert)
        let playAgainAction = UIAlertAction(title: "Play again?", style: .default, handler: { (_) in
            self.startOverPressed(self)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertVC.addAction(cancelAction)
        alertVC.addAction(playAgainAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func newHighScore() {
        let alertVC = UIAlertController(title: "Winner!", message: "Please enter your name!", preferredStyle: .alert)
        alertVC.addTextField { (textField) in
            textField.placeholder = "Kris V."
        }
        let alert =  UIAlertAction(title: "Done", style: .default) { (_) in
            guard let name = alertVC.textFields?.first?.text
                else {return}
            self.userDefaults.set(name, forKey: "highScoreName")
            self.userDefaults.set(self.score, forKey: "highScoreNumber")
            self.highScoreLabel.text = "\(name) \(self.score)"
            
        }
        alertVC.addAction(alert)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    func updateLabels() {
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
        targetLabel.text = String(targetValue)
        slider.value = 50
    }
    
    func calculateScore () -> Int {
        
        let scoreTally = targetValue - sliderValue
        if scoreTally < 0 {
            return 100 - (scoreTally * -1)
        }else {
            return 100 - scoreTally
        }
        
    }
    
    func showAlert() {
        let alertVC = UIAlertController(title: "Round: \(round)", message: "You selected: \(sliderValue), You scored: \(calculateScore())", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(alertAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    //MARK: Image Labels
    func updateSliderImage() {
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        let thumbImageHighlighted = UIImage(named: "SlideThumb-Highlighted")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackImageleft = UIImage(named:"SliderTrackLeft")
        let trackImageRight = UIImage(named: "SliderTrackRight")
        
        let trackLeftResizable = trackImageleft?.resizableImage(withCapInsets: insets)
        let trackRightResizable = trackImageRight?.resizableImage(withCapInsets: insets)
        
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
}

