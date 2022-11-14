//
//  SpecificBuyViewController.swift
//  Dorm-to-Dorm
//
//  Created by Cate on 11/9/22.
//

import UIKit

class SpecificBuyViewController: UIViewController {

    var itemName:String?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var contactInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTitle.text = itemName ?? ""
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
