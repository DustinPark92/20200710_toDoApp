//
//  RealmQuery.swift
//  20200710_1st
//
//  Created by Dustin on 2020/07/17.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit
import RealmSwift

extension UIViewController {
    
    //전체 카테고리 테이블 가져오기
    
    func getCategoryALL() -> Results<Category> {
        
        let realm = try! Realm()
        let list = realm.objects(Category.self).sorted(byKeyPath: "id" , ascending: true)
        
        return list
    }
    
    //할 일 테이블에 레코드 추가
    
    func saveToDo(cateID : Int, id : Int, name : String, deadline : Date? = nil ) {
        let realm = try! Realm()
        
        let data = toDo()
        
        //filter cateID에서 첫번째꺼
        
        if let parent = realm.objects(Category.self).filter("id = \(cateID)").first {
            data.id  = id
            data.name = name
            data.regdate = Date()
            data.deadline = deadline
            
            
            //do ~ try ~ catch 구문 => transaction 이랑 연관 끝날때 까지 일단 정지.
            do {
                try realm.write {
                    parent.todo.append(data)
                    realm.add(data)
                    print("saveToDo")
                }
            } catch let e as NSError {
                print("\(e.description)")
            }
            
            
        }
    }
    
    func createCateNewID() -> Int {

        let realm = try! Realm()
        if let retNext = realm.objects(Category.self).sorted(byKeyPath: "id", ascending : false).first?.id {
            return retNext + 1
        } else { return 2 }

    }
    
    func createTodoNewID() -> Int {

        let realm = try! Realm()
        if let retNext = realm.objects(toDo.self).sorted(byKeyPath: "id", ascending : false).first?.id {
            return retNext + 1
        } else { return 2 }

    }
    
    func saveCategory(id : Int, name : String) {
        
        let realm = try! Realm()

        let data = Category()
        data.id = id
        data.name = name
        data.regdate = Date()

        do {
            try realm.write {
                realm.add(data)
                print("saveCategory SUCCEED")
            }
        } catch let e as NSError {
            print(e)
        }
    }
    
    func editCate(name: String, id : Int) {
        let realm = try! Realm()
        
              //1.렘 테이블 중 id 기준으로 필터링
        let data = realm.objects(Category.self).filter("id = \(id)").first!
        
        do {
            try realm.write {
                realm.create(Category.self, value: [
                    "id" : data.id,
                    "name" : name
                    
                    
                ], update: .modified)
                
            print("Success Edit Category")
            }
        } catch let e as NSError {

        }
        
    }
    
    func deleteCategory(cateID : Int) {
        let realm = try! Realm()
        //1.렘 테이블 중 id 기준으로 필터링
        let data = realm.objects(Category.self).filter("id = \(cateID)").first!
        //잭에 저장되어있는 모든 코드를 가져온다. 값이 있기 떄문에 forced unwrapping상관 없음.
       
        //2.렘 삭제
        try! realm.write { // do - try - catch 구문
            realm.delete(data)
        }
    }
    
    func deleteTodo(toDoID : Int) {
        let realm = try! Realm()
        //1.렘 테이블 중 id 기준으로 필터링
        let data = realm.objects(toDo.self).filter("id = \(toDoID)").first!
        //잭에 저장되어있는 모든 코드를 가져온다. 값이 있기 떄문에 forced unwrapping상관 없음.
        
        //2.렘 삭제
        try! realm.write { // do - try - catch 구문
            realm.delete(data)
        }
    }
    
    
    
    
}
