# LLHeadScale
iOS tableview头部图片缩放效果 swift版本

最近项目中页面需要做一个tableview头部图片缩放效果，参考了下咸鱼app中个人中心头部模糊图片缩放效果，自己琢磨着模范做出一个效果来，先来看看效果吧

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190215112047865.gif#pic_center)

原理其实很简单：
1、imgHeadBg是在tableview下面的图片控件，viewHead是tableview的tableHeaderView，imgBg是填充viewHead的图片控件，imgHeadBg和imgBg位置要重叠
2、tableview下滑时背景图片imgHeadBg进行缩放，头部背景图片viewHead.imgBg隐藏
3、tableview上滑时显示头部背景图片viewHead.imgBg

看过源码后应该就更容易理解了，核心方法是

```swift
func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y : CGFloat = scrollView.contentOffset.y
        
        if y <= 0 {
            //隐藏头部背景图片
            if viewHead.imgBg.isHidden == false {
                viewHead.imgBg.isHidden = true
                tableView.backgroundColor = UIColor.clear
            }
            //背景图片缩放
            let height : CGFloat = CGFloat(240 + fabsf(Float(y))*2)
            let rate : CGFloat = height/240.00
            imgHeadBg.transform = .init(scaleX: rate, y: rate)
        } else {
            //显示头部背景图片
            if viewHead.imgBg.isHidden == true {
                viewHead.imgBg.isHidden = false
                tableView.backgroundColor = UIColor.white
            }
        }
    }
```
代码中我另外做了下加载图片的优化，从下载图片到生成图片高斯模糊需要些时间，这边是把所有耗时操作都放入ToolMange单例中执行，防止下载线程中断等意外。高斯模糊方法我是直接通过oc桥接的，包括图像下载缓存是用的SDWebImage，大家也可以使用喵神的[Kingfisher](https://github.com/onevcat/Kingfisher)图像下载缓存处理框架，里面也自带高斯模糊方法

```swift
// MARK: Blur
    /// Creates an image with blur effect based on `base` image.
    ///
    /// - Parameter radius: The blur radius should be used when creating blur effect.
    /// - Returns: An image with blur effect applied.
    ///
    /// - Note: This method only works for CG-based image. The current image scale is kept.
    ///         For any non-CG-based image, `base` itself is returned.
    public func blurred(withRadius radius: CGFloat) -> Image
```

[原文](https://blog.csdn.net/lin371800993/article/details/87285353)，觉得有帮助的话star一下，谢谢~😄
