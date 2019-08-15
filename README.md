# GiFView
**An easy way to use gif. It is written by swift.**
>I made this for personal use, but feel free to use it or contribute. 
>For more examples check out [Sources](https://github.com/fatfatkylin/GifView/tree/master/GifView/GifView) and [Example](https://github.com/fatfatkylin/GifView/blob/master/GifView/ViewController.swift).

## Index
- [Intro](#intro)
- [Usage](#usage)
- [Installation](#installation)
- [License](#license)

## Intro
This is not a perfect way to solve the gif problems. Yout can easily use the GifView to play gif in correct frames or stop the gif. 

## Usage
You can new a GifView by using storyborad、xib. Then you should init the GifView by using the function 'initGifWithName'. After initing the gif, you can use the function 'play' or 'stop' to control the gif. ps:More function are coming soon.
```swift
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
```

## Installation
- [CocoaPods](http://cocoapods.org/):

	```ruby
	pod 'GifView'
	```
- SourceCode

   ```
	You can easily copy the source files to project.
   ```

## License
GifView is released under the MIT license. See [LICENSE](LICENSE) for details.






