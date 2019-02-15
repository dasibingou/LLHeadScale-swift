//
//  ViewController.swift
//  LLHeadScaleDemo
//
//  Created by linling on 2019/2/13.
//  Copyright © 2019 llmodule. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView : UITableView!
    var imgHeadBg : UIImageView!
    var viewHead : HeadView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.ll_createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    func ll_createUI() -> Void {
        let height = kScreenHeight
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: height), style: .plain)
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = loadViewFromNib()
        tableView.backgroundColor = UIColor.clear
        view.addSubview(tableView)
        
        let viewBg = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        viewBg.backgroundColor = UIColor.white
        view.insertSubview(viewBg, at: 0)
        
        /*
         添加背景图片，原理是:
         tableview下滑时背景图片imgHeadBg进行缩放，头部背景图片viewHead.imgBg隐藏
         tableview上滑时显示头部背景图片viewHead.imgBg
        */
        imgHeadBg = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 240))
        imgHeadBg.contentMode = .scaleAspectFill
        imgHeadBg.clipsToBounds = true
        viewBg.addSubview(imgHeadBg)
        
        if #available(iOS 11.0, *) {
            tableView?.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        tableView.reloadData()
        
        DispatchQueue.main.async {
            self.loadData()
        }
    }
    
    //加载xib
    func loadViewFromNib() -> UIView {
        let view = Bundle.main.loadNibNamed("HeadView", owner: self, options: nil)?.last as! HeadView
        view.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 240)
        viewHead = view
        return view
    }
    
    //加载数据
    func loadData() -> Void {
        let data = ["bg":"http://qiniuyun.ngba.cn//2019/01/9cba420190115102001965.jpg","head":"http://qiniuyun.ngba.cn//2019/01/9cba420190115102001965.jpg"]
        viewHead.loadData(data: data)
        
        //单例图片赋值
        ToolManager.shareInstance.loadEffectImage(head: &viewHead.imgBg, bg: &imgHeadBg)
    }
    
//MARK: UITableViewDelegate
    
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
            DLog("hidden:\(viewHead.imgBg.isHidden)")
        } else {
            //显示头部背景图片
            if viewHead.imgBg.isHidden == true {
                viewHead.imgBg.isHidden = false
                tableView.backgroundColor = UIColor.white
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "UITableViewCell")
        }
        cell?.textLabel?.text = "点击"
        cell?.detailTextLabel?.text = "返回"
        cell?.imageView?.image = UIImage.init(named: "Expense_success")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
    }

}

