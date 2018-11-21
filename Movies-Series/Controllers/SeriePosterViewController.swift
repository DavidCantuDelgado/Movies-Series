//
//  SeriePosterViewController.swift
//  Movies-Series
//
//  Created by David A Cantú Delgado on 11/20/18.
//  Copyright © 2018 Bugsracer. All rights reserved.
//

import UIKit

class SeriePosterViewController: UIViewController {

    // Outlets
    
    @IBOutlet weak var imBack: UIImageView!
    
    // Input Variables
    var backPoster : String!
    
    // Global Variables
    var imageBaseURL : String = "https://image.tmdb.org/t/p/original"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let sUrl = "\(imageBaseURL)\(backPoster!)"
        let url = URL(string: sUrl)
        do {
            let imgData = try Data(contentsOf: url!)
            imBack.image = UIImage(data: imgData as Data)
        } catch {
            print("image not found")
        }
    }
    

}
