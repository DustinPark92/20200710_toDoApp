//
//  ColorExtension.swift
//  20200710_1st
//
//  Created by Dustin on 2020/07/10.
//  Copyright © 2020 Dustin. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    
    // 변수 , 상수 => 프로퍼티(2회차) : 저장,연산,옵저버...
    // extension은 연산을 좋아한다.
    var bg : UIColor {
        return UIColor(named: "bg")!
    }
    var main : UIColor {
        return UIColor(named: "main")!
    }
    var sub : UIColor {
        return UIColor(named: "sub")!
    }
    
    var line : UIColor {
        return UIColor(named: "sub")!.withAlphaComponent(0.5)
    }
    
    var textMain : UIColor {
        return UIColor(named: "textMain")!
    }
    
    
    
    
    
}
