//
//  SellViewController.swift
//  Dorm-to-Dorm
//
//  Created by Cate on 11/9/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SellViewController: UIViewController {

    var user: FirebaseAuth.User!
    let db = Firestore.firestore()
    
    @IBOutlet weak var sellDate: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var itemDescription: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func postButtonClicked(_ sender: Any) {
//        if itemDescription.text != nil {
//            let docId = db
//            let item = Item(uid: user.uid, name: "Couch", description: "3 person brown couch", price: 20)
//            db.collection("cities").addDocument(data: [
//                "uid": user.uid,
//                "name": "Couch",
//                "description": itemDescription.text!,
//                "price": 20
//            ]) { err in
//                if let err = err {
//                    print("Error writing document: \(err)")
//                } else {
//                    print("Document successfully written!")
//                }
//            }
//        }
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
