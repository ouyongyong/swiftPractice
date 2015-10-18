//
//  ImageSpider.swift
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

class ImageSpider: UIViewController {
    
    private var url:URLStringConvertible!
    private var indicator:MBProgressHUD!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(aUrl : URLStringConvertible) {
        url = aUrl
        indicator = MBProgressHUD.init()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        
        indicator.show(true)
        self.view.backgroundColor = UIColor.whiteColor()
        Alamofire.request(.GET, url).responseData { response in
            var resp = response
            var doc = TFHpple.init(HTMLData: response.data)
            //            var ele = doc.searchWithXPathQuery("//div[@id='link-report']/div/div/img")
            var ele = doc.searchWithXPathQuery("//img")
            
            self.indicator.hide(true)
        }
    }
    
    
}
