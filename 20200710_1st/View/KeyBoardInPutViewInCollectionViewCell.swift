//
//  KeyBoardInPutViewInCollectionViewCell.swift
//  20200710_1st
//
//  Created by Dustin on 2020/07/17.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

class KeyBoardInPutViewInCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    override func draw(_ rect: CGRect) { //Your code should go here.
        super.draw(rect)
        self.layer.cornerRadius = self.frame.size.width / 2

    }

}
