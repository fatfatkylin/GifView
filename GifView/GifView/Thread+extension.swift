//
//  Thread+extension.swift
//  GifView
//
//  Created by 郑永能 on 2019/8/14.
//  Copyright © 2019年 neng. All rights reserved.
//

import Foundation

extension Thread {
    //延迟n秒后执行
    static func delayAfterSeconds(_ delay: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int(delay * Double(NSEC_PER_SEC))), execute: closure)
    }
    
    //切换到主线程执行
    static func main(_ closure: @escaping () -> ()) {
        DispatchQueue.main.async(execute: closure)
    }
    
    //切到异步线程执行，完成后切回到主线程
    static func async(_ asyncClosure: @escaping () -> (), mainClosure: @escaping () -> ()) {
        DispatchQueue.global().async {
            asyncClosure()
            DispatchQueue.main.async(execute: mainClosure)
        }
    }
}
