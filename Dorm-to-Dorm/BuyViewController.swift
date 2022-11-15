//
//  BuyViewController.swift
//  Dorm-to-Dorm
//
//  Created by Cate on 11/9/22.
//

import UIKit
import FirebaseAuth

//use for fetching from database
struct Item: Decodable {
    let uid: String!
    let name: String!
    let description: String!
    let price: Double!
    
}

class BuyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var user: FirebaseAuth.User!
    
    var saleItems:[String] = ["test1", "test2", "test3", "test1", "test2", "test3", "test1", "test2", "test3"]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BuyCollectionViewCell
    
        if saleItems.count == 0 { // or images is empty
            cell.itemImage?.image = nil
            cell.itemLabel?.text = nil
        } else{
           // cell.itemImage?.image =

            cell.itemLabel?.text = saleItems[indexPath.row]
        }
        cell.backgroundColor = .gray

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return saleItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let detailedViewController = storyboard!.instantiateViewController(withIdentifier: "detailed") as! SpecificBuyViewController
        
        let name = String(saleItems[indexPath.row] )
     
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
        cacheImages()
        // Do any additional setup after loading the view.
    }
    
    func fetchData(){
        //fetch data from database and put into item objects
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
