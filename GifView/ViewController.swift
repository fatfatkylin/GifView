//
//  ViewController.swift
//  GifView
//
//  Created by 郑永能 on 2019/8/9.
//  Copyright © 2019年 neng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var gifV: GifView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gifV.initGifWithName("CtlGifMove") // CtlGifMove为资源文件，见路径：GifView/resource/gif/CtlGifMove.gif
        gifV.contentMode = UIView.ContentMode.scaleAspectFill  // 改变缩放模式，防止图片拉伸
        gifV.clipsToBounds = true
        
        playBtn.addTarget(self, action: #selector(play), for: .touchUpInside)  //播放gif动画
        stopBtn.addTarget(self, action: #selector(stop), for: .touchUpInside)  //停止gif动画
    }

    @objc func play(sender: UIButton) {
        gifV.play()
    }
    
    @objc func stop(sender: UIButton) {
        gifV.stop()
    }
}

