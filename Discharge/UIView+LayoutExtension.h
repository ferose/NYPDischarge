//
//  UIView+LayoutExtension.h
//  dtrain
//
//  Created by William Chen on 12/9/13.
//  Copyright (c) 2013 William Morris Endeavor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LayoutExtension)

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat scaleX;
@property (nonatomic) CGFloat scaleY;
@property (nonatomic) CGFloat rotation;
@property (readonly, nonatomic) CGFloat frameRight;
@property (nonatomic) CGFloat frameBottom;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

-(void)setOrigin:(CGFloat)x y:(CGFloat)y;
-(void)setSize:(CGFloat)width height:(CGFloat)height;
-(void)centerVertically;
-(void)centerHorizontally;
-(void)fillVertically;
-(void)fillHorizontally;
-(void)centerInSuperview;
-(void)alignToRightInSuperview;

@end
