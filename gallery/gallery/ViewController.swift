//
//  ViewController.swift
//  gallery
//
//  Created by ouyongyong on 15/10/18.
//  Copyright © 2015年 kira. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import hpple
import AlamofireImage

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlStr = "http://www.douban.com/group/godgoddess/discussion?start=1"
        
        
        self.navigationController?.pushViewController(ImageSpider.init(aUrl: urlStr), animated: true)
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

