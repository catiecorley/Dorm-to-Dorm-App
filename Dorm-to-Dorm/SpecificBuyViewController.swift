//
//  SpecificBuyViewController.swift
//  Dorm-to-Dorm
//
//  Created by Cate on 11/9/22.
//

import UIKit

class SpecificBuyViewController: UIViewController {

    var item: Item!
    var image: UIImage!
    
    var thisname: String!
    var thislocation: String!
    var thisdate: String!
    var deliverabletext: String!
    var contact: String!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var deliverable: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var location: UILabel!
 
    @IBOutlet weak var contactInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView?.image = image
        
        itemTitle?.text = thisname
        location?.text = thislocation
        date?.text = thisdate
        deliverable?.text = deliverabletext
        contactInfo.text = contact ?? "No Contact Info..."
        // Do any additional setup after loading the view.
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
