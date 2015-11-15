//
//  SwipeView.swift
//  gallery
//
//  Created by ouyongyong on 15/11/14.
//  Copyright © 2015年 kira. All rights reserved.
//

import UIKit



protocol SwipeViewDelegate {
    func swipeViewDidSwipeLeft(view : UIView)
    func swipeViewDidSwipeRight(view : UIView)
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
    private var xOff : CGFloat!
    private var yOff : CGFloat!
    
    //init
    init(frame: CGRect, otherView: UIView) {
//        self.contentView = otherView
        super.init(frame: frame)
        self.setupView()
        self.initGesture()
        self.addSubview(otherView)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //methods
    func swipeLeft() {
        self.swipeTo(CGPointMake(-600, self.center.y), rotate: -1)
        self.swipeDelegate?.swipeViewDidSwipeLeft(self)
    }

    func swipeRight() {
        self.swipeTo(CGPointMake(600, self.center.y), rotate: 1)
        self.swipeDelegate?.swipeViewDidSwipeRight(self)
    }
    
    func setupView() {
        self.layer.cornerRadius = 4
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSizeMake(1, 1)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    func initGesture() {
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "panStart:")
        self.addGestureRecognizer(self.panGestureRecognizer)
        
    }
    
    func panStart(sender : UIPanGestureRecognizer) {
        xOff = sender.translationInView(self).x
        yOff = sender.translationInView(self).y
        
        switch (sender.state) {
        case UIGestureRecognizerState.Began:
            self.orgPoint = self.center
        case UIGestureRecognizerState.Changed:
            let roteStrenght = Double(min(xOff!/rotationStrength, rotationMax))
            let angle = rotationAngle * roteStrenght
            let scale = max(1-fabsf(Float(roteStrenght))/scaleStrength, scaleMax)
            
            self.center = CGPointMake(self.orgPoint.x + xOff, self.orgPoint.y + yOff)
            
            let transform = CGAffineTransformMakeRotation(CGFloat(angle))
            let scaleTrans = CGAffineTransformScale(transform, CGFloat(scale), CGFloat(scale))
            
            self.transform = scaleTrans
        case UIGestureRecognizerState.Ended:
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
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.center = self.orgPoint
                self.transform = CGAffineTransformMakeRotation(0)
                }, completion: { (complete) -> Void in
//                    self.removeFromSuperview()
            })
        case xOff where xOff < -actionMargin :
            self.goesLeft()
        default : break
        }
    }
    
    func goesRight() {
        self.swipeTo(CGPointMake(500, 2*yOff + self.orgPoint.y), rotate : 0)
        self.swipeDelegate?.swipeViewDidSwipeRight(self)
    }
    
    func goesLeft() {
        self.swipeTo(CGPointMake(-500, 2*yOff + self.orgPoint.y), rotate: 0)
        self.swipeDelegate?.swipeViewDidSwipeLeft(self)
    }
    
    func swipeTo(finishPoint : CGPoint, rotate : CGFloat) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.center = finishPoint
            self.transform = CGAffineTransformMakeRotation(rotate)
            }) { (complete) -> Void in
                self.removeFromSuperview()
        }
    }
    

}
