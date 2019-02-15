//
//  MainVC.swift
//  LLHeadScaleDemo
//
//  Created by linling on 2019/2/14.
//  Copyright © 2019 llmodule. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnClick(sender:AnyObject) {
        //在单例中预下载图片，下载完成后直接赋值，提升界面操作流畅度
        ToolManager.shareInstance.downloadEffectImage("http://qiniuyun.ngba.cn//2019/01/9cba420190115102001965.jpg")
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
