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
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded!")
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
        print("button pressed")

        if usernameField.text != nil && passwordField.text != nil {
            Auth.auth().signIn(withEmail: usernameField.text!, password: passwordField.text!) {authResult, error in
                guard let user = authResult?.user, error == nil else {
                    self.warningLabel.text = error?.localizedDescription
                    return
                }
                print(type(of: user))
                // navigate to home screen
                self.setUser(user: user)
                let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "tabVC") //as! HomeViewController
                self.navigationController?.pushViewController(tabVC!, animated: true)
                self.navigationController?.setNavigationBarHidden(true, animated: false)
                self.warningLabel.text = ""
                }
            }
    }
    
    func setUser(user: FirebaseAuth.User) {
        UserDefaults.standard.set(user.uid, forKey: "userID")
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
        let sellVC = self.storyboard?.instantiateViewController(withIdentifier: "sellVC") as! SellViewController
        let buyVC = self.storyboard?.instantiateViewController(withIdentifier: "buyVC") as! BuyViewController
        homeVC.user = user
        sellVC.user = user
        buyVC.user = user
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
