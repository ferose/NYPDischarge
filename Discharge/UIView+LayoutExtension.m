//
//  UIView+LayoutExtension.m
//  dtrain
//
//  Created by William Chen on 12/9/13.
//  Copyright (c) 2013 William Morris Endeavor. All rights reserved.
//

#import "UIView+LayoutExtension.h"

@implementation UIView (LayoutExtension)


-(void)setX:(CGFloat)x
{
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}

-(CGFloat)x
{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y
{
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

-(CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}

-(CGFloat)width
{
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height
{
   self.frame = CGRectMake(self.x, self.y, self.width, height);
}

-(CGFloat)height
{
    return self.frame.size.height;
}

-(CGFloat) scaleX
{
    CGAffineTransform t = self.transform;
    return sqrt(t.a * t.a + t.c * t.c);
}

-(CGFloat) scaleY
{
    CGAffineTransform t = self.transform;
    return sqrt(t.b * t.b + t.d * t.d);
}

- (CGFloat) rotation
{
    CGAffineTransform t = self.transform;
    return atan2f(t.b, t.a);
}

-(void)setRotation:(CGFloat)rotation
{
    self.transform = CGAffineTransformMakeRotation(rotation);
}

-(void)setScaleX:(CGFloat)scaleX
{
    self.transform = CGAffineTransformMakeScale(scaleX, self.scaleY);
}

-(void)setScaleY:(CGFloat)scaleY
{
    self.transform = CGAffineTransformMakeScale(self.scaleX, scaleY);
}

-(CGFloat)frameRight
{
    return self.frame.origin.x + self.frame.size.width;
}

-(void) setFrameBottom:(CGFloat)frameBottom
{
    self.y = frameBottom - self.height;
}

-(CGFloat)frameBottom
{
    return self.frame.origin.y + self.frame.size.height;
}

-(void)setOrigin:(CGPoint)origin
{
    self.frame = CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height);
}

-(void)setOrigin:(CGFloat)x y:(CGFloat)y
{
    [self setOrigin:CGPointMake(x, y)];
}

-(CGPoint)origin
{
    return self.frame.origin;
}

-(void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

-(void)setSize:(CGFloat)width height:(CGFloat)height
{
    [self setSize:CGSizeMake(width, height)];
}

-(CGSize)size
{
    return self.frame.size;
}

-(void)centerVertically
{
    if (self.superview)
    {
        self.y = (self.superview.height - self.height) * 0.5;
    }
}

-(void)centerHorizontally
{
    if (self.superview)
    {
        self.x = (self.superview.width - self.width) * 0.5;
    }
}

-(void)fillVertically
{
    if (self.superview)
    {
        self.height = self.superview.height;
        self.y = 0;
    }
}

-(void)fillHorizontally
{
    if (self.superview)
    {
        self.width = self.superview.width;
        self.x = 0;
    }
}

-(void)centerInSuperview
{
    [self centerHorizontally];
    [self centerVertically];
}

-(void)alignToRightInSuperview
{
    if (self.superview)
    {
        self.x = self.superview.width - self.width;
    }
}

@end
