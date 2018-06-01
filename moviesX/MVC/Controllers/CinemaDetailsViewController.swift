//
//  CinemaDetailsViewController.swift
//  moviesX
//
//  Created by thejus manoharan on 17/05/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import UIKit
import STRatingControl

class CinemaDetailsViewController: UIViewController {
    var model : CinemasModel!
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelAc: UILabel!
    @IBOutlet weak var labelMulti: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var rating: STRatingControl!
    @IBOutlet weak var image: UIImageView!
    
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }

    // MARK: - Load Data
    func fetchData(){
        labelName.text = model.name
        labelAc.text = model.airConditioner ? "Available" : "Not Available";
        labelMulti.text = model.multiplex ? "Available" : "Not Available";
        labelPrice.text = model.price
        labelLocation.text = model.location
        self.image.image = load(fileName: model.imageName!)
        if let rating = model.ratings {
            self.rating.rating  = Int(rating)!
        }
        
    }
    // MARK: - Action
    @IBAction func actionBack(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    // MARK: - load Image
    private func load(fileName: String) -> UIImage? {
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
    

}
