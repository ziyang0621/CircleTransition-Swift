//
//  ViewController.swift
//  CircleTransition
//
//  Created by Ziyang Tan on 12/5/14.
//  Copyright (c) 2014 Ziyang Tan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func circleTapped(sender:UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }

}

