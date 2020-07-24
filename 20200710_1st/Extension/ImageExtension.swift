//
//  ImageExtension.swift
//  20200710_1st
//
//  Created by Dustin on 2020/07/10.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit

extension UIImage {
    
    
    var tag : UIImage {
        return UIImage(named: "tag")!.withTintColor(UIColor().main, renderingMode: .alwaysOriginal)
      }
    
    var profile : UIImage {
        return UIImage(systemName: "person.circle.fill")!.withTintColor(UIColor().main, renderingMode: .alwaysOriginal)
      }
    
    
    
}

