//
//  SellViewController.swift
//  Dorm-to-Dorm
//
//  Created by Cate on 11/9/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class SellViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

//    var user: FirebaseAuth.User!
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
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
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
                return
        }
        firstImage.contentMode = .scaleAspectFit
        firstImage.image = pickedImage
        dismiss(animated: true)
    }
    
    @IBAction func postButtonClicked(_ sender: Any) {
        print("post button clicked")
        let userID = UserDefaults.standard.string(forKey: "userID")
        let timestamp = String(NSDate().timeIntervalSince1970)
        let imageTitle = (userID ?? "unkown") + timestamp
        let riversRef = storage.reference().child("images/" + imageTitle)

        guard let imageData = firstImage.image?.pngData() else {
            return
        }
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putData(imageData, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
          riversRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
          }
        }
        
        if itemDescription.text != "" && location.text != ""{
            print("button pressed")
        let itemName = itemDescription.text ?? ""
            let timeFormatter = DateFormatter()
            timeFormatter.timeStyle = DateFormatter.Style.short

            let sellDate = timeFormatter.string(from: sellDate.date)
            let location = location.text
            let deliver = deliver.isOn
            
        let itemData: [String: Any] = [
            "ownerID": userID ?? "unknown",
            "itemName": itemName,
            "sellDate": sellDate,
            "location": location ?? "unknown",
            "deliver": deliver,
            "imageID" : imageTitle,
            "dateAdded": timestamp
        ]
            
        let db = Firestore.firestore()
        let docRef = db.collection("items").document(imageTitle)
            
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
                               self.itemDescription.text = ""
                               self.location.text = ""
                           }
        
                       }
        } else{
            print("empty fields")
            let failureAdd = UIAlertController(title: "Form Incomplete", message: "Please fill all sections of sell form to publish item.", preferredStyle: UIAlertController.Style.alert)

            failureAdd.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
              print("Handle Ok logic here")
              }))

            self.present(failureAdd, animated: true, completion: nil)
            
            
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

}
