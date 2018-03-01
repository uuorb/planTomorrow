//
//  mainView.swift
//  planTomorrow
//
//  Created by me293 on 2018/2/22.
//  Copyright © 2018年 hpy. All rights reserved.
//

import UIKit

class MainView: UIView {
    let SCREEN_WIDTH = UIScreen.main.bounds.width
    let SCREEN_HEIGHT = UIScreen.main.bounds.height
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
   override func draw(_ rect: CGRect){
    let widthRadio = SCREEN_WIDTH / 375
    let heightRadio = SCREEN_HEIGHT / 667 * 1.2
    //// General Declarations
    let context = UIGraphicsGetCurrentContext()!
    
    //// Color Declarations
    let color =   UIColor(red: 0.879, green: 0.212, blue: 0.213, alpha: 1.000)
    
    //// Shadow Declarations
    let shadow = NSShadow()
    shadow.shadowColor = UIColor.gray.withAlphaComponent(0.29)
    shadow.shadowOffset = CGSize(width: 1, height: 1)
    shadow.shadowBlurRadius = 8
    
    //// Group
    context.saveGState()
    context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
    context.beginTransparencyLayer(auxiliaryInfo: nil)
    
    
    //// Bezier 4 Drawing
    context.saveGState()
    context.translateBy(x: widthRadio  * 11.98  , y: heightRadio * 69.5)
    context.scaleBy(x: 0.5, y: 0.5)
    
    let bezier4Path = UIBezierPath()
    bezier4Path.move(to: CGPoint(x: widthRadio  * 19.04, y:  heightRadio * 57.19))
    
    bezier4Path.addCurve(to: CGPoint(x: widthRadio  * 79.78, y:  heightRadio * 13.04), controlPoint1: CGPoint(x: widthRadio  * 30.37, y:  heightRadio * 35.11), controlPoint2: CGPoint(x: widthRadio  * 45.85, y:  heightRadio * 17.5))
    bezier4Path.addCurve(to: CGPoint(x: widthRadio  * 349.48, y:  heightRadio * -0), controlPoint1: CGPoint(x: widthRadio  * 171.4, y:  heightRadio * 1), controlPoint2: CGPoint(x: widthRadio  * 349.48, y:  heightRadio * -0))
    bezier4Path.addLine(to: CGPoint(x: widthRadio  * 349.48, y:  heightRadio * 309))
    bezier4Path.addLine(to: CGPoint(x: widthRadio  * 0, y:  heightRadio * 309))
    bezier4Path.addCurve(to: CGPoint(x: widthRadio  * 0.51, y:  heightRadio * 198.64), controlPoint1: CGPoint(x: widthRadio  * 0, y:  heightRadio * 309), controlPoint2: CGPoint(x: widthRadio  * -1.54, y:  heightRadio * 246.8))
    bezier4Path.addCurve(to: CGPoint(x: widthRadio  * 19.04, y:  heightRadio * 57.19), controlPoint1: CGPoint(x: widthRadio  * 2.57, y:  heightRadio * 150.49), controlPoint2: CGPoint(x: widthRadio  * 7.72, y:  heightRadio * 79.26))
    bezier4Path.close()
    color.setFill()
    bezier4Path.fill()
    color.setStroke()
    bezier4Path.lineWidth = 1
    bezier4Path.stroke()
    
    context.restoreGState()
    
    
    //// Bezier 3 Drawing
    context.saveGState()
    context.translateBy(x: widthRadio  *  360.98, y:  heightRadio * 69.5)
    context.scaleBy(x: -0.5, y: 0.5)
    
    let bezier3Path = UIBezierPath()
    bezier3Path.move(to: CGPoint(x: widthRadio  * 19.04, y:  heightRadio * 57.19))
    bezier3Path.addCurve(to: CGPoint(x: widthRadio  * 79.78, y:  heightRadio * 13.04), controlPoint1: CGPoint(x: widthRadio  * 30.37, y:  heightRadio * 35.11), controlPoint2: CGPoint(x: widthRadio  * 45.85, y:  heightRadio * 17.5))
    
    bezier3Path.addCurve(to: CGPoint(x: widthRadio  * 349.48, y:  heightRadio * -0), controlPoint1: CGPoint(x: widthRadio  * 171.4, y:  heightRadio * 1), controlPoint2: CGPoint(x: widthRadio  * 349.48, y:  heightRadio * -0))
    bezier3Path.addLine(to: CGPoint(x: widthRadio  * 349.48, y:  heightRadio * 309))
    bezier3Path.addLine(to: CGPoint(x: widthRadio  * 0, y:  heightRadio * 309))
    bezier3Path.addCurve(to: CGPoint(x: widthRadio  * 0.51, y:  heightRadio * 198.64), controlPoint1: CGPoint(x: widthRadio  * 0, y:  heightRadio * 309), controlPoint2: CGPoint(x: widthRadio  * -1.54, y:  heightRadio * 246.8))
    bezier3Path.addCurve(to: CGPoint(x: widthRadio  * 19.04, y:  heightRadio * 57.19), controlPoint1: CGPoint(x: widthRadio  * 2.57, y:  heightRadio * 150.49), controlPoint2: CGPoint(x: widthRadio  * 7.72, y:  heightRadio * 79.26))
    bezier3Path.close()
    color.setFill()

    bezier3Path.fill()
    color.setStroke()
    bezier3Path.lineWidth = 1
    bezier3Path.stroke()
    
    context.restoreGState()
    
    
    //// Bezier Drawing
    context.saveGState()
    context.translateBy(x: widthRadio  * 11.98, y:  heightRadio * 378)
    context.scaleBy(x: 0.5, y: -0.5)
    
    let bezierPath = UIBezierPath()
    bezierPath.move(to: CGPoint(x: widthRadio  * 19.04, y:  heightRadio * 57.19))
    bezierPath.addCurve(to: CGPoint(x: widthRadio  * 79.78, y:  heightRadio * 13.04), controlPoint1: CGPoint(x: widthRadio  * 30.37, y:  heightRadio * 35.11), controlPoint2: CGPoint(x: widthRadio * 45.85, y:  heightRadio * 17.5))
    bezierPath.addCurve(to: CGPoint(x: widthRadio * 349.48, y:  heightRadio * -0), controlPoint1: CGPoint(x: widthRadio * 171.4, y:  heightRadio * 1), controlPoint2: CGPoint(x: widthRadio * 349.48, y:  heightRadio * -0))
    bezierPath.addLine(to: CGPoint(x: widthRadio * 349.48, y:  heightRadio * 283.88))
    bezierPath.addLine(to: CGPoint(x: widthRadio * 349.48, y:  heightRadio * 309))
    bezierPath.addLine(to: CGPoint(x: widthRadio * 0, y:  heightRadio * 309))
    bezierPath.addCurve(to: CGPoint(x: widthRadio * 0.51, y:  heightRadio * 198.64), controlPoint1: CGPoint(x: widthRadio * 0, y:  heightRadio * 309), controlPoint2: CGPoint(x: widthRadio * -1.54, y:  heightRadio * 246.8))
    bezierPath.addCurve(to: CGPoint(x: widthRadio * 19.04, y:  heightRadio * 57.19), controlPoint1: CGPoint(x: widthRadio * 2.57, y:  heightRadio * 150.49), controlPoint2: CGPoint(x: widthRadio * 7.72, y:  heightRadio * 79.26))
    bezierPath.close()
    color.setFill()
    bezierPath.fill()
    color.setStroke()
    bezierPath.lineWidth = 1
    bezierPath.stroke()
    
    context.restoreGState()
    
    
    //// Bezier 2 Drawing
    context.saveGState()
    context.translateBy(x: widthRadio * 360.98, y:  heightRadio * 378)
    context.rotate(by: -180 * CGFloat.pi/180)
    context.scaleBy(x: 0.5, y: 0.5)
    
    let bezier2Path = UIBezierPath()
    bezier2Path.move(to: CGPoint(x: widthRadio * 19.04, y:  heightRadio * 57.19 ))
    bezier2Path.addCurve(to: CGPoint(x: widthRadio * 79.78, y:  heightRadio * 13.04), controlPoint1: CGPoint(x: widthRadio * 30.37, y:  heightRadio * 35.11), controlPoint2: CGPoint(x: widthRadio * 45.85, y:  heightRadio * 17.5))
    bezier2Path.addCurve(to: CGPoint(x: widthRadio * 349.48, y:  heightRadio * -0), controlPoint1: CGPoint(x: widthRadio * 171.4, y:  heightRadio * 1), controlPoint2: CGPoint(x: widthRadio * 349.48, y:  heightRadio * -0))
    bezier2Path.addLine(to: CGPoint(x: widthRadio * 349.48, y:  heightRadio * 309))
    bezier2Path.addLine(to: CGPoint(x: widthRadio * 0, y:  heightRadio * 309))
    bezier2Path.addCurve(to: CGPoint(x: widthRadio * 0.51, y:  heightRadio * 198.64), controlPoint1: CGPoint(x: widthRadio * 0, y:  heightRadio * 309), controlPoint2: CGPoint(x: widthRadio * -1.54, y:  heightRadio * 246.8))
    bezier2Path.addCurve(to: CGPoint(x: widthRadio * 19.04, y:  heightRadio * 57.19), controlPoint1: CGPoint(x: widthRadio * 2.57, y:  heightRadio * 150.49), controlPoint2: CGPoint(x: widthRadio * 7.72, y:  heightRadio * 79.26))
    bezier2Path.close()
    color.setFill()
    bezier2Path.fill()
    color.setStroke()
    bezier2Path.lineWidth = 1
    bezier2Path.stroke()
    
    context.restoreGState()
    
    
    //// Bezier 7 Drawing
    let bezier7Path = UIBezierPath()
    color.setFill()
    bezier7Path.fill()
    color.setStroke()
    bezier7Path.lineWidth = 1
    bezier7Path.stroke()
    
    context.endTransparencyLayer()
    context.restoreGState()


    }
}
