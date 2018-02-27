//
//  bottomView.swift
//  planTomorrow
//
//  Created by me293 on 2018/2/22.
//  Copyright © 2018年 hpy. All rights reserved.
//

import UIKit
protocol BottomViewDelegate: class{
    func changeMode()
}
class BottomView: UIView {
    weak var delegate: BottomViewDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func changeMode(){
//        draw(_ rect: CGRect)
    }

    override func draw(_ rect: CGRect) {
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Color Declarations
        let color3 = UIColor(red: 0.931, green: 0.814, blue: 0.743, alpha: 1.000)
        
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.gray.withAlphaComponent(0.29)
        shadow.shadowOffset = CGSize(width: 1, height: 1)
        shadow.shadowBlurRadius = 8
        
        //// Group 3
        context.saveGState()
        context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        //// Bezier 6 Drawing
        context.saveGState()
        context.translateBy(x: 363.7, y: 4.5)
        context.rotate(by: -180 * CGFloat.pi/180)
        context.scaleBy(x: 1, y: -1)
        
        let bezier6Path = UIBezierPath()
        bezier6Path.move(to: CGPoint(x: 165.72, y: 0))
        bezier6Path.addCurve(to: CGPoint(x: 165.96, y: 1.33), controlPoint1: CGPoint(x: 165.76, y: 0.39), controlPoint2: CGPoint(x: 165.84, y: 0.84))
        bezier6Path.addCurve(to: CGPoint(x: 176, y: 12.5), controlPoint1: CGPoint(x: 167.51, y: 7.43), controlPoint2: CGPoint(x: 169.4, y: 12.5))
        bezier6Path.addCurve(to: CGPoint(x: 176, y: 154.47), controlPoint1: CGPoint(x: 177, y: 48.5), controlPoint2: CGPoint(x: 176, y: 154.47))
        bezier6Path.addCurve(to: CGPoint(x: 40.54, y: 147.97), controlPoint1: CGPoint(x: 176, y: 154.47), controlPoint2: CGPoint(x: 86.32, y: 153.97))
        bezier6Path.addCurve(to: CGPoint(x: 10.2, y: 125.97), controlPoint1: CGPoint(x: 23.59, y: 145.75), controlPoint2: CGPoint(x: 15.85, y: 136.97))
        bezier6Path.addCurve(to: CGPoint(x: 0.94, y: 55.47), controlPoint1: CGPoint(x: 4.54, y: 114.97), controlPoint2: CGPoint(x: 1.97, y: 79.47))
        bezier6Path.addCurve(to: CGPoint(x: 0, y: 1.5), controlPoint1: CGPoint(x: -0.09, y: 31.47), controlPoint2: CGPoint(x: 0, y: 1.5))
        bezier6Path.addCurve(to: CGPoint(x: 2.55, y: 0.47), controlPoint1: CGPoint(x: 0, y: 1.5), controlPoint2: CGPoint(x: 1.33, y: 0.47))
        bezier6Path.addCurve(to: CGPoint(x: 165.72, y: 0), controlPoint1: CGPoint(x: 18.52, y: 0.42), controlPoint2: CGPoint(x: 132.09, y: 0.1))
        bezier6Path.close()
        color3.setFill()
        bezier6Path.fill()
        
        context.restoreGState()
        
        //// Bezier 5 Drawing
        let bezier5Path = UIBezierPath()
        bezier5Path.move(to: CGPoint(x: 178.42, y: 4.5))
        bezier5Path.addCurve(to: CGPoint(x: 178.66, y: 5.83), controlPoint1: CGPoint(x: 178.45, y: 4.89), controlPoint2: CGPoint(x: 178.53, y: 5.34))
        bezier5Path.addCurve(to: CGPoint(x: 188, y: 17), controlPoint1: CGPoint(x: 180.21, y: 11.93), controlPoint2: CGPoint(x: 182, y: 17))
        bezier5Path.addCurve(to: CGPoint(x: 188, y: 158.97), controlPoint1: CGPoint(x: 189, y: 53), controlPoint2: CGPoint(x: 188, y: 158.97))
        bezier5Path.addCurve(to: CGPoint(x: 53.24, y: 152.47), controlPoint1: CGPoint(x: 188, y: 158.97), controlPoint2: CGPoint(x: 99.02, y: 158.47))
        bezier5Path.addCurve(to: CGPoint(x: 22.89, y: 130.47), controlPoint1: CGPoint(x: 36.29, y: 150.25), controlPoint2: CGPoint(x: 28.55, y: 141.47))
        bezier5Path.addCurve(to: CGPoint(x: 13.63, y: 59.97), controlPoint1: CGPoint(x: 17.24, y: 119.47), controlPoint2: CGPoint(x: 14.66, y: 83.97))
        bezier5Path.addCurve(to: CGPoint(x: 12.7, y: 6), controlPoint1: CGPoint(x: 12.61, y: 35.97), controlPoint2: CGPoint(x: 12.7, y: 6))
        bezier5Path.addCurve(to: CGPoint(x: 15.25, y: 4.97), controlPoint1: CGPoint(x: 12.7, y: 6), controlPoint2: CGPoint(x: 14.03, y: 4.97))
        bezier5Path.addCurve(to: CGPoint(x: 178.42, y: 4.5), controlPoint1: CGPoint(x: 31.22, y: 4.92), controlPoint2: CGPoint(x: 144.79, y: 4.6))
        bezier5Path.close()
        color3.setFill()
        bezier5Path.fill()
        
        context.endTransparencyLayer()
        context.restoreGState()

    }
    
}
