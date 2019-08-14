//
//  Array+gcd.swift
//  GifView
//
//  Created by 郑永能 on 2019/8/10.
//  Copyright © 2019年 neng. All rights reserved.
//

import Foundation

extension Array where Element == Int {
    // 返回整个数组的最大公约数
    func gcd() -> Int {
        if self.count <= 0 {
            return 1
        }
        
        var gcd = self[0]
        for item in self {
            gcd = Math.gcdForPair(item, gcd)
        }
        
        return gcd
    }
}
