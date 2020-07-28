//
//  TodayViewController.swift
//  20200710_toDoAppWidget
//
//  Created by Dustin on 2020/07/24.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit
import NotificationCenter
//apple framework 신호를 보내주는넘~

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var dateLabel: UILabel!
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //앱에서 저장한 UserDefaults의 내용 가져오기
        let share = UserDefaults(suiteName: "group.Dustin.-0200710-1st")
        // 앱보다 위젯이 먼저 실행될 수 있기 때문에
        let name = share?.object(forKey: "todo") as? String
        dateLabel.text = name ?? "할 일 없습니다."
        print(123)
        
    }
        
    @IBAction func handleButton(_ sender: UIButton) {
        dateLabel.text = "\(count)"
        count += 1
    
    }
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
       
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
