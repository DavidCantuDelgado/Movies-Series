//
//  SeriesTableViewController.swift
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

class SeriesTableViewController: UITableViewController {

    @IBOutlet var tvSeries: UITableView!

    // Global Variables
    var keyTMDB : String = "ec511e19406b403cfcd2caf50537830b"
    var baseURL : String = "https://api.themoviedb.org/3/tv/"
    var imageBaseURL : String = "https://image.tmdb.org/t/p/original"
    var listType : String = "on_the_air"
    
    //Data
    var seriesList = [Series]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tvSeries.register(UINib(nibName: "SeriesTableViewCell", bundle: nil) , forCellReuseIdentifier: "serieCell")
        
        SVProgressHUD.show()
        LoadSeries()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func LoadSeries() {
        let seriesURL = "\(baseURL)\(listType)?api_key=\(keyTMDB)&language=en-us&page=1"
        Alamofire.request(seriesURL, method: .get)
            .responseJSON { response in
                print(seriesURL)
                if response.result.isSuccess {
                    print("Sucess! Got the series data")
                    let seriesJSON : JSON = JSON(response.result.value!)
                    print(seriesJSON)
                    let countJSON = seriesJSON["results"].count
                    for index in 0 ..< countJSON {
                        let serie = Series(serie: seriesJSON["results"][index]["name"].stringValue, id: seriesJSON["results"][index]["id"].stringValue, poster: seriesJSON["results"][index]["poster_path"].stringValue, overview: seriesJSON["results"][index]["overview"].stringValue, back: seriesJSON["results"][index]["backdrop_path"].stringValue, airDate: seriesJSON["results"][index]["first_air_date"].stringValue)
                        self.seriesList.append(serie)
                        print(serie.serie)
                    }
                    print("hola")
                } else {
                    print("API unavailable")
                }
                SVProgressHUD.dismiss()
                self.configureTableView()
                self.tvSeries.reloadData()
                
        }
    }
    
    func configureTableView() {
        tvSeries.rowHeight = UITableView.automaticDimension
        tvSeries.estimatedRowHeight = 200.0
        
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return seriesList.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "serieCell", for: indexPath) as! SeriesTableViewCell
        cell.lbSerie.text = seriesList[indexPath.row].serie
        let sUrl = "\(imageBaseURL)\(seriesList[indexPath.row].poster)"
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
        self.performSegue(withIdentifier: "showSerieDetail", sender: indexPath.row)
    }
    
    
    @IBAction func bbHome(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSerieDetail" {
            let viewSerie = segue.destination as! SerieDetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            viewSerie.serie = seriesList[indexPath!.row]
            navigationController?.popViewController(animated: true)
            
        }
    }
    
}
