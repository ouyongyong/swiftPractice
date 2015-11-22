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

class ImageSpider: UIViewController, SwipeViewDelegate {
    
    private var url:URLStringConvertible!
    private var indicator:MBProgressHUD!
    private var cards : [UIView]
    
    required init?(coder aDecoder: NSCoder) {
        self.cards = [UIView]()
        super.init(coder: aDecoder)
    }
    
    init(aUrl : URLStringConvertible) {
        url = aUrl
        indicator = MBProgressHUD.init()
        self.cards = [UIView]()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        
        indicator.show(true)
        self.view.backgroundColor = UIColor.whiteColor()
        Alamofire.request(.GET, url).responseData { response in

            let doc = TFHpple.init(HTMLData: response.data)
            let ele:NSArray! = doc.searchWithXPathQuery("//img") as NSArray
            
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            
            for i in 0...ele.count-1 {
                let node = ele[i]
                let aNode:TFHppleElement = node as! TFHppleElement
                
                if let aUrl:String = aNode.attributes["src"] as! String? {
                    print(aUrl)
                    let imgView:UIImageView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width-40.0 - CGFloat(i*10), self.view.frame.size.height-40.0 - CGFloat(i*10)))
                    imgView.contentMode = UIViewContentMode.ScaleAspectFit
                    
                    
                    let swipeView = SwipeView(frame: CGRectMake(CGFloat(i*5), CGFloat(i*10), self.view.frame.size.width-40.0 - CGFloat(i*10), self.view.frame.size.height-40.0 - CGFloat(i*5)), otherView: imgView)
                    swipeView.swipeDelegate = self;
                    swipeView.tag = 999+i
                    if self.cards.count == 0 {
                        print("add \(aUrl) in \(i)")
                        self.view.addSubview(swipeView)
                    } else {
                        print("insert \(aUrl) in \(i), with frame \(swipeView.frame)")
                        self.view.insertSubview(swipeView, belowSubview: self.cards.last!)
                        self.view.sendSubviewToBack(swipeView)
                    }
                    
                    self.cards.append(swipeView)
                    
                    imgView.af_setImageWithURL(NSURL(string: aUrl)!)

                }
            }
            self.indicator.hide(true)
        }
    }
    
    func click(sender : UIButton) {
        sender.superview?.removeFromSuperview()
    }
    
    func swipeViewDidSwipeLeft(view : UIView) {
        
        for subView in self.view.subviews {
            if subView.isKindOfClass(SwipeView) {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    var frame = subView.frame
                    frame.origin.y -= 5
                    frame.size.width += 10;
                    subView.frame = frame
                    
                    }, completion: { (complete) -> Void in
                        //
                })
            }
        }

    }
    
    func swipeViewDidSwipeRight(view : UIView) {
        
        for subView in self.view.subviews {
            if subView.isKindOfClass(SwipeView) {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    var frame = subView.frame
                    frame.origin.y -= 5
                    frame.size.width += 10;
                    subView.frame = frame
                    
                    }, completion: { (complete) -> Void in
                        //
                })
            }
        }
    }
    
    
}
