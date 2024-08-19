//
//  HomePageViewController.swift
//  Clima
//
//  Created by mahmoud on 26/09/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var buttonLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLabel.layer.cornerRadius = 24.0
        
    }
    
    @IBAction func getStartedBtn(_ sender: UIButton) {
        UserDefaults.standard.setValue(true, forKey: "StartedApp")
    }
}
