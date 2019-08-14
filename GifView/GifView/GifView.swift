//
//  GifView.swift
//  GifView
//
//  Created by 郑永能 on 2019/8/9.
//  Copyright © 2019年 neng. All rights reserved.
//

import Foundation
import UIKit

public class GifView: UIImageView {
    init() {
        super.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func initGifWithName(_ name: String) {
        UIImageView.gifWithName(name, afterCreateImageView: { [weak self] images, duration in
            if images.count > 0 {
                self?.animationImages = images
                self?.animationDuration = duration
                self?.image = images[images.count-1]  //默认最后一张图片作为gif静态显示的图片
            }
        })
    }
    
    public func play() {
        if self.animationImages != nil {
            if self.animationImages!.count > 0 {
                self.startAnimating()
            }
        }
    }
    
    public func stop() {
        if self.animationImages != nil {
            if self.animationImages!.count > 0 {
                self.stopAnimating()
            }
        }
    }
}
