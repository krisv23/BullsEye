//
//  InfoViewController.swift
//  BullsEye
//
//  Created by Kristopher Valas on 4/2/18.
//  Copyright © 2018 Kristopher Valas. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func closePressed(_ sender : Any?){
        dismiss(animated: true, completion: nil)
    }

}
