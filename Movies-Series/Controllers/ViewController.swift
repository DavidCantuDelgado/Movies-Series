//
//  ViewController.swift
//  Movies-Series
//
//  Created by David A Cantú Delgado on 11/19/18.
//  Copyright © 2018 Bugsracer. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import ChameleonFramework

class ViewController: UIViewController {

    //Outlets
    
    @IBOutlet weak var btMovies: UIButton!
    
    // Global variables
    
    
    // ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func MoviesList(_ sender: UIButton) {
        print("moviesSegue")
        performSegue(withIdentifier: "moviesSegue", sender: self)
        
    }
    
    @IBAction func SeriesList(_ sender: UIButton) {
        print("seriesSegue")
        performSegue(withIdentifier: "seriesSegue", sender: self)
    
    }
    
}

