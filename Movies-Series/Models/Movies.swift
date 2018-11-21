//
//  Movies.swift
//  Movies-Series
//
//  Created by David A Cantú Delgado on 11/19/18.
//  Copyright © 2018 Bugsracer. All rights reserved.
//

import UIKit

class Movies: NSObject {
    var movie : String
    var id : String
    var poster : String
    var overview : String
    var back : String
    var releaseDate : String
    
    init(movie :  String, id : String, poster : String, overview : String, back : String, releaseDate : String) {
        self.movie = movie
        self.id = id
        self.poster = poster
        self.overview = overview
        self.back = back
        self.releaseDate = releaseDate
    }

}
