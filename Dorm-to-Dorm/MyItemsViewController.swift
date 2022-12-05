//
//  MyItemsViewController.swift
//  Dorm-to-Dorm
//
//  Created by Jacob Dulai on 12/2/22.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseStorage

class MyItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    var myItems:[Item] = [Item]()
    @IBOutlet weak var tableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        myItems.removeAll()
        fetchData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "My Items"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myItem")
        tableView.dataSource = self
        tableView.delegate = self
        myItems.removeAll()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myItem", for: indexPath)
        let currItemName = myItems[indexPath.row].itemName
        cell.textLabel?.text = currItemName
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            removeItem(indexPath: indexPath)
        }
    }
    
    func removeItem(indexPath: IndexPath) {
        print(indexPath.row)
        let currItem = myItems[indexPath.row]
        let userID = UserDefaults.standard.string(forKey: "userID")
        let itemRef = storage.reference().child("images/" + (userID ?? "unknown") + currItem.dateAdded)
        itemRef.delete { error in
          if let error = error {
            // Uh-oh, an error occurred!
              print(error.localizedDescription)
          } else {
            // File deleted successfully
              self.db.collection("items").document((userID ?? "unknown") + currItem.dateAdded).delete() { err in
                  if let err = err {
                      print("Error removing document: \(err)")
                  } else {
                      self.fetchData()
                  }
              }
          }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let itemViewController = storyboard!.instantiateViewController(withIdentifier: "detailed") as! SpecificBuyViewController
      
        let name = String(myItems[indexPath.row].itemName ?? "not found")
        print("name is \(name)")
        itemViewController.thisname = name
        let loc = String(myItems[indexPath.row].location ?? "not found")
        itemViewController.thislocation = loc
        print("loacation is \(loc)")
        let date = String((myItems[indexPath.row].sellDate) ?? "not found")
        print("date is \(date)")
        itemViewController.thisdate = String(date)
        //try and avoid errors
        let deliver = Bool(myItems[indexPath.row].deliver)
        itemViewController.deliverabletext = "Must be picked up."
        
        let contactInfo = String(myItems[indexPath.row].contact)
        itemViewController.contact = String(contactInfo)
        if deliver == true{
            itemViewController.deliverabletext = "This item can be delivered"

        } else{
            itemViewController.deliverabletext = "Must be picked up."

        }
        print("deliver is \(deliver)")

        
        
        let imageid = String(myItems[indexPath.row].imageID ?? "")
        
        let imageRef = self.storage.reference().child("images/" + (imageid))

        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        imageRef.getData(maxSize: 100 * 1024 * 1024) { data, error in
          if let error = error {
            // Uh-oh, an error occurred!
              print(error)
          } else {
            // Data for "images/island.jpg" is returned
              if let image = UIImage(data: data!) {
                  itemViewController.imageView?.image = image
                 // self.collectionView.reloadData()
              }
          }
        }
    
        navigationController?.pushViewController(itemViewController, animated: true)
    }
    
    
    func fetchData() {
        myItems.removeAll()
        
        let userID = UserDefaults.standard.string(forKey: "userID")
        db.collection("items").whereField("ownerID", isEqualTo: userID ?? "")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let current = document.data()
                        let item = Item(ownerID: (current["ownerID"] as! String), itemName: current["itemName"] as! String, sellDate: current["sellDate"] as! String, location: current["location"] as! String, deliver: current["deliver"] as? Bool, imageID: current["imageID"] as! String, dateAdded: current["dateAdded"] as! String, contact: current["contact"] as! String)
                        self.myItems.append(item)
                        print(self.myItems)
                        self.tableView.reloadData()
                    }
                }
        }
    }

}
