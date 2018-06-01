//
//  Cinemas.swift
//  moviesX
//
//  Created by thejus manoharan on 17/05/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import Foundation

class Cinemas {
    var name : String?
    var location : String?
    var multiplex : Bool?
    var ratings : String?
    var price : String?
    var airConditioner : Bool?
    var imgName: String?
    init(name:String, location:String, ratings:String, multiplex:Bool, airConditioner:Bool, imgName:String, price:String){
        self.name = name
        self.location = location
        self.ratings = ratings
        self.multiplex = multiplex
        self.imgName = imgName
        self.airConditioner = airConditioner
        self.price = price
    }
    
}
