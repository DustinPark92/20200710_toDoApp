
//
//  SettingViewController.swift
//  20200710_1st
//
//  Created by Dustin on 2020/07/24.
//  Copyright © 2020 Dustin. All rights reserved.
//

import UIKit
import Zip
import MobileCoreServices

class SettingViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
    }
    
    @IBAction func handleCompressed(_ sender: UIButton) {
        
        //백업 할 파일 경로를 담을 배열
        var urlPath = [URL]()
        urlPath.append(URL(string: (self.getDirectoryPath() as NSString).appendingPathComponent("default.realm"))! )
        
        do {
            let _ = try Zip.quickZipFiles(urlPath, fileName: "Archive")
            print("Archive")
        } catch  {
            print("Create Zip File Error")
        }

    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    @IBAction func handleBackUpButton(_ sender: UIButton) {
        
        
        let filename = "\(getDirectoryPath())/Archive.zip"
         let fileURL = URL(fileURLWithPath: filename)
         
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: [])

         self.present(vc, animated: true)
        
        
    }
    
    @IBAction func handleRecoveryButton(_ sender: UIButton) {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        present(documentPicker, animated: true, completion: nil)
        
    }
    
    @IBAction func handleDismissView(_ sender: UIButton) {
        
         NotificationCenter.default.post(name: NSNotification.Name("backUpData"), object: nil)
        
        navigationController?.popViewController(animated: true)
    }
    
}


extension SettingViewController : UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        //url 배열중에서 하나만 가져와라
        guard let selectedFileURL = urls.first else {
             return
         }
        //false면 하나도 리턴하지 않는다. guard
         
         let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
         let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
         
        //선택 했을때 내용이 있는지?
         if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
             
             do {
                 let documentsDirectory = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
                 let imageFile = "Archive.zip"
                 let imageURL = documentsDirectory.appendingPathComponent(imageFile)
                 try Zip.unzipFile(imageURL, destination: documentsDirectory, overwrite: true, password: nil, progress: { (progress) -> () in
                    
                     print("progress")
                    
                    
                 })
             }
             catch {
                 print("Something went wrong")
                  
             }
        
             
         }
         else {
             //파일앱에서 선택한 zip파일이 나의 도큐먼트에 존재하지 않는다면, 나의 도큐먼트 폴더 내에 zip 파일을 저장! -> 엄밀히 말하면 복제
             do {
                 try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                 
                 let documentsDirectory = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
                 let imageFile = "Archive.zip"
                 let imageURL = documentsDirectory.appendingPathComponent(imageFile)
                 try Zip.unzipFile(imageURL, destination: documentsDirectory, overwrite: true, password: nil, progress: { (progress) -> () in
                    
                     print("progress")
                  
                 })
                 
                 print("Copied file!")
             }
             catch {
                 print("Error: \(error)")
             }
         }
         
        
        
    }
}
