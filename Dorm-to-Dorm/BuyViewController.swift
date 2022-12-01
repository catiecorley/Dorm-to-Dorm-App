//
//  BuyViewController.swift
//  Dorm-to-Dorm
//
//  Created by Cate on 11/9/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

//use for fetching from database
//example of fetching for one id
// Firestore.firestore().collection("Posts").whereField("postedTo", arrayContains: userId).order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in

class BuyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
  
    struct Item {
        let dateAdded: String?
        let deliver: Bool?
        let imageID: String?
        let itemName: String?
        let location: String?
        let ownerID: String?
        let sellDate: String?
    }

    var theItems: [Item] = []
    
    var user: FirebaseAuth.User!
    
    var saleItems:[String] = ["test1", "test2", "test3", "test1", "test2", "test3", "test1", "test2", "test3"]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BuyCollectionViewCell
    
        if saleItems.count == 0 { // or images is empty
            cell.itemImage?.image = nil
            cell.itemLabel?.text = nil
        } else{
           // cell.itemImage?.image =

            cell.itemLabel?.text = theItems[indexPath.row].itemName
        }
        cell.backgroundColor = .gray

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return theItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let detailedViewController = storyboard!.instantiateViewController(withIdentifier: "detailed") as! SpecificBuyViewController
        
        let name = theItems[indexPath.row].itemName
     
        detailedViewController.itemName = name

        navigationController?.pushViewController(detailedViewController, animated: true)
    }

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var priceSelector: UISegmentedControl!
    
    @IBOutlet weak var roomSelector: UISegmentedControl!
    @IBOutlet weak var colorSelector: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellSize = collectionView.bounds.width / 3 - 10
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        layout.itemSize = CGSize(width: cellSize, height: cellSize + cellSize / 2)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 10
   
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        fetchData()
//        cacheImages()
        // Do any additional setup after loading the view.
    }
    
 
    
    func fetchData() {
        let db = Firestore.firestore()

        db.collection("items").getDocuments() { (snapshot, error) in
                        if let error = error {
                                print("Error getting documents: \(error)")
                        } else {
                            if let snapshot = snapshot, !snapshot.isEmpty {
                                           print("Posted data got")
                                           
                                           self.theItems = snapshot.documents.map { document in
                                               Item(dateAdded: document.get("dateAdded") as? String,
                                                    deliver:  document.get("deliver") as? Bool,
                                                    imageID: document.get("imageID") as? String,
                                                    itemName: document.get("itemName") as? String,
                                                    location: document.get("location") as? String,
                                                    ownerID: document.get("ownerID") as? String,
                                                    sellDate: document.get("sellDate") as? String)
                                                        
                                           }
                        }
                            
        }
            
    }
    }
    func cacheImages(){
        //cache images from fetched data
    }
}
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


