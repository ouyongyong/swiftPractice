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

class ViewController: UIViewController, ImageSpiderDelegate {
    
    private var imgSpider : ImageSpider?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlStr = "http://www.douban.com/group/godgoddess/discussion?start=1"
        
        imgSpider = ImageSpider(aUrl: NSURL(string: urlStr)!)
        
        imgSpider!.view.frame = CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height/4, self.view.frame.size.width/2, self.view.frame.size.height/2)
        imgSpider!.view.center = self.view.center
        imgSpider!.delegate = self
        
        self.view.addSubview(imgSpider!.view)
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func imageCountDidChange(count : Int) {
        if count < 3 {
            let urlStr = "http://www.douban.com/group/godgoddess/discussion?start=2"
            imgSpider?.appendImgs(NSURL(string: urlStr)!)
        }
    }
    
}

