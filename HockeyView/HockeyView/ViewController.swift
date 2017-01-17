//
//  ViewController.swift
//  HockeyView
//
//  Created by Taylor Guidon on 1/16/17.
//  Copyright © 2017 Taylor Guidon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var rinkView: RinkView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red:0.85, green:0.91, blue:0.94, alpha:1.00)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

