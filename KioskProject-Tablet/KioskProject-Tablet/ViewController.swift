//
//  ViewController.swift
//  KioskProject-Tablet
//
//  Created by alden lamp on 6/19/18.
//  Copyright © 2018 alden lamp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let button = UIButton()
    
    @IBOutlet var data: UILabel!
    @IBOutlet var responceLabel: UILabel!
    
    @IBOutlet var uid: UITextField!
    @IBOutlet var name: UITextField!
    
    @IBOutlet var grade: UITextField!
    
    @IBOutlet var priv: UISwitch!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        button.setTitle("Testing HTTP SHIT", for: .normal)
//
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        button.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        self.view.addSubview(button)
//        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
//        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
//        button.target(forAction: #selector(touchUp), withSender: nil)
//
    }
    
    @IBAction func TESTINGShit(_ sender: Any) {
        if uid.text == "" || name.text == "" || grade.text == "" || name.text?.split(separator: " ").count ?? 0 < 2 {
            data.text = "Please fill in all inputs"
            return
        }
        
        
        let requestURL = "http://72.79.54.70:55622/addUser"
        var request = URLRequest(url: URL(string: requestURL)!)
        request.httpMethod = "POST"
        
        request.httpBody = "UID=\(uid.text!)&&FName=\(name.text!.split(separator: " ").first!)&&LName=\(name.text!.split(separator: " ").last!)&&Grade=\(Int(grade.text!)!)&&Priv=\(priv.isOn ? "yes" : "no")".data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            
            DispatchQueue.main.async {
                self.data.text = "Data"
                self.responceLabel.text = "Response"
            }
            
            if let error = error{
                print(error)
                DispatchQueue.main.async { self.data.text = "\(error)" }
                return
            }
            
            let responseMessage: String = String(data: data!, encoding: String.Encoding.utf8)!
            print("\nData: \(responseMessage) \n\n")
            
            DispatchQueue.main.async { self.data.text = String(responseMessage) }
            
            if responseMessage != ""{
                
                if let httpResponse = response as? HTTPURLResponse {
                    DispatchQueue.main.async { self.responceLabel.text = "\(httpResponse)" }
                    print("response: \(httpResponse)\n\n")
                }
            }
        }).resume()
        
        

    }
    
    
    
    @objc func touchUp(){
        
    }

}

