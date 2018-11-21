//
//  Series.swift
//  Movies-Series
//
//  Created by David A Cantú Delgado on 11/19/18.
//  Copyright © 2018 Bugsracer. All rights reserved.
//

import UIKit

class Series: NSObject {
    var serie : String
    var id : String
    var poster : String
    var overview : String
    var back : String
    var airDate : String
    
    init(serie :  String, id : String, poster : String, overview : String, back : String, airDate : String) {
        self.serie = serie
        self.id = id
        self.poster = poster
        self.overview = overview
        self.back = back
        self.airDate = airDate
    }
}
