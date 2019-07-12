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
    @IBOutlet var changingTeam: UIButton!
    @IBOutlet var points: UIButton!
    @IBOutlet var changingServerTeam: UIButton!
    var pickerView: UIPickerView = UIPickerView()
    var team0numArray: [String] = []
    var team1numArray: [String] = []
    var selectedTeam = false
    var selectedServerTeam = false
    var changingPlayer = false
    var overViewArray = ["SE","SP","S"]
    var point0: Int=0
    var point1: Int=0
    
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
        
        pickerView.delegate = self as? UIPickerViewDelegate
        pickerView.dataSource = self as? UIPickerViewDataSource
        pickerView.showsSelectionIndicator = true
        
        server.inputView = pickerView
        overView.inputView = pickerView
        overViewNumber.inputView = pickerView
        changingPlayerOut.inputView = pickerView
        
        
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
            
        }else{
            team0numArray = (gameArray[rowNum].team0?.player0.map {$0.player})!
            team1numArray = (gameArray[rowNum].team1?.player1.map {$0.player})!
            
        }
        
    }
    
    
    @IBAction func team(){
        selectedTeam.toggle()
        if selectedTeam == false{
            changingTeam.setTitle("A", for: .normal)
            points.setTitle(String(point0), for: .normal)
            point1 = (gameArray[rowNum].set.last?.points.filter {$0.team == TeamType.Team0}.count ?? 0)
        }else{
            changingTeam.setTitle("B", for: .normal)
            points.setTitle(String(point1), for: .normal)
            point0 = (gameArray[rowNum].set.last?.points.filter {$0.team == TeamType.Team0}.count ?? 0) 
        }
        server.text = ""
        overView.text = ""
        overViewNumber.text = ""
        changingPlayerOut.text = ""
        changingPlayerIn.text = ""
    }
    @IBAction func set(){
        let set = Set()
        
        try! realm.write {
            gameArray[rowNum].set.append(set)
        }
        
    }
    @IBAction func point(){
        if selectedTeam == false{
            point0 = (gameArray[rowNum].set.last?.points.filter {$0.team == TeamType.Team0}.count ?? 0) + 1
            points.setTitle(String(point0), for: .normal)
        }else{
            point1 = (gameArray[rowNum].set.last?.points.filter {$0.team == TeamType.Team1}.count ?? 0) + 1
            points.setTitle(String(point1), for: .normal)
        }
    }
    @IBAction func time(){
        if selectedTeam == false{
            
        }else{
            
        }
    }
    @IBAction func changing(){
        changingPlayer.toggle()
        if selectedTeam == false{
            
        }else{
            
        }
    }
    @IBAction func input(){
        changingPlayer = false
        server.text = ""
        overView.text = ""
        overViewNumber.text = ""
        changingPlayerOut.text = ""
        changingPlayerIn.text = ""
    }
    @IBAction func serverTeam(){
        selectedServerTeam.toggle()
        if selectedServerTeam == false{
            changingServerTeam.setTitle("A", for: .normal)
        }else{
            changingServerTeam.setTitle("B", for: .normal)
        }
        server.text = ""
    }
}
extension DataViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if overView.isFirstResponder{
            return overViewArray.count
        }else{
            if selectedTeam == false{
                return team0numArray.count
            }else{
                return team1numArray.count
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if overView.isFirstResponder{
            return overViewArray[row]
        }else{
            if selectedTeam == false{
                return team0numArray[row]
            }else{
                return team1numArray[row]
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if selectedTeam == false{
            if server.isFirstResponder {
                self.server.text = team0numArray[row]
            } else if overView.isFirstResponder {
                overView.text = overViewArray[row]
            } else if overViewNumber.isFirstResponder{
                overViewNumber.text = team0numArray[row]
            }else if changingPlayerIn.isFirstResponder{
                if changingPlayer == true {
                    changingPlayerIn.text = team0numArray[row]
                }else{
                    changingPlayerIn.isUserInteractionEnabled = false
                }
            } else if changingPlayerOut.isFirstResponder{
                if changingPlayer == true {
                    changingPlayerOut.text = team0numArray[row]
                }else{
                    changingPlayerOut.isUserInteractionEnabled = false
                }
            }
        }else{
            if server.isFirstResponder {
                self.server.text = team1numArray[row]
            } else if overView.isFirstResponder {
                overView.text = overViewArray[row]
            } else if overViewNumber.isFirstResponder{
                    overViewNumber.text = team1numArray[row]
            }else if changingPlayerIn.isFirstResponder{
                if changingPlayer == false {
                    changingPlayerIn.text = team1numArray[row]
                }else{
                    changingPlayerIn.isUserInteractionEnabled = false
                }
            } else if changingPlayerOut.isFirstResponder{
                if changingPlayer == false {
                    changingPlayerOut.text = team1numArray[row]
                }else{
                    changingPlayerOut.isUserInteractionEnabled = false
                }
            }
        }
    }
    
    

    
}


