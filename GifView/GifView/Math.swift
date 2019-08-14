//
//  Int+gcd.swift
//  GifView
//
//  Created by 郑永能 on 2019/8/9.
//  Copyright © 2019年 neng. All rights reserved.
//

import Foundation

class Math {
    // 交换两个数
    static func swapTwoNum(_ a: inout Int, _ b: inout Int) {
        let numTemp = a
        a = b
        b = numTemp
    }
    
    // 求a+b的最大公约数
    static func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        if let num1 = a, let num2 =  b {
            var vNum1 = num1
            var vNum2 = num2
            if vNum1 < vNum2 {
                swapTwoNum(&vNum1, &vNum2)
            }
            while(true) {
                var remainder = vNum1 % vNum2
                if remainder == 0 {
                    return vNum2
                } else {
                    swapTwoNum(&vNum1, &vNum2)
                    swapTwoNum(&vNum2, &remainder)
                }
            }
        } else {
            if a == nil && b == nil {
                return 0
            } else if a == nil && b != nil {
                return b!
            } else if a != nil && b == nil {
                return a!
            }
        }
        
        return 0
    }
}
