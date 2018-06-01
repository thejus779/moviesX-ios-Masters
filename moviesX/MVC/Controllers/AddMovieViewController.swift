//
//  AddMovieViewController.swift
//  moviesX
//
//  Created by thejus manoharan on 22/04/2018.
//  Copyright © 2018 thejus. All rights reserved.
//

import UIKit
import CoreData

class AddMovieViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imgMovie: UICustomeImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDirector: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtRatings: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var btnSave: UICustomButton!
    @IBOutlet weak var btnPhoto: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
    let imagePicker = UIImagePickerController()
    var photoPath:String = ""
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        txtDescription.layer.borderColor = UIColor.black.cgColor
        txtDescription.layer.borderWidth = 1.0
    }
    
    // MARK: - Add Data
    func addData(){
        let task = MoviesModel(context: context)
        task.name = txtName.text
        task.ratings = txtRatings.text
        task.details = txtDescription.text
        task.director = txtDirector.text
        task.imageName = photoPath
        task.year = txtYear.text
        
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
        if validateCinemaHall(){
            addData()
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
    
    // MARK: - Back Methods
    func goBack(){
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgMovie.image = pickedImage
            btnPhoto.isHidden = true
            photoPath = save(image: pickedImage)!
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        btnPhoto.isHidden = false
        
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
    
    // MARK: - Validator
    func validateCinemaHall() -> Bool{
        txtName.text = txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        txtYear.text = txtYear.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        txtRatings.text = txtRatings.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        txtDirector.text = txtDirector.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        txtDescription.text = txtDescription.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if ((txtName.text?.isEmpty)!) {
            print(" name empty")
            return false
        }
        else if((txtDirector.text?.isEmpty)!){
            print(" director name empty")
            return false
        }
        else if((txtYear.text?.isEmpty)!){
            
            print("yera empty")
            return false
            
        }
        else if let _ = txtYear.text?.rangeOfCharacter(from: CharacterSet.letters){
            print("year digits only")
            return false
        }
        else if((txtRatings.text?.isEmpty)!){
            
            print("rating empty")
            return false
            
        }
        else if let _ = txtRatings.text?.rangeOfCharacter(from: CharacterSet.letters){
            print("rating digits only")
            return false
        }
        else if((txtDescription.text?.isEmpty)!){
            print(" description  empty")
            return false
        }
        else if(imgMovie.image == nil){
            
            print(" image empty")
            return false
        }
            
        else {
            return true
        }
    }
    
}
