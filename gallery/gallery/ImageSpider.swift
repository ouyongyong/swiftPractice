//
//  ImageSpider.swift
//  gallery
//
//  Created by ouyongyong on 15/10/18.
//  Copyright © 2015年 kira. All rights reserved.
//

import UIKit
import MBProgressHUD
import hpple
//import AlamofireImage

protocol ImageSpiderDelegate {
    func imageCountDidChange(_ count : Int)
}

class ImageSpider: UIViewController, SwipeViewDelegate {
    
    fileprivate var url:URL!
    fileprivate var indicator:MBProgressHUD!
    fileprivate var cards : [UIView]
    
    internal var delegate : ImageSpiderDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        self.cards = [UIView]()
        super.init(coder: aDecoder)
    }
    
    init(aUrl : URL) {
        url = aUrl
        indicator = MBProgressHUD.init()
        self.cards = [UIView]()
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        
        indicator.show(true)
        self.view.backgroundColor = UIColor.white
        appendImgs(url)
        
    }
    
    func appendImgs(_ fromUrl : URL){
//        Alamofire.request(.GET, fromUrl.absoluteString).responseData { response in
//            
//            let doc = TFHpple.init(htmlData: response.data)
//            let ele:NSArray! = doc.search(withXPathQuery: "//img") as NSArray
//            
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
//            
//            
//            for i in 0...ele.count-1 {
//                let node = ele[i]
//                let aNode:TFHppleElement = node as! TFHppleElement
//                
//                if let aUrl:String = aNode.attributes["src"] as! String? {
//                    let j = self.cards.count
//                    print(aUrl)
//                    let imgView:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width-40.0 - CGFloat(j*10), height: self.view.frame.size.height-40.0 - CGFloat(j*10)))
//                    imgView.contentMode = UIViewContentMode.scaleAspectFit
//                    
//                    
//                    let swipeView = SwipeView(frame: CGRect(x: CGFloat(j*5), y: CGFloat(j*10), width: self.view.frame.size.width-40.0 - CGFloat(j*10), height: self.view.frame.size.height-40.0 - CGFloat(j*5)), otherView: imgView)
//                    swipeView.swipeDelegate = self;
//                    
//                    if self.cards.count == 0 {
//                        print("add \(aUrl) in \(i)")
//                        self.view.addSubview(swipeView)
//                    } else {
//                        print("insert \(aUrl) in \(i), with frame \(swipeView.frame)")
//                        self.view.insertSubview(swipeView, belowSubview: self.cards.last!)
//                        self.view.sendSubview(toBack: swipeView)
//                    }
//                    
//                    self.cards.append(swipeView)
//                    
//                    imgView.af_setImageWithURL(URL(string: aUrl)!)
//                    
//                }
//            }
//            self.indicator.hide(true)
//        }
    }
    
    func click(_ sender : UIButton) {
        sender.superview?.removeFromSuperview()
    }
    
    func swipeViewDidSwipeLeft(_ view : UIView) {
        
        self.cards.removeFirst()
        self.delegate!.imageCountDidChange(self.cards.count)
        
        for subView in self.cards {
            if subView.isKind(of: SwipeView.self) {
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    var frame = subView.frame
                    frame.origin.y -= 10
                    frame.size.width += 10;
                    frame.size.height += 5;
                    frame.origin.x -= 5;
                    subView.frame = frame
                    
                    }, completion: { (complete) -> Void in
                        
                })
            }
        }

    }
    
    func swipeViewDidSwipeRight(_ view : UIView) {
        
        self.cards.removeFirst()
        self.delegate!.imageCountDidChange(self.cards.count)
        
        for subView in self.cards {
            if subView.isKind(of: SwipeView.self) {
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    var frame = subView.frame
                    frame.origin.y -= 10
                    frame.size.width += 10;
                    frame.size.height += 5;
                    frame.origin.x -= 5;
                    subView.frame = frame
                    
                    }, completion: { (complete) -> Void in
                        
                })
            }
        }
    }
    
    
}
