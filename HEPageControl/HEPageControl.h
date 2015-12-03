//
//  HEPageControl.h
//  MainProject
//
//  Created by wangqs on 15/4/21.
//  Copyright (c) 2015年 wqs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HEPageControl : UIPageControl

/**
 *  设置当前dot的图片
 *
 *  @param activeImage 自定义的UIImage
 */
- (void)setActiveImage:(UIImage *)activeImage;

/**
 *  设置非当前dot的图片
 *
 *  @param inactiveImage 自定义的UIImage
 */
- (void)setInactiveImage:(UIImage *)inactiveImage;

/**
 *  设置dot宽度
 *
 *  @param width
 */
- (void)setDotViewWidth:(CGFloat)width;

/**
 *  设置dot高度
 *
 *  @param height
 */
- (void)setDotViewHeight:(CGFloat)height;

/**
 *  通过color构造UIImage
 *
 *  @param color
 *
 *  @return UIImage
 */
+ (UIImage*)createImageWithColor:(UIColor*)color;


@end
