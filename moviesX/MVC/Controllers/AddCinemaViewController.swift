//
//  AddCinemaViewController.swift
//  moviesX
//
//  Created by thejus manoharan on 31/05/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import UIKit
import CoreData

class AddCinemaViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtRating: UITextField!
    @IBOutlet weak var imgCinemaHall: UICustomeImageView!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnUpload: UICustomButton!
    @IBOutlet weak var btnAC: UISwitch!
    @IBOutlet weak var btnMultiPlex: UISwitch!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    let imagePicker = UIImagePickerController()
    var photoPath:String = ""
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Add Data
    func addData(){
        let task = CinemasModel(context: context)
        task.name = txtName.text
        task.ratings = txtRating.text
        task.location = txtLocation.text
        task.price = txtPrice.text
        task.imageName = photoPath
        if btnAC.isOn {
            task.airConditioner = true
        } else {
            task.airConditioner = false
        }
        if btnMultiPlex.isOn {
            task.multiplex = true
        } else {
            task.multiplex = false
        }
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        do {
            try context.save()
            goBack()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    // MARK: - Actions
    @IBAction func actionSave(_ sender: Any) {
        
        if validateCinemaHall() {
            self.addData()
        }
    }
    @IBAction func actionPhoto(_ sender: Any) {
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func actionBack(_ sender: Any) {
        goBack()
    }
    
    func goBack(){
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgCinemaHall.image = pickedImage
            btnUpload.isHidden = true
            photoPath = save(image: pickedImage)!
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        btnUpload.isHidden = false
        
    }
    // MARK: - Save Image
    private func save(image: UIImage) -> String? {
        let fileName = "FileName"
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        if let imageData = UIImageJPEGRepresentation(image, 1.0) {
            try? imageData.write(to: fileURL, options: .atomic)
            return fileName // ----> Save fileName
        }
        print("Error saving image")
        return nil
    }
    
    // MARK: - Validators
    func validateCinemaHall() -> Bool{
        txtName.text = txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        txtLocation.text = txtLocation.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        txtRating.text = txtRating.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        txtPrice.text = txtPrice.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if ((txtName.text?.isEmpty)!) {
            print(" name empty")
            return false
        }
        else if((txtLocation.text?.isEmpty)!){
            print(" location empty")
            return false
        }
        else if((txtPrice.text?.isEmpty)!){
           
                print("digts only price")
                return false
    
        }
        else if let _ = txtPrice.text?.rangeOfCharacter(from: CharacterSet.letters){
            print("price digits only")
            return false
        }
        else if((txtRating.text?.isEmpty)!){

                print("rating empty")
                return false
        
        }
        else if let _ = txtRating.text?.rangeOfCharacter(from: CharacterSet.letters){
            print("rating digits only")
            return false
        }
        else if(imgCinemaHall.image == nil){
            
            print(" image empty")
            return false
        }
        else {
            return true
        }
    }
}
