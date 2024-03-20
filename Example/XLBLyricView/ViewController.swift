//
//  ViewController.swift
//  XLBLyricView
//
//  Created by xiaolongbao on 03/20/2024.
//  Copyright (c) 2024 xiaolongbao. All rights reserved.
//

import UIKit
import XLBLyricView
//import XLBWord

class ViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.cyan

        let view = UIView.init(frame: self.view.bounds)
        view.backgroundColor = UIColor.black
        view.alpha = 0.3
        self.view.addSubview(view)

//        ["歌","词","播","放","速","度","测","试","~","~","~"]
        
        
        for i in [["hello"," MR.DJ"," would"," play"," my"," song"],["please"," please"," play"," it"," all"," night"," long"],["hello"," MR.DJ"," on"," the"," ridio"],["oh"," oh"," oh"],["everybody"," everyway"],["please"," call"," the"," dj"," on"," the"," air"],["from"," moon"," to"," mars"," and"," everywhere"],["please"," call"," the"," dj"," on"," the"," air"]].enumerated() {
            let line = XLBLyricView.init(frame:CGRect.init(x: 20, y: 60 * (i.offset+1), width: 414-40, height: 60))
            line.model = getModel(i.element)
            self.view.addSubview(line)

        }
        
        
        
    }

    func getModel(_ arr:Array<String>) -> XLBLine {
        let model = XLBLine.init()
        
        
        
        
        var start:CGFloat = 0
//        var length:CGFloat = 0.3
        //        var words = Array<Word>.init()
        
        model.start = 0
        
        for str in arr {
            
            let temp = CGFloat(arc4random_uniform(10))+1
            
            let word = XLBWord.init()
            word.text = str
            word.start = start
            word.lenth = temp/10
            
            start += temp/10
            print(temp)
            
            model.words.append(word)
            
            model.text.append(str)
            
            //            start += length
            //            length += 0.1
            
        }
        model.lenth = start
        
        
        return model
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

