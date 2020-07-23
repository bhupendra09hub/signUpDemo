//
//  UpdateVC.swift
//  signUpDemo
//
//  Created by mac on 22/07/20.
//  Copyright © 2020 mac. All rights reserved.
//

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
    
    var userInfo:NSManagedObject?
    	
    override func viewDidLoad() {
        super.viewDidLoad()
        tfName.text = userInfo!.value(forKey: "name") as? String
        tfContact.text = userInfo!.value(forKey: "contact") as? String
        tfEmail.text = userInfo!.value(forKey: "email") as? String
        tfPwd.text = userInfo!.value(forKey: "password") as? String
        btnDelete.layer.cornerRadius = 10.0
        btnUpdate.layer.cornerRadius = 10.0
        viewUpdate.layer.cornerRadius = 8.0
    }
    
    @IBAction func UpdateAction(_ sender: UIButton) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let managedObj = appDel.persistentContainer.viewContext
        
        userInfo!.setValue(tfName.text, forKey: "name")
        userInfo!.setValue(tfContact.text, forKey: "contact")
        userInfo!.setValue(tfEmail.text, forKey: "email")
        userInfo!.setValue(tfPwd.text, forKey: "password")
        do {
            try managedObj.save()
            print("Data updated")
            //            let usrListVC = storyboard?.instantiateViewController(withIdentifier: "userListVC") as! userListVC
            //            navigationController?.popToViewController(usrListVC, animated: true)
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
            //            let usrListVC = storyboard?.instantiateViewController(withIdentifier: "userListVC") as! userListVC
            //            navigationController?.popToViewController(usrListVC, animated: true)
            navigationController?.popViewController(animated: true)
        } catch {
            print("Error", error.localizedDescription)
        }
    }
    
    
}
