//
//  XLBLyricView.swift
//  Lyrics
//
//  Created by iMac on 2017/7/6.
//  Copyright © 2017年 fengjiayuan. All rights reserved.
//

import UIKit
import QuartzCore

public class XLBLyricView: UIView {
    
    
    public var model:XLBLine! {
        
        didSet{
            
            /*
             
                整体思路
                    下边是一层白色的label，上边覆盖一层绿色的label。控制绿的层的label进行部分渲染，就能达到歌词显示效果
             
             */
            
            whiteLabel.text = model.text
            whiteLabel.sizeToFit()
            whiteLabel.frame.size.height = self.frame.size.height
//            self.frame.size.width = whiteLabel.frame.size.width
            
            greenLabel.text = model.text

            
//                        greenLabel.backgroundColor = UIColor.orange
//                        greenLabel.alpha = 0.2
            self.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(startAni)))
            //            startAni()
        }
    }
    
    lazy var whiteLabel: UILabel = {
        let whiteLabel = UILabel.init(frame: self.bounds)
        whiteLabel.textColor = UIColor.white
        self.addSubview(whiteLabel)
        return whiteLabel
    }()
    
    
    
    lazy var greenLabel: UILabel = {
        let greenLabel = UILabel.init(frame: self.whiteLabel.bounds)
        
        
        greenLabel.textColor = UIColor.green
        
        greenLabel.backgroundColor = UIColor.clear
        
        greenLabel.layer.mask = self.maskLayer
        
        self.addSubview(greenLabel)
        
        return greenLabel
    }()
    
    
    lazy var maskLayer: CALayer = {
        
        let maskLayer = CALayer.init()
        maskLayer.backgroundColor = UIColor.white.cgColor    // Any color, only alpha channel matters
        maskLayer.anchorPoint  = CGPoint.zero
        maskLayer.frame = CGRect.init(origin: CGPoint.init(x: -self.whiteLabel.frame.size.width, y: 0), size: self.whiteLabel.frame.size)
        print(maskLayer.frame)
        
        return maskLayer
    }()
    
    
    @objc func startAni() {
        
        /*
         
         下面我们对_maskLayer的position作CAKeyframeAnimation动画，根据歌词数据我们可以算出每个字渲染的时间(keyTimes)和动画总时长(duration)。假设每个字是等宽的，我们可以算出_maskLayer在每一个keyTime的position，也就是values。
         */
        
        
        var keyTimes = Array<NSNumber>.init()
        
        var values = Array<NSValue>.init()
        
        let duration = Double(model.lenth)
        
        var postion:CGFloat = 0
        
        var keyTime:Double = 0

        keyTimes.append(NSNumber.init(value: keyTime))
        values.append(NSValue.init(cgPoint: CGPoint.init(x: postion-self.whiteLabel.frame.size.width, y: 0)))
        
        var a:CGFloat = 0
        for word in model.words {
            
            a += word.lenth
            
            keyTime += Double(word.lenth)/duration
            
            keyTimes.append(NSNumber.init(value: keyTime))
            
            
            
            let str = NSString.init(string: word.text)
            
            let size = str.size(withAttributes: [NSAttributedString.Key.font : greenLabel.font!])
            
            postion += size.width
            
            values.append(NSValue.init(cgPoint: CGPoint.init(x: postion-self.greenLabel.frame.size.width, y: 0)))
            
        }
        print(a,duration)
//        print(keyTimes)
//        print(values)

        //        let duration:CGFloat
        
        
        let animation = CAKeyframeAnimation.init(keyPath: "position")
        animation.keyTimes = keyTimes
        animation.values = values
        animation.duration = duration
        animation.calculationMode = kCAAnimationLinear
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
//        animation.repeatCount = MAXFLOAT
        maskLayer.add(animation, forKey: "MaskAnimation")
        
    }
    
    
}




public class XLBLine: NSObject {
    
    public var words:Array<XLBWord> = Array<XLBWord>.init() // 歌词中的每个字
    
    public var text:String = ""  // 一句歌词
    
    public var start:CGFloat = 0 // 这句歌词的开始时间
    
    public var lenth:CGFloat = 0 // 这句歌词的持续时间
    
}

public class XLBWord: NSObject {
    
    public var text:String = ""  // 每一个字
    
    public var start:CGFloat = 0 // 这个字的开始时间
    
    public var lenth:CGFloat = 0 // 这个字的持续时间
}
