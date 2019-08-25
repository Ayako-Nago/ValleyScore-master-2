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
//    var gameArray = [Game]()
//    var rowNum: Int = -1
    var game: Game?
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
    var timeTeam = false
    var overViewArray = ["B","SP","S","T","F"]
    var point0: Int=0
    var point1: Int=0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if game == nil{
            return 0
        }
        if game?.set.isEmpty ?? false{
            return 0
        }
        return game?.set[0].points.count ?? 0
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as! DataViewCell
        
        if game?.set[0].points[indexPath.row].team == TeamType.Team0{
            cell.team0Point.text = String(game?.set[0].points[indexPath.row].teamPoint ?? 0)
            cell.team0OverView.text = game?.set[0].points[indexPath.row].outline
            cell.team0OverViewNumber.text = String(game?.set[0].points[indexPath.row].player ?? 0)
            cell.team1Point.text = ""
            cell.team1OverView.text = ""
            cell.team1OverViewNumber.text = ""
        }else{
            cell.team1Point.text = String(game?.set[0].points[indexPath.row].teamPoint ?? 0)
            cell.team1OverView.text = game?.set[0].points[indexPath.row].outline
            cell.team1OverViewNumber.text = String(game?.set[0].points[indexPath.row].player ?? 0)
            cell.team0Point.text = ""
            cell.team0OverView.text = ""
            cell.team0OverViewNumber.text = ""
        }
        if game?.set[0].points[indexPath.row].serverTeam == false{
            cell.team0Server.text = String(game?.set[0].points[indexPath.row].server ?? 0)
            cell.team1Server.text = ""
        }else{
            cell.team1Server.text = String(game?.set[0].points[indexPath.row].server ?? 0)
            cell.team0Server.text = ""
        }
        
       return cell
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
//        if rowNum == -1 {
//            let newData = Game()
//            try! realm.write(){
//                realm.add(newData)
//            }
//            rowNum = gameArray.endIndex
//        }
//
//        gameArray = realm.objects(Game.self).sorted{$0.createdBy > $1.createdBy}
        
        
        
        
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        
        if game == nil{
            let team = storyboard?.instantiateViewController(withIdentifier: "team")as! TeamNameViewController
            
            
            team.game = Game()
            navigationController?.pushViewController(team, animated: true)
            
        }else{
            team0numArray = (game?.team0?.player0.map {$0.player})!
            team1numArray = (game?.team1?.player1.map {$0.player})!
            
        }
        
    }
    
    
    @IBAction func team(){
        selectedTeam.toggle()
        if selectedTeam == false{
            changingTeam.setTitle("A", for: .normal)
            points.setTitle(String(point0), for: .normal)
            point1 = (game?.set.last?.points.filter {$0.team == TeamType.Team0}.count ?? 0)
        }else{
            changingTeam.setTitle("B", for: .normal)
            points.setTitle(String(point1), for: .normal)
            point0 = (game?.set.last?.points.filter {$0.team == TeamType.Team0}.count ?? 0)
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
            game?.set.append(set)
        }
    }
    @IBAction func point(){
        if selectedTeam == false{
            point0 = (game?.set.last?.points.filter {$0.team == TeamType.Team0}.count ?? 0) + 1
            points.setTitle(String(point0), for: .normal)
        }else{
            point1 = (game?.set.last?.points.filter {$0.team == TeamType.Team1}.count ?? 0) + 1
            points.setTitle(String(point1), for: .normal)
        }
    }
    @IBAction func time(){
        timeTeam = true
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
        
        if game?.set.isEmpty == true{
            let set: Set = Set()
            try! realm .write {
                game?.set.append(set)
                realm.add(game!)
            }
        }
        let points: Points = Points()
        points.team = selectedTeam ? TeamType.Team1 : TeamType.Team0
        if selectedTeam == false{
            points.teamPoint = point0
        }else{
            points.teamPoint = point1
        }
        points.server = Int(server.text ?? "") ?? 0
        points.outline = overView.text ?? ""
        points.player = Int(overViewNumber.text ?? "") ?? 0
        points.serverTeam = selectedServerTeam

        
        
        try! realm.write {
//            set.points.append(points)
            game?.set[0].points.append(points)
            realm.add(game!)
            print(game!)
        }
        tableView.reloadData()
        changingPlayer = false
        timeTeam = false
        server.text = ""
        overView.text = ""
        overViewNumber.text = ""
        changingPlayerOut.text = ""
        changingPlayerIn.text = ""
        
//        gameArray.append(game)
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
        }else if overViewNumber.isFirstResponder{
            if selectedTeam == false{
                return team0numArray.count
            }else{
                return team1numArray.count
            }
        }else if server.isFirstResponder{
            if selectedServerTeam == false{
                return team0numArray.count
            }else{
                return team1numArray.count
            }
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if overView.isFirstResponder{
            return overViewArray[row]
        }else if overViewNumber.isFirstResponder{
            if selectedTeam == false{
                return team0numArray[row]
            }else{
                return team1numArray[row]
            }
        }else if server.isFirstResponder{
            if selectedServerTeam == false{
                return team0numArray[row]
            }else{
                return team1numArray[row]
            }
        }
        return String(0)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if overView.isFirstResponder{
            overView.text = overViewArray[row]
        }else if overViewNumber.isFirstResponder{
            if selectedTeam == false{
                overViewNumber.text = team0numArray[row]
            }else{
                overViewNumber.text = team1numArray[row]
            }
        }else if server.isFirstResponder{
            if selectedServerTeam == false{
                server.text = team0numArray[row]
            }else{
                server.text = team1numArray[row]
            }
        }
    }
}


