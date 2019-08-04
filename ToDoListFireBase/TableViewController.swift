//
//  TableViewController.swift
//  ToDoListFireBase
//
//  Created by IMCS2 on 8/1/19.
//  Copyright © 2019 Tanishk. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items: [GroceryItem] = []
    var keyArray: [String] = []
    //var vc: ViewController
    @IBOutlet weak var TableViewOutlet: UITableView!
    var ref: DatabaseReference!
    var namedata: NSDictionary = [:]
    var yourArray = [[String: Any]]()
    
   
    
    func fetchDataFromFirebase() {
        
        
        
       
        
        ref = Database.database().reference().child("To Do List")
        
        //reading value from backend
        ref.observe(.value) { (snapshot: DataSnapshot) in
           listArray.removeAll()
            for nameValue in snapshot.children {
                
                let snapshotContent = nameValue as? DataSnapshot
                self.keyArray.append(snapshotContent!.key)
                print("this is snapshot content \(snapshotContent)")
                print(type(of: snapshotContent))
                self.namedata =  (snapshotContent?.value as? NSDictionary)!
                listArray.append(self.namedata.value(forKey: "List Items") as? String ?? "")
                self.TableViewOutlet.reloadData()
                
                print("this is fetched list array \(listArray)")
                
                
                
                print(self.namedata["List Items"] as? String)
                
            }
            
           
            
            
            
            
            
        }
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoListTableViewCell
        
        //  print("fff \(secondVC.listArray)")
        
        cell.CellLabel.text = listArray[indexPath.row]
        
        
        
        
        //Configure the cell...
        
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // self.TableViewOutlet.reloadData()
        //        tableView.dataSource = self
        //        tableView.delegate = self
        TableViewOutlet.dataSource = self
        TableViewOutlet.delegate = self
        
        fetchDataFromFirebase()
         //xTableViewOutlet.reloadData()
        // UserDefaults.standard.removeObject(forKey: "name")
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
       

       // TableViewOutlet.reloadData()


    }
    
   override func viewWillAppear(_ animated: Bool) {
    fetchDataFromFirebase()

     // TableViewOutlet.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let cell = self.TableViewOutlet.cellForRow(at: indexPath) as! ToDoListTableViewCell
        cell.CellLabel.textColor = .black
        self.TableViewOutlet.reloadData()
        let currentName = listArray[indexPath.row]
        let valuetodisp = keyArray[indexPath.row]
       print("this is key array \(valuetodisp)")
        
        if editingStyle == .delete {
            print("deleted this")
           print(ref.child("To Do List").child(valuetodisp))
             ref = Database.database().reference().child("To Do List").child(valuetodisp)
            ref.removeValue()
            
           
           
            listArray.remove(at: indexPath.row)
            // print("\(listArray[indexPath.row])  deleted")
            
            
            
           
            //reading value from backend
           
            self.TableViewOutlet.deleteRows(at: [indexPath], with: .automatic)
            
            
            
        
            
            
            // UserDefaults.standard.set(listArray, forKey: "namedd")
            
        }
        
        //        let cell = self.TableViewOutlet.cellForRow(at: indexPath) as! ToDoListTableViewCell
        cell.CellLabel.textColor = .black
        // self.TableViewOutlet.reloadData()
        
        
        self.TableViewOutlet.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let cell = self.TableViewOutlet.cellForRow(at: indexPath) as! ToDoListTableViewCell
        cell.CellLabel.textColor = .blue
       
        self.TableViewOutlet.reloadData()
        
        
        return nil
        
        
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
