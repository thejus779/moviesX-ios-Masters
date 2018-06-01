//
//  MoviesViewController.swift
//  moviesX
//
//  Created by thejus manoharan on 22/04/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import UIKit
import CoreData

class MoviesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var labelNotFound: UILabel!
    @IBOutlet weak var imgNotFound: UIImageView!
    @IBOutlet weak var tableMovies: UITableView!
    let cellReuseIdentifier = "MoviesTableViewCell"
    var details : MoviesModel!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    var tasks: [MoviesModel] = []
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableMovies.delegate=self
        self.tableMovies.dataSource=self
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getData()
        self.tableMovies.reloadData()
        
    }
    
    // MARK: - Get Data
    func getData() {
        do {
            tasks = try context.fetch(MoviesModel.fetchRequest())
            if tasks.count>0 {
                imgNotFound.isHidden = true
                labelNotFound.isHidden = true
            }
        } catch {
            print("Fetching Failed")
        }
    }
    
    // MARK: - Delete Data
    func deleteData(){
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: "MoviesModel")
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do { try context.execute(DelAllReqVar) }
        catch { print(error) }
    }

    // MARK: - Table Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell: MoviesTableViewCell = self.tableMovies.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MoviesTableViewCell
        let task = tasks[indexPath.row]
        
        if let name = task.name {
            cell.lblName.text = name
        }
        if let rating = task.ratings {
            cell.viewRatings.rating = Int(rating)!
        }
       
        
        cell.imgMovie.image = load(fileName: task.imageName!)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        details = tasks[indexPath.row]
        
        self.performSegue(withIdentifier: "toMovieDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {


            tableMovies.beginUpdates()
            resetAllRecords(index: indexPath.row)
            self.tableMovies.deleteRows(at:[indexPath] , with: .fade)
            tableMovies.endUpdates()
            }
    }

    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        let destVC = segue.destination as! MovieDetailsViewController
        destVC.model = self.details
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
    // MARK: - Delete at index Data
    func resetAllRecords(index : Int) // entity = Your_Entity_Name
    {
        
        context.delete(tasks[index] as NSManagedObject)
        tasks.remove(at: index)
        if tasks.count == 0 {
            imgNotFound.isHidden = false
            labelNotFound.isHidden = false
        }
        let _ : NSError! = nil
        do {
            try context.save()
        } catch {
            print("error : \(error)")
        }
    }
    
}
