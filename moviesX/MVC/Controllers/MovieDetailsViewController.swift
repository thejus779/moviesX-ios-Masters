//
//  MovieDetailsViewController.swift
//  moviesX
//
//  Created by thejus manoharan on 22/04/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import UIKit
import STRatingControl

class MovieDetailsViewController: UIViewController {
    var model : MoviesModel!
    
    @IBOutlet weak var ratiings: STRatingControl!
    @IBOutlet weak var labelDescr: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelDirector: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Get and Populate Data
    func fetchData(){
        labelName.text = model.name
        labelYear.text = model.year
        labelDescr.text = model.details
        labelDirector.text = model.director
        self.image.image = load(fileName: model.imageName!)
        if let rating = model.ratings {
            self.ratiings.rating  = Int(rating)!
        }
        
    }
    
    // MARK: - Actions
    @IBAction func actionBack(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    // MARK: - Load Image
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
