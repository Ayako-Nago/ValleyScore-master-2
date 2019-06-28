//
//  DataViewController.swift
//  ValleyScore
//
//  Created by Ayako Nago on 2019/05/24.
//  Copyright © 2019 Ayako Nago. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class DataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var realm = try! Realm()
    var gameArray = [Game]()
    var rowNum: Int = -1
    @IBOutlet var server: UITextField!
    @IBOutlet var overView: UITextField!
    @IBOutlet var overViewNumber: UITextField!
    @IBOutlet var changingPlayerOut: UITextField!
    @IBOutlet var changingPlayerIn: UITextField!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       return UITableViewCell()
    }
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
                self.navigationController!.navigationBar.isTranslucent = false ;
        let nc = navigationController as! NavigationController //NavigationControllerに自分で作ったimageにアクセスするために一旦ダウンキャストする
        nc.navigationBar.shadowImage = nc.image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.changingPlayerIn.keyboardType = UIKeyboardType.numberPad
        if rowNum == -1 {
            let newData = Game()
            try! realm.write(){
                realm.add(newData)
            }
            rowNum = gameArray.endIndex
        }
        gameArray = realm.objects(Game.self).sorted{$0.createdBy > $1.createdBy}
       
        
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        
        if gameArray[rowNum].team0 == nil || gameArray[rowNum].team1 == nil{
            let team = storyboard?.instantiateViewController(withIdentifier: "team")as! TeamNameViewController
            
            team.game = gameArray[rowNum]
            navigationController?.pushViewController(team, animated: true)
            
        }
        
    }
    @IBAction func team(){
        
    }
    @IBAction func point(){
        
    }
    @IBAction func time(){
        
    }
    @IBAction func changing(){
        
    }
    @IBAction func input(){
        
    }
    @IBAction func serverTeam(){
        
    }
}
