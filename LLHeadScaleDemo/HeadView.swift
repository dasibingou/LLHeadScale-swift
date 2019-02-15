//
//  HeadView.swift
//  LLHeadScaleDemo
//
//  Created by linling on 2019/2/13.
//  Copyright © 2019 llmodule. All rights reserved.
//

import UIKit
import SDWebImage

class HeadView: UIView {
    @IBOutlet var imgBg : UIImageView!
    @IBOutlet var imgHead : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func loadData(data:Dictionary<String,String>?) -> Void {
        
        imgBg.isHidden = true
        
        imgHead.layer.masksToBounds = true
        imgHead.layer.cornerRadius = 75.0/2
        
        imgBg.sd_setImage(with: URL(string: data!["bg"]!), placeholderImage: UIImage(named: "placeholder.png"))
        imgHead.sd_setImage(with: URL(string: data!["head"]!), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    
    //加载xib
    func loadViewFromNib() -> UIView {
        let className = type(of: self)
        let bundle = Bundle(for: className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}
