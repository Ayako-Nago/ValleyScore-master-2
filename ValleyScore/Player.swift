//
//  Player.swift
//  ValleyScore
//
//  Created by Ayako Nago on 2019/05/17.
//  Copyright © 2019 Ayako Nago. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    let game = List<Game>()
}
class Game: Object {
    let set = List<Set>()
    @objc dynamic var  team0: Team0?
    @objc dynamic var  team1: Team1?
    @objc dynamic var createdBy = Date()
}
class Team0: Object{
    @objc dynamic var team0Name = " "
    let player0 = List<Player0>()
}
class Player0: Object{
    @objc dynamic var player = " "
}

class Team1: Object{
    @objc dynamic var team1Name = " "
    let player1 = List<Player1>()
}
class Player1: Object{
    @objc dynamic var player = " "
}
class Set: Object{
    let points = List<Points>()
}
class Points: Object {
    @objc dynamic private var teamInt = 0
    @objc dynamic var teamPoint = 0
    @objc dynamic var serverTeam = false
    @objc dynamic var server = 0
    @objc dynamic var outline = " "
    @objc dynamic var player = 0
    
    var team: TeamType {
        get {
            return TeamType(rawValue: teamInt) ?? TeamType.Team0
        }
        set {
            teamInt = newValue.rawValue
        }
    }
}
enum TeamType: Int{
    case Team0 = 0
    case Team1 = 1
    
}
