//
//  signUpVC.swift
//  signUpDemo
//
//  Created by mac on 22/07/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import CoreData
class signUpVC: UIViewController {
    @IBOutlet weak var viewSignUP: UIView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfContact: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPwd: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var imgUser: UIImageView!
    var imgData:NSData?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSignUP.layer.cornerRadius = 8.0
        btnSignUp.layer.cornerRadius = 10.0
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        if tfEmail.text!.isEmpty && tfPwd.text!.isEmpty && tfName.text!.isEmpty && tfContact.text!.isEmpty {
            print("Please enter all details")
            return
        } else if tfName.text!.isEmpty {
            print("Enter name")
            return
        } else if tfContact.text!.isEmpty {
            print("Enter Contact")
            return
        } else if tfEmail.text!.isEmpty {
            print("Enter Email ID")
            return
        } else if tfPwd.text!.isEmpty {
            print("Enter Password")
            return
        }
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let managedObj = appDel.persistentContainer.viewContext
        let userObj = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: managedObj)
        userObj.setValue(tfName.text, forKey: "name")
        userObj.setValue(tfEmail.text, forKey: "email")
        userObj.setValue(tfContact.text, forKey: "contact")
        userObj.setValue(tfPwd.text, forKey: "password")
        userObj.setValue(imgData, forKey: "image")
        do {
            try managedObj.save()
            print("Data Saved")
            tfName.text = ""
            tfEmail.text = ""
            tfContact.text = ""
            tfPwd.text = ""
            navigationController?.popViewController(animated: true)
        } catch {
            print("Data didn't saved", error.localizedDescription)
        }
    }
}

extension signUpVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func cameraAction(_ sender: UIButton) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image", "public.movie"]
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgUser.image = pickedImage
            imgData = pickedImage.pngData() as NSData?
            if imgData == nil {
                return
            }
            
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
