//
//  Macro.swift
//  LLHeadScaleDemo
//
//  Created by linling on 2019/2/13.
//  Copyright © 2019 llmodule. All rights reserved.
//

import Foundation
import UIKit

// MARK: -------------------------- 适配 --------------------------
/// 屏幕宽度
let kScreenHeight = UIScreen.main.bounds.height
/// 屏幕高度
let kScreenWidth = UIScreen.main.bounds.width

/// 状态栏高度
let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
/// 导航栏高度
let kNavigationbarHeight = (kStatusBarHeight+44.0)
/// Tab高度
let kTabBarHeight = kStatusBarHeight > 20 ? 83 : 49

/// 屏幕比率
let kScreenWidthRatio = (kScreenWidth/375.0)
/// 调整
func AdaptedValue(x:Float) -> Float {
    return Float(CGFloat(x) * kScreenWidthRatio)
}
func ShiPei(x:Float) -> Float{
    return AdaptedValue(x: x)
}
/// 调整字体大小
func AdaptedFontSizeValue(x:Float) -> Float {
    return (x) * Float(kScreenWidthRatio)
}

// MARK: -------------------------- 颜色 --------------------------
// MARK: 请参考 UIColor_Extentsion.swift 文件

// MARK: -------------------------- 偏好 --------------------------
func SaveInfoForKey(_ value:String ,_ Key:String) {
    UserDefaults.standard.set(value, forKey: Key)
    UserDefaults.standard.synchronize()
}
func GetInfoForKey(_ Key:String) -> Any! {
    return UserDefaults.standard.object(forKey: Key)
}
func RemoveObjectForKey(_ Key:String){
    UserDefaults.standard.removeObject(forKey: Key)
    UserDefaults.standard.synchronize()
}

// MARK: -------------------------- 输出 --------------------------
// 带方法名、行数
func printLog<T>(_ message:T,method:String = #function,line:Int = #line){
    print("-[method:\(method)] " + "[line:\(line)] " + "\(message)")
}
// 只在Debug下输出，为了给习惯OC输出写法的同事
func DLog(_ format: String, method:String = #function,line:Int = #line,_ args: CVarArg...){
    //    print("-[method:\(method)] " + "[line:\(line)] ", separator: "", terminator: "")
    #if DEBUG
    let va_list = getVaList(args)
    NSLogv(format, va_list)
    #else
    #endif
}
// 只在Debug下输出，为了为习惯PHP输出写法的同事
func echo(_ format: String,_ args: CVarArg...) {
    #if DEBUG
    let va_list = getVaList(args)
    NSLogv(format, va_list)
    #else
    #endif
}

extension UIColor {
    // RGB颜色
    static func rgba(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat) -> UIColor {
        return UIColor.init(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: a)
    }
    static func rgb(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor {
        return rgba((r), (g), (b), 1)
    }
    /// 十六进制的色值 例如：0xfff000
    static func hex(_ value:Int) -> UIColor{
        return rgb(CGFloat((value & 0xFF0000) >> 16),
                   CGFloat((value & 0x00FF00) >> 8),
                   CGFloat((value & 0x0000FF)))
    }
    /// 十六进制的色值，例如：“#FF0000”，“0xFF0000”
    static func hexString(_ value:String) -> UIColor{
        var cString:String = value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        cString = cString.lowercased()
        if cString.hasPrefix("#") {
            cString = cString.substring(from: cString.index(after: cString.startIndex))
        }
        if cString.hasPrefix("0x") {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))
        }
        if cString.lengthOfBytes(using: String.Encoding.utf8) != 6 {
            return UIColor.clear
        }
        var startIndex = cString.startIndex
        var endIndex = cString.index(startIndex, offsetBy: 2)
        let rStr = cString[startIndex..<endIndex]
        startIndex = cString.index(startIndex, offsetBy: 2)
        endIndex = cString.index(startIndex, offsetBy: 2)
        let gStr = cString[startIndex..<endIndex]
        startIndex = cString.index(startIndex, offsetBy: 2)
        endIndex = cString.index(startIndex, offsetBy: 2)
        let bStr = cString[startIndex..<endIndex]
        var r :UInt32 = 0x0;
        var g :UInt32 = 0x0;
        var b :UInt32 = 0x0;
        Scanner.init(string: String(rStr)).scanHexInt32(&r);
        Scanner.init(string: String(gStr)).scanHexInt32(&g);
        Scanner.init(string: String(bStr)).scanHexInt32(&b);
        return rgb(CGFloat(r), CGFloat(g), CGFloat(b))
    }
    /// 随机色
    static var rand: UIColor {
        return rgb(CGFloat(arc4random_uniform(255)), CGFloat(arc4random_uniform(255)), CGFloat(arc4random_uniform(255)))
    }
}

extension String {
    /// 将字符串转换为合法的数字字符
    ///
    /// - Returns: String类型
    func toPureNumber() -> String {
        let characters:String = "0123456789."
        var originString:String = ""
        for c in self {
            if characters.contains(c){
                if ".".contains(c) && originString.contains(c){}
                else{
                    originString.append(c)
                }
            }
        }
        return originString
    }
    /// 将字符串转换为 Double 类型的数字
    ///
    /// - Returns: Double类型
    func toDouble() -> Double {
        return Double(self.toPureNumber())!
    }
    /// 将字符串转换为 Float 类型的数字
    ///
    /// - Returns: Float类型
    func toFloat() -> Float {
        return Float(self.toDouble())
    }
    /// 将字符串转换为 Int 类型的数字
    ///
    /// - Returns: Int类型
    func toInt() -> Int {
        return Int(self.toDouble())
    }
    
    // 保留旧版本的字符转换为数字类型，例："123".floatValue
    var pureNumber: String {
        return self.toPureNumber()
    }
    var doubleValue: Double {
        return self.toDouble()
    }
    var floatValue: Float {
        return self.toFloat()
    }
    var intValue: Int {
        return self.toInt()
    }
}
