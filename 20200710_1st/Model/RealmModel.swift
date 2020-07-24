//
//  RealmModel.swift
//  20200710_1st
//
//  Created by Dustin on 2020/07/17.
//  Copyright © 2020 Dustin. All rights reserved.
//

import Foundation
import RealmSwift


// 업무 , 개인 ,여가 ...
class Category: Object {
    
    //ID
    @objc dynamic var id = 0
    @objc dynamic var name = "" //이름
    @objc dynamic var regdate = Date() //등록 일
    @objc dynamic var edit = false // 편집에서 활용
    
    let todo = List<toDo>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
}

//업무 - iOS, swift, 집...
//개인 - 비행기 , 숙소, 장...
class toDo: Object {
    
    //ID
    
    @objc dynamic var id = 0
    @objc dynamic var name = "" //이름
    @objc dynamic var deadline: Date? = nil
    //마감 일
    @objc dynamic var regdate = Date() //등록 일
    @objc dynamic var edit = false // 편집에서 활용
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
}
