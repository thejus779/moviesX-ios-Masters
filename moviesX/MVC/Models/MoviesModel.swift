//
//  Movies.swift
//  moviesX
//
//  Created by thejus manoharan on 17/05/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import Foundation

class Movies {
    var name : String?
    var director : String?
    var ratings : String?
    var year : String?
    var description : String?
    var imgName: String?
    init(name:String, director:String, ratings:String, year:String, description:String, imgName:String){
        self.name = name
        self.director = director
        self.ratings = ratings
        self.year = year
        self.imgName = imgName
        self.description = description
    }
    
}
