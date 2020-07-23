//
//  ViewController.swift
//  signUpDemo
//
//  Created by mac on 22/07/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    @IBOutlet weak var lblLoginTitle: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var vwSignIn: UIView!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var lblReverse: UILabel!
    var userData:[NSManagedObject] = []
    var name:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSignIn.layer.cornerRadius = 10.0
        vwSignIn.layer.cornerRadius = 8
        print("Hello Bhupendra")
        let revers = (reverse("Bhupendra"))
        lblReverse.text = revers
        print(revers)
    }
    
    func reverse(_ text:String)->String {
        return String(text.reversed())
    }
    override func viewWillAppear(_ animated: Bool) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let managedObj = appDel.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        do {
            userData = try managedObj.fetch(fetchRequest) as! [NSManagedObject]
        } catch {
            print("Fetching Error", error.localizedDescription)
        }
    }
    @IBAction func singInAction(_ sender: UIButton) {
        if tfEmail.text!.isEmpty && tfPassword.text!.isEmpty {
            print("Please Fill both filed")
            return
        }   else if tfEmail.text == "" {
            print("Enter Email ID")
            return
        }   else if tfPassword.text == "" {
            print("Enter Password")
            return
        }
        let urListVC = storyboard?.instantiateViewController(withIdentifier: "userListVC") as! userListVC
        for i in userData {
            name = i.value(forKey: "email") as? String
            let password = i.value(forKey: "password") as? String
            
            if tfEmail.text == name! && tfPassword.text == password! {
                navigationController?.pushViewController(urListVC, animated: true)
            } else {
                print("Id and Password are not valid")
            }
        }
        tfEmail.text = ""
        tfPassword.text = ""
    }
    @IBAction func signUpAction(_ sender: UIButton) {
        let sgnUpVC = storyboard?.instantiateViewController(withIdentifier: "signUpVC") as! signUpVC
        navigationController?.pushViewController(sgnUpVC, animated: true)
    }
    
    
}

