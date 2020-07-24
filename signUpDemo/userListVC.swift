//
//  userListVC.swift
//  signUpDemo
//
//  Created by mac on 22/07/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import CoreData
class userListVC: UIViewController {
    
    @IBOutlet weak var tblUserList: UITableView!
    var userObj:[NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let managedObj = appDel.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        do {
            userObj = try managedObj.fetch(fetchRequest) as! [NSManagedObject]
            print(userObj)
            print("Data is fetching")
            tblUserList.reloadData()
        } catch {
            print("Data is not fetching", error.localizedDescription)
        }
    }
}

extension userListVC:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userObj.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblUserList.dequeueReusableCell(withIdentifier: "userListCell", for: indexPath) as! userListCell
        let userData = userObj[indexPath.row]
        let name = userData.value(forKey: "name") as? String
        cell.lblName.text = userData.value(forKey: "name") as? String ?? "Name"
        cell.lblContact.text = userData.value(forKey: "contact") as? String ?? "Contact"
        cell.lblLogo.layer.cornerRadius = cell.lblLogo.frame.size.height/2
        cell.lblLogo.clipsToBounds = true
        cell.lblLogo.layer.borderWidth = 2.0
        cell.lblLogo.layer.borderColor = UIColor.red.cgColor
            cell.lblLogo.text = String(name!.prefix(1))
        cell.imgLogo.layer.cornerRadius = cell.imgLogo.frame.size.width/2
        cell.imgLogo.clipsToBounds = true
        cell.imgLogo.image = UIImage(data: userData.value(forKey: "image") as! Data)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let usrData = userObj[indexPath.row]
        let updateVC = storyboard?.instantiateViewController(withIdentifier: "UpdateVC") as! UpdateVC
        updateVC.userInfo = usrData
        navigationController?.pushViewController(updateVC, animated: true)
        print(usrData)
    }
}
