//
//  NavigationController.swift
//  ValleyScore
//
//  Created by Ayako Nago on 2019/05/31.
//  Copyright © 2019 Ayako Nago. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    /*
     navigationBarの線(shadowImage)はUIImageとして保存されています!でも、線を消すためにshadowImageに空のUIImageをセットすると元のUIImageが消えてしまい、線を付けたいときに困ったことになります。そのため、もともとセットされていたUIImageを別の変数に代入しておいて、後から線を付けたいときに利用できるようにします！
     
     
     まず、最初にのviewにセットされているshadowImageを新しく作ったimageという変数に代入しておく
     線を消したい時：線を消したいviewControllerでshadowImageに空のUIImageをセットする
     線を付けたい時：線をけ付けたいviewControllerでshadowImageに最初に作ったimageをセットする
     
     */
    
    var image: UIImage! //線のUIImageを覚えておくための変数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image = navigationBar.shadowImage //imageにもともとの線のUIImageを代入しておく
        // Do any additional setup after loading the view.
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
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
