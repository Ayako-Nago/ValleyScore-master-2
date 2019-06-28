//
//  DataViewCell.swift
//  ValleyScore
//
//  Created by Ayako Nago on 2019/06/21.
//  Copyright © 2019 Ayako Nago. All rights reserved.
//

import UIKit

class DataViewCell: UITableViewCell {

    @IBOutlet var team0Point: UILabel!
    @IBOutlet var team0Server: UILabel!
    @IBOutlet var team0OverView: UILabel!
    @IBOutlet var team0OverViewNumber: UILabel!
    @IBOutlet var team1Point: UILabel!
    @IBOutlet var team1Server: UILabel!
    @IBOutlet var team1OverView: UILabel!
    @IBOutlet var team1OverViewNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
