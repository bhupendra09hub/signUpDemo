//  UpdateVC.swift
//  signUpDemo
//  Created by mac on 22/07/20.
//  Copyright © 2020 mac. All rights reserved.

import UIKit
import CoreData
class UpdateVC: UIViewController {
    @IBOutlet weak var viewUpdate: UIView!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfContact: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPwd: UITextField!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var imgUser: UIImageView!
    var userInfo:NSManagedObject?
    var imageData:NSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfName.text = userInfo!.value(forKey: "name") as? String
        tfContact.text = userInfo!.value(forKey: "contact") as? String
        tfEmail.text = userInfo!.value(forKey: "email") as? String
        tfPwd.text = userInfo!.value(forKey: "password") as? String
        imgUser.image = UIImage(data:userInfo?.value(forKey: "image") as! Data)
        btnDelete.layer.cornerRadius = 10.0
        btnUpdate.layer.cornerRadius = 10.0
        viewUpdate.layer.cornerRadius = 8.0
    }
    @IBAction func UpdateAction(_ sender: UIButton) {
        if imageData == nil {
            imageData = userInfo?.value(forKey: "image") as? NSData
        } else if tfEmail.text!.isEmpty && tfPwd.text!.isEmpty && tfName.text!.isEmpty && tfContact.text!.isEmpty {
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
        userInfo!.setValue(tfName.text, forKey: "name")
        userInfo!.setValue(tfContact.text, forKey: "contact")
        userInfo!.setValue(tfEmail.text, forKey: "email")
        userInfo!.setValue(tfPwd.text, forKey: "password")
        userInfo!.setValue(imageData, forKey: "image")
        do {
            try managedObj.save()
            print("Data updated")
            navigationController?.popViewController(animated: true)
        } catch {
            print("Error", error.localizedDescription)
        }
    }
    @IBAction func DeleteAction(_ sender: Any) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let managedObj = appDel.persistentContainer.viewContext
        managedObj.delete(userInfo!)
        do {
            try managedObj.save()
            print("Data updated")
            navigationController?.popViewController(animated: true)
        } catch {
            print("Error", error.localizedDescription)
        }
    }
}
extension UpdateVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func buttonAction(_ sender: UIButton) {
        let imgPicker = UIImagePickerController()
        imgPicker.sourceType = .photoLibrary
        imgPicker.allowsEditing = true
        imgPicker.delegate = self
        present(imgPicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imgPicked = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imgUser.image = imgPicked
            imageData = imgPicked.jpegData(compressionQuality: 1) as NSData?
            if imageData == nil {
                return
            }
            dismiss(animated: true, completion: nil)
        }
    }
}
