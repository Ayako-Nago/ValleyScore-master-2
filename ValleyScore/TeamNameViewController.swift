//
//  TeamNameViewController.swift
//  ValleyScore
//
//  Created by Ayako Nago on 2019/05/18.
//  Copyright © 2019 Ayako Nago. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class TeamNameViewController: UIViewController, UITextFieldDelegate {
    
    var game: Game!
    @IBOutlet var team0NameTextField: UITextField!
    @IBOutlet var team0Left1TextField: UITextField!
    @IBOutlet var team0Left2TextField: UITextField!
    @IBOutlet var team0Right1TextField: UITextField!
    @IBOutlet var team0Right2TextField: UITextField!
    @IBOutlet var team0Center1TextField: UITextField!
    @IBOutlet var team0Center2TextField: UITextField!
    @IBOutlet var team0LibeloTextField: UITextField!
    @IBOutlet var team1NameTextField: UITextField!
    @IBOutlet var team1Left1TextField: UITextField!
    @IBOutlet var team1Left2TextField: UITextField!
    @IBOutlet var team1Right1TextField: UITextField!
    @IBOutlet var team1Right2TextField: UITextField!
    @IBOutlet var team1Center1TextField: UITextField!
    @IBOutlet var team1Center2TextField: UITextField!
    @IBOutlet var team1LibeloTextField: UITextField!
    lazy var realm = try! Realm()
    var gameArray = [Game]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.team0Left1TextField.keyboardType = UIKeyboardType.numberPad
        self.team0Left2TextField.keyboardType = UIKeyboardType.numberPad
        self.team0Right1TextField.keyboardType = UIKeyboardType.numberPad
        self.team0Right2TextField.keyboardType = UIKeyboardType.numberPad
        self.team0Center1TextField.keyboardType = UIKeyboardType.numberPad
        self.team0Center2TextField.keyboardType = UIKeyboardType.numberPad
        self.team0LibeloTextField.keyboardType = UIKeyboardType.numberPad
        self.team1Left1TextField.keyboardType = UIKeyboardType.numberPad
        self.team1Left2TextField.keyboardType = UIKeyboardType.numberPad
        self.team1Right1TextField.keyboardType = UIKeyboardType.numberPad
        self.team1Right2TextField.keyboardType = UIKeyboardType.numberPad
        self.team1Center1TextField.keyboardType = UIKeyboardType.numberPad
        self.team1Center2TextField.keyboardType = UIKeyboardType.numberPad
        self.team1LibeloTextField.keyboardType = UIKeyboardType.numberPad
        
        gameArray = realm.objects(Game.self).sorted{$0.createdBy > $1.createdBy}
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let nc = navigationController as! NavigationController
        //NavigationControllerに自分で作ったimageにアクセスするために一旦ダウンキャストする
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationController!.navigationBar.isTranslucent = true ;

        navigationController?.navigationBar.shadowImage = UIImage()
//        nc.navigationBar.shadowImage = nc.image //線を付けたいときは最初にimageに保存しておいたUIImageを使って線をだします！
        
    }
    @IBAction func back(){
       let index = navigationController!.viewControllers.count - 3
        navigationController?.popToViewController(navigationController!.viewControllers[index],animated: true)
        //２つ前の画面に戻るコードを書きたい　← １つ前の画面に戻った
        try! realm.write {
            var tmpGameArray = realm.objects(Game.self).sorted{$0.createdBy > $1.createdBy}
            realm.delete(game)
            //新しく作ったGameを破棄したい　← 一番最初の要素がは消去される
            print("deleted")
            print(gameArray)
        }
    }
    @IBAction func end(){
        
        try! realm.write {
           
            game.team0 = Team0()
            game.team1 = Team1()
            game.team0?.team0Name = team0NameTextField.text ?? ""
            game.team1?.team1Name = team1NameTextField.text ?? ""
            game.team0?.player0.append(Player0())
            game.team0?.player0[0].player = team0Left1TextField.text ?? ""
            game.team0?.player0.append(Player0())
            game.team0?.player0[1].player = team0Left2TextField.text ?? ""
            game.team0?.player0.append(Player0())
            game.team0?.player0[2].player = team0Right1TextField.text ?? ""
            game.team0?.player0.append(Player0())
            game.team0?.player0[3].player = team0Right2TextField.text ?? ""
            game.team0?.player0.append(Player0())
            game.team0?.player0[4].player = team0Center1TextField.text ?? ""
            game.team0?.player0.append(Player0())
            game.team0?.player0[5].player = team0Center2TextField.text ?? ""
            game.team0?.player0.append(Player0())
            game.team0?.player0[6].player = team0LibeloTextField.text ?? ""
            game.team1?.player1.append(Player1())
            game.team1?.player1[0].player = team1Left1TextField.text ?? ""
            game.team1?.player1.append(Player1())
            game.team1?.player1[1].player = team1Left2TextField.text ?? ""
            game.team1?.player1.append(Player1())
            game.team1?.player1[2].player = team1Right1TextField.text ?? ""
            game.team1?.player1.append(Player1())
            game.team1?.player1[3].player = team1Right2TextField.text ?? ""
            game.team1?.player1.append(Player1())
            game.team1?.player1[4].player = team1Center1TextField.text ?? ""
            game.team1?.player1.append(Player1())
            game.team1?.player1[5].player = team1Center2TextField.text ?? ""
            game.team1?.player1.append(Player1())
            game.team1?.player1[6].player = team1LibeloTextField.text ?? ""
        
        }
        
        let vc = navigationController?.viewControllers[(navigationController?.viewControllers.count)! - 2] as! DataViewController
        vc.team0numArray = (game.team0?.player0.map {$0.player})!
        vc.team1numArray = (game.team1?.player1.map {$0.player})!
        self.navigationController?.popViewController(animated: true)
        
    }

    
    
}
