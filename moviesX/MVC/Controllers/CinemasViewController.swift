//
//  CinemasViewController.swift
//  moviesX
//
//  Created by thejus manoharan on 17/05/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import UIKit
import CoreData

class CinemasViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var labelNotFound: UILabel!
    @IBOutlet weak var imgNotFound: UIImageView!
    @IBOutlet weak var tableMovies: UITableView!
    var details : CinemasModel!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    var tasks: [CinemasModel] = []
    let cellReuseIdentifier = "CinemasTableViewCell"
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
            tasks = try context.fetch(CinemasModel.fetchRequest())
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
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: "CinemasModel")
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do { try context.execute(DelAllReqVar) }
        catch { print(error) }
    }
    
    // MARK: - Table Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell: CinemasTableViewCell = self.tableMovies.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CinemasTableViewCell
        let task = tasks[indexPath.row]
        
        cell.lblName.text = task.name
        cell.lblLocation.text = task.location
        
        cell.imgCinema.image = load(fileName: task.imageName!)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        details = self.tasks[indexPath.row]
        
        self.performSegue(withIdentifier: "toCinemaDetails", sender: self)
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
        let destVC = segue.destination as! CinemaDetailsViewController
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
    
    // MARK: - Delete Data at Index
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
