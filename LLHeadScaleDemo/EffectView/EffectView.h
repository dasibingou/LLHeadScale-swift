//
//  EffectView.h
//  LLHeadScaleDemo
//
//  Created by linling on 2019/2/13.
//  Copyright © 2019 llmodule. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EffectView : UIView

+ (UIImage *)boxblurImageWithBlur:(CGFloat)blur image:(UIImage *)originImg;

@end

NS_ASSUME_NONNULL_END
