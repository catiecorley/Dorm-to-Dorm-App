//
//  LogInViewController.swift
//  Dorm-to-Dorm
//
//  Created by Cate on 11/9/22.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButtonClicked(_ sender: Any) {
//        if usernameField.text != nil && passwordField.text != nil {
//            Auth.auth().createUser(withEmail: usernameField.text!, password: passwordField.text!) { authResult, error in
//                guard let user = authResult?.user, error == nil else {
//                    print(error?.localizedDescription)
//                    return
//                }
//
//                let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
//                self.navigationController?.setViewControllers([homeVC], animated: false)
//            }
//        }
        
        if usernameField.text != nil && passwordField.text != nil {
            Auth.auth().signIn(withEmail: usernameField.text!, password: passwordField.text!) {authResult, error in
                guard let user = authResult?.user, error == nil else {
                    print(error?.localizedDescription)
                    return
                }
                
                print("Email: " + user.email!)
                // navigate to home screen
                }
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
