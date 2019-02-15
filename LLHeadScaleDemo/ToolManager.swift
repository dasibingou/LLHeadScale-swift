//
//  ToolManager.swift
//  LLHeadScaleDemo
//
//  Created by linling on 2019/2/14.
//  Copyright © 2019 llmodule. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ToolManager: NSObject {
    static let shareInstance = ToolManager()
    
    var effectHead : UIImageView?
    var effectBg : UIImageView?
    var effectImg : UIImage?
    
    //下载获取图片
    func downloadEffectImage(_ url:String?) -> Void {
        if url != nil {
            let manager = SDWebImageManager.shared()
            //根据url检测是否有图片缓存
            manager.cachedImageExists(for: URL(string: url!)) { (isInCache:Bool) in
                if isInCache {
                    //有缓存则取缓存
                    let img = manager.imageCache?.imageFromCache(forKey: url!)
                    //图片模糊
                    self.handleEffectImage(img)
                } else {
                    //无缓存则下载图片
                    SDWebImageDownloader.shared().downloadImage(with: URL(string: url!), options: [], progress: nil) { (image, data, error, compelte) in
                        //图片模糊
                        self.handleEffectImage(image)
                    }
                }
            }
        }
    }
    
    //图片模糊操作
    func handleEffectImage(_ image:UIImage?) -> Void {
        effectImg = EffectView.boxblurImage(withBlur: 20, image: image!)
        if effectHead != nil {
            effectHead?.image = effectImg
            effectBg?.image = effectImg
        }
    }
    
    //图片赋值
    func loadEffectImage(head:UIImageView?,bg:UIImageView?) -> Void {
        effectHead = head
        effectBg = bg
        
        if effectImg == nil {
            effectHead?.backgroundColor = UIColor.gray
            effectBg?.backgroundColor = UIColor.gray
        } else {
            effectHead?.image = effectImg
            effectBg?.image = effectImg
        }
    }
    
}
