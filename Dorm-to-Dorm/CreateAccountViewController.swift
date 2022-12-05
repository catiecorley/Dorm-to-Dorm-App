//
//  CreateAccountViewController.swift
//  Dorm-to-Dorm
//
//  Created by Arielle Bauer on 11/28/22.
//

import UIKit
import FirebaseAuth

class CreateAccountViewController: UIViewController {

   
   
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var warning: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func createButton(_ sender: UIButton) {
        
        if username.text != nil && password.text != nil {
                  Auth.auth().createUser(withEmail: username.text!, password: password.text!) { authResult, error in
                     guard let user = authResult?.user, error == nil else {
                         self.warning.text = error?.localizedDescription
                     return
    }
                      self.setUser(user: user)
                      let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "tabVC") //as! HomeViewController
                     
                      self.navigationController?.pushViewController(tabVC!, animated: true)
                      self.navigationController?.setNavigationBarHidden(true, animated: false)
                      
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
            
        }}
    
    
    func setUser(user: FirebaseAuth.User) {
        UserDefaults.standard.set(user.uid, forKey: "userID")
    }
}
