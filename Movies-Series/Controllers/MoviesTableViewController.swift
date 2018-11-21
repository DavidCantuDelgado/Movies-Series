//
//  MoviesTableViewController.swift
//  Movies-Series
//
//  Created by David A Cantú Delgado on 11/19/18.
//  Copyright © 2018 Bugsracer. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON
import ChameleonFramework

class MoviesTableViewController: UITableViewController {
    
    @IBOutlet var tvMovies: UITableView!
    
    // Global Variables
    var keyTMDB : String = "ec511e19406b403cfcd2caf50537830b"
    var baseURL : String = "https://api.themoviedb.org/3/movie/"
    var imageBaseURL : String = "https://image.tmdb.org/t/p/original"
    var listType : String = "now_playing"
    
    //Data
    var moviesList = [Movies]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvMovies.register(UINib(nibName: "MoviesTableViewCell", bundle: nil) , forCellReuseIdentifier: "movieCell")

        SVProgressHUD.show()
        LoadMovies()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func LoadMovies() {
        let moviesURL = "\(baseURL)\(listType)?api_key=\(keyTMDB)&language=en-us&page=1"
        Alamofire.request(moviesURL, method: .get)
            .responseJSON { response in
                print(moviesURL)
                if response.result.isSuccess {
                    print("Sucess! Got the movies data")
                    let moviesJSON : JSON = JSON(response.result.value!)
                    print(moviesJSON)
                    let countJSON = moviesJSON["results"].count
                    for index in 0 ..< countJSON {
                        let movie = Movies(movie: moviesJSON["results"][index]["title"].stringValue, id: moviesJSON["results"][index]["id"].stringValue, poster: moviesJSON["results"][index]["poster_path"].stringValue, overview: moviesJSON["results"][index]["overview"].stringValue, back: moviesJSON["results"][index]["backdrop_path"].stringValue, releaseDate: moviesJSON["results"][index]["release_date"].stringValue)
                        self.moviesList.append(movie)
                        print(movie.movie)
                    }
                    print("hola")
                } else {
                    print("API unavailable")
                }
                SVProgressHUD.dismiss()
                self.configureTableView()
                self.tvMovies.reloadData()
                
        }
    }
    
    func configureTableView() {
        tvMovies.rowHeight = UITableView.automaticDimension
        tvMovies.estimatedRowHeight = 200.0
        
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moviesList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MoviesTableViewCell
        cell.lbMovie.text = moviesList[indexPath.row].movie
        let sUrl = "\(imageBaseURL)\(moviesList[indexPath.row].poster)"
        let url = URL(string: sUrl)
        do {
            let imgData = try Data(contentsOf: url!)
            cell.imPoster?.image = UIImage(data: imgData as Data)
        } catch {
            print("image not found")
        }
        
        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showMovieDetail", sender: indexPath.row)
    }
    
    @IBAction func bbBackToHome(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetail" {
            let viewMovie = segue.destination as! MovieDetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            viewMovie.movie = moviesList[indexPath!.row]
            navigationController?.popViewController(animated: true)

        }
    }
    
    
}
