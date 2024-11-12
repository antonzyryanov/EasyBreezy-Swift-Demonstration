//
//  PassTouchesScrollView.swift
//  Easy Breezy
//
//  Created by Anton Zyryanov on 11.12.2022.
//

import UIKit

protocol PassTouchesScrollViewDelegate {

func scrollTouchBegan(touches: Set<NSObject>, withEvent event: UIEvent?)
func scrollTouchMoved(touches: Set<NSObject>, withEvent event: UIEvent?)
func scrollTouchEnded(touches: Set<NSObject>, withEvent event: UIEvent?)
    
}

class PassTouchesScrollView: UIScrollView {

var delegatePass : PassTouchesScrollViewDelegate?

override init(frame: CGRect) {
    super.init(frame: frame)
}

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
}

    override func touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool {
        self.delegatePass?.scrollTouchBegan(touches: touches, withEvent: event)
        self.isScrollEnabled = false
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       // self.delegatePass?.scrollTouchBegan(touches: touches, withEvent: event)
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.delegatePass?.scrollTouchMoved(touches: touches, withEvent: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.delegatePass?.scrollTouchEnded(touches: touches, withEvent: event)
        self.isScrollEnabled = true
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.delegatePass?.scrollTouchEnded(touches: touches, withEvent: event)
        self.isScrollEnabled = true
    }

}
