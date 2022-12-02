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
struct Item: Decodable {
    let ownerID: String!
    let itemName: String!
    let sellDate: String!
    let location: String!
    let deliver: Bool!
    let imageID: String!
    let dateAdded: String!
}

class BuyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
//    var user: FirebaseAuth.User!
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    var saleItems:[String] = ["test1", "test2", "test3", "test1", "test2", "test3", "test1", "test2", "test3"]
    
    
    var newItems:[Item] = [Item]()
    var imageCache : [UIImage] = []
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BuyCollectionViewCell
        
        if newItems.count == 0 {
            cell.itemImage?.image = nil
            cell.itemLabel?.text = nil
        } else {
            if (indexPath.section * 3 + indexPath.row) > imageCache.count - 1 {
                cell.itemImage?.image = nil
            } else {
                cell.itemImage.image = imageCache[indexPath.section * 3 + indexPath.row]
            }
            let currItem = newItems[indexPath.section * 3 + indexPath.row]
            cell.itemLabel?.text = currItem.itemName
        }
//        cell.backgroundColor = .gray

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let specificBuyViewController = storyboard!.instantiateViewController(withIdentifier: "detailed") as! SpecificBuyViewController
        
        let currItem = newItems[indexPath.section * 3 + indexPath.row]
        let currImage = imageCache[indexPath.section * 3 + indexPath.row]
        
        specificBuyViewController.item = currItem
        specificBuyViewController.image = currImage

        navigationController?.pushViewController(specificBuyViewController, animated: true)
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
        cacheImages()
        // Do any additional setup after loading the view.
    }
    
    func fetchData(){
        //fetch data from database and put into item objects
        db.collection("items").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let current = document.data()
                    let item = Item(ownerID: current["ownerID"] as! String, itemName: current["itemName"] as! String, sellDate: current["itemName"] as! String, location: current["location"] as! String, deliver: current["deliver"] as! Bool, imageID: current["imageID"] as! String, dateAdded: current["dateAdded"] as! String)
                    self.newItems.append(item)
                    
                    let imageRef = self.storage.reference().child("images/" + (current["imageID"] as! String))

                    // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                    imageRef.getData(maxSize: 100 * 1024 * 1024) { data, error in
                      if let error = error {
                        // Uh-oh, an error occurred!
                          print(error)
                      } else {
                        // Data for "images/island.jpg" is returned
                          if let image = UIImage(data: data!) {
                              self.imageCache.append(image)
                              self.collectionView.reloadData()
                          }
                      }
                    }
                    
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func cacheImages(){
        //cache images from fetched data
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
