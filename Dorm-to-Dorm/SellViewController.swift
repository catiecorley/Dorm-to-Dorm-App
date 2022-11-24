//
//  SellViewController.swift
//  Dorm-to-Dorm
//
//  Created by Cate on 11/9/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SellViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var user: FirebaseAuth.User!
    let db = Firestore.firestore()
    
    @IBOutlet weak var deliver: UISwitch!
    @IBOutlet weak var sellDate: UIDatePicker!
    //    @IBOutlet weak var sellDate: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var itemDescription: UITextField!
    @IBOutlet weak var firstImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func uploadImageClicked(_ sender: Any) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                firstImage.contentMode = .scaleAspectFit
                firstImage.image = pickedImage
        }
        dismiss(animated: true)
    }
    
    @IBAction func postButtonClicked(_ sender: Any) {
        let userID = UserDefaults.standard.string(forKey: "userID")
        
        if itemDescription.text != "" && location.text != ""{
        let itemName = itemDescription.text ?? ""
            let sellDate = sellDate.date
            let location = location.text
            let deliver = deliver.isOn
            
        let itemData: [String: Any] = [
            "ownerID": userID ?? "unknown",
            "itemName": itemName,
            "sellDate": sellDate,
            "location": location ?? "unknown",
            "deliver": deliver,
//            "itemPrice": "1234 Restaurant St",
            "dateAdded": Timestamp(date: Date())
        ]
            
        let db = Firestore.firestore()
        
        let docRef = db.collection("items").document(itemName)
            docRef.setData(itemData) { error in
                           if let error = error {
                               print("Error writing document: \(error)")
                           } else {
                               let successAdded = UIAlertController(title: "Item Added", message: "Your item has been published to be sold.", preferredStyle: UIAlertController.Style.alert)

                               successAdded.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                                 print("Handle Ok logic here")
                                 }))

                               self.present(successAdded, animated: true, completion: nil)
                               
                               
                               print("Document successfully written!")
                           }
                       }
        } else{
            let failureAdd = UIAlertController(title: "Form Incomplete", message: "Please fill all sections of sell form to publish item.", preferredStyle: UIAlertController.Style.alert)

            failureAdd.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
              print("Handle Ok logic here")
              }))

            self.present(failureAdd, animated: true, completion: nil)
            
            
        }
        
    }
        
        
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
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
