//
//  ViewController.swift
//  baby Checker
//
//  Created by Yixiao Sun on 4/13/16.
//  Copyright © 2016 Yixiao Sun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myView: UIImageView!
    var myTrans: transmitter = transmitter(host: "192.168.0.120", port: 13500)
    
    @IBAction func learning(sender: UIButton) {
    }
    
    @IBAction func getpic(sender: UIButton) {
        myTrans.sendCmd("getpicture")
        if let raw_data = myTrans.readAll() {
            let nsdata = NSData(bytes: raw_data, length: raw_data.count)
            let myImg = UIImage(data: nsdata)
            myView.image = myImg
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let raw_data = myTrans.readAll()
//        let nsdata = NSData(bytes: raw_data, length: raw_data.count)
//        let myImg = UIImage(data: nsdata)
//        myView.image = myImg
        myTrans.sendCmd("hihihi")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

