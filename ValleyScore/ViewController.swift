//
//  ViewController.swift
//  ValleyScore
//
//  Created by Ayako Nago on 2019/05/10.
//  Copyright © 2019 Ayako Nago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.shadowImage = UIImage() //線を消したいときは空のUIImageを代入する
        self.navigationController!.navigationBar.isTranslucent = true ;
        navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController!.navigationBar.shadowImage = UIImage()
        
    }


}

