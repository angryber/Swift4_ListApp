//
//  myTableVeiwCell.swift
//  ListApp
//
//  Created by angryber.arc on 11/02/2018.
//  Copyright © 2018 angryber. All rights reserved.
//

import UIKit

class myTableVeiwCell: UITableViewCell {
    
    var backgoundIndex = 0
    
    //gesture selector is from object-c, so the function should add @objc to change swift4 code to object-c
    @objc func changeBackgroundColor(){
        //self.backgroundColor = UIColor.blue
        switch backgoundIndex{
        case 0:
            self.backgroundColor = UIColor.gray
            backgoundIndex += 1
        case 1:
            self.backgroundColor = UIColor.red
            backgoundIndex += 1
        case 2:
            self.backgroundColor = UIColor.green
            backgoundIndex += 1
        case 3:
            self.backgroundColor = UIColor.blue
            backgoundIndex += 1
        case 4:
            self.backgroundColor = UIColor.purple
            backgoundIndex += 1
        case 5:
            self.backgroundColor = UIColor.magenta
            backgoundIndex += 1
        case 6:
            self.backgroundColor = UIColor.brown
            backgoundIndex += 1
        default:
            self.backgroundColor = UIColor.white
            backgoundIndex = 0
        }
    }

}
