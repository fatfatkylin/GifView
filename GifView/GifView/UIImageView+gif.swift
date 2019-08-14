//
//  UIImageView+gif.swift
//  GifView
//
//  Created by 郑永能 on 2019/8/9.
//  Copyright © 2019年 neng. All rights reserved.
//

import UIKit

extension UIImageView {
    private class func gifWithData(_ data: Data, afterCreateImageView: @escaping ([UIImage], Double) -> ()) {
        // 创建CGImageSource
        /*CGImageSource是图片的数据读取类，常见的UIImage本质只有图像数据，而图片是包含好多信息的，比如图片的时间、尺寸、位置等，有时候还要处理GIF，是一个整合了图片所有信息的类，
          例如你需要处理GIF图片，展示就需要用到这个类，得到每一帧的图片以及各帧图片之间的延迟然后进一步处理。
           通过CGImageSourceCreateWithData方法可以获取图片的CGImgeSource，类似的方法还有CGImageSourceCreateWithURL */
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("Source for the image does not exist")
            return
        }
        
        animatedImage(source, afterCreateGif: afterCreateImageView)
    }
    
    private class func gifWithURL(_ gifUrl: String, afterCreateImageView: @escaping ([UIImage], Double) -> ()) {
        // 校验URL
        guard let bundleURL = URL(string: gifUrl)
            else {
                print("This image named \"\(gifUrl)\" does not exist")
                return
        }
        
        // 校验data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("Cannot turn image named \"\(gifUrl)\" into NSData")
            return
        }
        
        return gifWithData(imageData, afterCreateImageView: afterCreateImageView)
    }
    
    // 从资源文件中获取gif数据，生成UIImageView
    public class func gifWithName(_ name: String, afterCreateImageView: @escaping ([UIImage], Double) -> ()) {
        // 校验gif是否存在
        guard let bundleURL = Bundle.main.url(forResource: name, withExtension: "gif") else {
                print("This image named \"\(name)\" does not exist")
                return
        }
        
        // 校验data
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("Cannot turn image named \"\(name)\" into NSData")
            return
        }
        
        return gifWithData(imageData, afterCreateImageView: afterCreateImageView)
    }
    
    // 获取每一帧图片的间隔时间delaytime
    private class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        let SHORTEST_DELAY_TIME = 0.05  //设置最短的播放间隔
        var delayTime = SHORTEST_DELAY_TIME // 一帧图片的播放时间（播放间隔）
        
        // 获取gif附加属性信息，  ps：CFDictionary 是Core Foundation用c实现的，NSDictionary是Foundation是oc实现的，这里使用Dictionary
        /*获取gif图片每一帧的属性信息：包括
         {
         ColorModel = RGB;
         Depth = 8;
         PixelHeight = 960;
         PixelWidth = 640;
         “{GIF}” = {
             DelayTime = “0.4”;  // 这里的delaytime就是这一帧的播放时长
             UnclampedDelayTime = “0.4”;
             }
         }*/
        if let gifProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil) as? [String: Any] {
            if let unclampedDelayTimeProperty = gifProperties[kCGImagePropertyGIFUnclampedDelayTime as String] as? Double {
                delayTime = unclampedDelayTimeProperty
            } else {
                if let delayTimeProperty = gifProperties[kCGImagePropertyGIFDelayTime as String] as? Double {
                    delayTime = delayTimeProperty
                }
            }
        }
        
        return delayTime < SHORTEST_DELAY_TIME ? SHORTEST_DELAY_TIME: delayTime
    }

    private class func animatedImage(_ source: CGImageSource, afterCreateGif: @escaping ([UIImage], Double) -> ()) {
        let imagesCount = CGImageSourceGetCount(source)
        var cgImages = [CGImage]()  // 帧图片数组
        var delays = [Int]()  //帧图片的间隔时间
        var duration: Int = 0  // gif总的播放时间 = 每帧图片的间隔时间相加
        var frames = [UIImage]()
        
        Thread.async({
            // 获取每一帧图片的间隔时间
            for i in 0 ..< imagesCount {
                // 获取每一帧图片的ImageSource，ImageSource包含了gif的附加信息，用于获取帧图片的间隔时间
                if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                    cgImages.append(image)
                }
                
                // 获取每帧图片的间隔时间
                let delaySecond = delayForImageAtIndex(i, source: source)
                let delayMillisecond = Int(delaySecond * 1000.0)  // 转毫秒
                delays.append(delayMillisecond)
                duration += Int(delayMillisecond)  // 计算gif播放完的总时间
            }
            
            // 获取帧图片
            let gcd = delays.gcd() // 获取所有间隔时间的最大公约数，根据此公约数将不同间隔时间的帧图片拼凑成相同时间
            
            var frame: UIImage
            var frameCount: Int
            for i in 0 ..< imagesCount {
                frame = UIImage(cgImage: cgImages[Int(i)])
                frameCount = Int(delays[Int(i)] / gcd)
                
                for _ in 0..<frameCount {
                    frames.append(frame)
                }
            }
        }, mainClosure: {
            afterCreateGif(frames, Double(duration) / 1000.0)
        })
    }
}
