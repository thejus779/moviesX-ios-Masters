//
//  movie.swift
//  moviesX
//
//  Created by thejus manoharan on 23/04/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import Foundation

class Movie {
    var name : String?
    var director : String?
    var rating : String?
    var year : String?
    var description : String?
    var img: String?
    init(name:String, director:String, rating:String, year:String, description:String, img:String){
        self.name = name
        self.director = director
        self.rating = rating
        self.year = year
        self.description = description
        self.img = img
    }
    
}
