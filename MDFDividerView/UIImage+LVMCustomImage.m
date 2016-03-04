//
//  UIImage+LVMCustomImage.m
//  Secoo-iPhone
//
//  Created by WuYikai on 15/4/3.
//  Copyright (c) 2015年 secoo. All rights reserved.
//

#import "UIImage+LVMCustomImage.h"

@implementation UIImage (LVMCustomImage)

+ (UIImage *)lvm_imageWithColor:(UIColor *)color size:(CGSize)size {
  @autoreleasepool {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
  }
}

@end
