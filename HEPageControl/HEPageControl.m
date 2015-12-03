//
//  HEPageControl.m
//  MainProject
//
//  Created by wangqs on 15/4/21.
//  Copyright (c) 2015年 wqs. All rights reserved.
//

/**
 *  UIPageControl 可配置度太低，系统只提供定制圆点颜色
 *  圆点的大小和间距不会随frame改变
 *  通过遍历来做修改->
 *  更改圆点的大小：用图片替换
 *  更改圆点的间距：重新布局每个圆点
 *
 *  以上定制比较麻烦，还是动手写个PageControl吧
 *  可以使用第三方库SMPageControl
 */

#import "HEPageControl.h"

#define DOT_WIDTH 7.0f
#define DOT_HEIGHT 7.0f

#define DOT_SPACE 30.0f

@interface HEPageControl ()
@property (nonatomic,strong)UIImage *mActiveImage;
@property (nonatomic,strong)UIImage *mInactiveImage;

@property (nonatomic, assign)CGFloat dotWidth;
@property (nonatomic, assign)CGFloat dotHeight;
@property (nonatomic, assign)CGFloat dotSpace;

@end

@implementation HEPageControl

- (void)awakeFromNib
{
    self.dotWidth = DOT_WIDTH;
    self.dotHeight = DOT_HEIGHT;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dotWidth = DOT_WIDTH;
        self.dotHeight = DOT_HEIGHT;
        self.dotSpace = DOT_SPACE;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 在layoutSubviews中重新布局小圆点
    // 此时界面都已绘制完成，重新布局是最好实机
    // 界面旋转也会调layoutSubviews
    [self updateDotsFrame];
}

- (void)setActiveImage:(UIImage *)activeImage
{
    if (activeImage) {
        //self.mActiveImage = activeImage;
        self.mActiveImage = [HEPageControl createImageWithColor:[UIColor colorWithRed:121/255.0 green:96/255.0 blue:144.0/255.0 alpha:0.5]];
        self.currentPageIndicatorTintColor = [UIColor clearColor];
    }
}

- (void)setInactiveImage:(UIImage *)inactiveImage
{
    if (inactiveImage) {
        //self.mInactiveImage = inactiveImage;
        self.mInactiveImage = [HEPageControl createImageWithColor:[UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.5]];
        self.pageIndicatorTintColor = [UIColor clearColor];
    }
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    [super setCurrentPage:currentPage];
    
    if (_mActiveImage || _mInactiveImage) {
        [self updateDots];
    }
}

- (void)setDotViewWidth:(CGFloat)width
{
    self.dotWidth = width;
}

- (void)setDotViewHeight:(CGFloat)height
{
    self.dotHeight = height;
}

- (void)updateDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIView *dotView = [self.subviews objectAtIndex:i];
        
        // 每个dotView初始都是rect:{{-3.5, -3.5}, {7, 7}}
        // 之后会根据frame调整位置，圆点间隔16
        //CGRect rect = dotView.frame;
        //NSLog(@"rect:%@",NSStringFromCGRect(rect));
        
        UIImageView *dotImgView = [self imageViewForView:dotView];
        if (i == self.currentPage && _mActiveImage) {
            dotImgView.image = _mActiveImage;
        } else if (_mInactiveImage) {
            dotImgView.image = _mInactiveImage;
        }
    }
}

- (void)updateDotsFrame
{
    CGSize size = CGSizeMake(self.numberOfPages * _dotWidth + (self.numberOfPages-1) * _dotSpace, 7);
    CGFloat left = (self.bounds.size.width - size.width) / 2.0;
    
    for (int i = 0; i < [self.subviews count]; i++) {
        UIView *dotView = [self.subviews objectAtIndex:i];
        CGRect rect = dotView.frame;
        //NSLog(@"updateDotsFrame:%@",NSStringFromCGRect(rect));
        rect.origin.x = left + i * (_dotWidth + _dotSpace);
        dotView.frame = rect;
    }
}

- (UIImageView *)imageViewForView:(UIView *)view
{
    UIImageView * dotImgView = nil;
    if ([view isKindOfClass: [UIImageView class]]) {
        dotImgView = (UIImageView *) view;
    } else {
        for (UIView* subview in view.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]) {
                dotImgView = (UIImageView *)subview;
                break;
            }
        }
        if (dotImgView == nil) {
            dotImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _dotWidth, _dotHeight)];
            dotImgView.center = CGPointMake(CGRectGetWidth(view.bounds)/2.0, CGRectGetHeight(view.bounds)/2.0);
            [view addSubview:dotImgView];
        }
    }
    return dotImgView;
}


+ (UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
