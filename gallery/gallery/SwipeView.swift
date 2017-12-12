//
//  SwipeView.swift
//  gallery
//
//  Created by ouyongyong on 15/11/14.
//  Copyright © 2015年 kira. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}




protocol SwipeViewDelegate {
    func swipeViewDidSwipeLeft(_ view : UIView)
    func swipeViewDidSwipeRight(_ view : UIView)
}

class SwipeView: UIView {
    //constants
    let actionMargin : CGFloat! = 120
    let scaleStrength : Float! = 4
    let scaleMax : Float! = 0.93
    let rotationMax : CGFloat! = 1.0
    let rotationStrength : CGFloat! = 320.0
    let rotationAngle = M_PI/8.0

    //properties
    var swipeDelegate : SwipeViewDelegate?
    var panGestureRecognizer : UIPanGestureRecognizer!
    var orgPoint : CGPoint!
    var contentView : UIView?
    fileprivate var xOff : CGFloat!
    fileprivate var yOff : CGFloat!
    
    //init
    init(frame: CGRect, otherView: UIView) {
        self.contentView = otherView
        super.init(frame: frame)
        self.setupView()
        self.initGesture()
        self.addSubview(otherView)
        
        self.contentView!.autoresizesSubviews = true;
        self.contentView!.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleHeight, .flexibleWidth]
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //methods
    func swipeLeft() {
        self.swipeTo(CGPoint(x: -600, y: self.center.y), rotate: -1)
        self.swipeDelegate?.swipeViewDidSwipeLeft(self)
    }

    func swipeRight() {
        self.swipeTo(CGPoint(x: 600, y: self.center.y), rotate: 1)
        self.swipeDelegate?.swipeViewDidSwipeRight(self)
    }
    
    func setupView() {
        self.layer.cornerRadius = 4
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.backgroundColor = UIColor.white
      
    }
    
    func initGesture() {
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(SwipeView.panStart(_:)))
        self.addGestureRecognizer(self.panGestureRecognizer)
        
    }
    
    func panStart(_ sender : UIPanGestureRecognizer) {
        xOff = sender.translation(in: self).x
        yOff = sender.translation(in: self).y
        
        switch (sender.state) {
        case UIGestureRecognizerState.began:
            self.orgPoint = self.center
        case UIGestureRecognizerState.changed:
            let roteStrenght = Double(min(xOff!/rotationStrength, rotationMax))
            let angle = rotationAngle * roteStrenght
            let scale = max(1-fabsf(Float(roteStrenght))/scaleStrength, scaleMax)
            
            self.center = CGPoint(x: self.orgPoint.x + xOff, y: self.orgPoint.y + yOff)
            
            let transform = CGAffineTransform(rotationAngle: CGFloat(angle))
            let scaleTrans = transform.scaledBy(x: CGFloat(scale), y: CGFloat(scale))
            
            self.transform = scaleTrans
        case UIGestureRecognizerState.ended:
            self.swipeEnd()
        default: break
            //do nothing
        }
        
    }
    
    func swipeEnd() {
        switch (xOff) {
        case xOff where xOff > actionMargin :
            self.goesRight()
        case -actionMargin...actionMargin :
            //middle
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.center = self.orgPoint
                self.transform = CGAffineTransform(rotationAngle: 0)
                }, completion: { (complete) -> Void in
//                    self.removeFromSuperview()
            })
        case xOff where xOff < -actionMargin :
            self.goesLeft()
        default : break
        }
    }
    
    func goesRight() {
        self.swipeTo(CGPoint(x: 500, y: 2*yOff + self.orgPoint.y), rotate : 0)
        self.swipeDelegate?.swipeViewDidSwipeRight(self)
    }
    
    func goesLeft() {
        self.swipeTo(CGPoint(x: -500, y: 2*yOff + self.orgPoint.y), rotate: 0)
        self.swipeDelegate?.swipeViewDidSwipeLeft(self)
    }
    
    func swipeTo(_ finishPoint : CGPoint, rotate : CGFloat) {
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.center = finishPoint
            self.transform = CGAffineTransform(rotationAngle: rotate)
            }, completion: { (complete) -> Void in
                self.removeFromSuperview()
        }) 
    }
    

}
