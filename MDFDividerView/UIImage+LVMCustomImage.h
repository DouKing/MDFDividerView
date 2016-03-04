//
//  UIImage+LVMCustomImage.h
//  Secoo-iPhone
//
//  Created by WuYikai on 15/4/3.
//  Copyright (c) 2015年 secoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LVMCustomImage)

/**
 *  根据颜色和尺寸生成image
 *
 *  @param color 指定颜色
 *  @param size  指定尺寸
 *
 *  @return UIImage
 */
+ (UIImage *)lvm_imageWithColor:(UIColor *)color size:(CGSize)size;


@end
