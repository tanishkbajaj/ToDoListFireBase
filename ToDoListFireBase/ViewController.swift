//
//  ViewController.swift
//  ToDoListFireBase
//
//  Created by IMCS2 on 8/1/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

var listArray: [String] = []
class ViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    
    @IBOutlet weak var GetDataTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func writeToFirebase() {
        
        ref = Database.database().reference().child("To Do List")
        ref.childByAutoId().child("List Items").setValue(GetDataTextField.text)
        
        
        
    }
    
    
    
    
    @IBAction func SubmitButtonPressed(_ sender: Any){
        
        
        writeToFirebase()
        print("from Button \(listArray)")
        
        self.navigationController?.popViewController(animated: true)
        
        
        
    }
    
    
}
