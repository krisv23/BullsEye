//
//  ViewController.swift
//  BullsEye
//
//  Created by Kristopher Valas on 4/2/18.
//  Copyright © 2018 Kristopher Valas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var sliderValue : Int = 0
    var targetValue : Int = 0
    var total : Int = 0
    var score : Int = 0
    var round : Int = 0
    var roundScore : Int = 0
    
    @IBOutlet weak var slider : UISlider!
    @IBOutlet weak var targetLabel : UILabel!
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var roundLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderValue = lroundf(slider.value)
        randomize()
        updateLabels()
        
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
        showAlert()
        score += calculateScore()
        round += 1
        randomize()
        updateLabels()
    }
    
    @IBAction func startOverPressed(_ sender: Any){
        score = 0
        round = 0
        randomize()
        updateLabels()
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
    
}

