//
//  UIView+LFExtension.m
//  JSApp
//
//  Created by Feng Lu on 2017/2/8.
//  Copyright © 2017年 wangyuxi. All rights reserved.
//

#import "UIView+LFExtension.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

static char kDTActionHandlerTapBlockKey;
static char kDTActionHandlerTapGestureKey;
static char kDTActionHandlerLongPressBlockKey;
static char kDTActionHandlerLongPressGestureKey;

@implementation UIView (LFExtension)

-(UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    do {
        //判断响应者是否为视图控制器
        if ([next isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    } while (next != nil);
    return nil;
}

-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
-(CGFloat)x
{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
-(CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(CGFloat)width
{
    return self.frame.size.width;
}
-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(CGFloat)height
{
    return self.frame.size.height;
}

-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
-(CGSize)size
{
    return self.frame.size;
}
-(void)setPoint:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
-(CGPoint)origin
{
    return self.frame.origin;
}

-(void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
-(CGFloat)right
{
    return self.frame.size.width + self.frame.origin.x;
}
-(void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
-(CGFloat)bottom
{
    return self.frame.size.height + self.frame.origin.y;
}

//删除所有子类
-(void)removeAllSubViews
{
    for (id objc in [self subviews]) {
        if ([objc isKindOfClass:[UIView class]]){
        
            UIView *view = (UIView *)objc;
            [view removeFromSuperview];
        }
    }
}

-(void)removeSubviewsWithSubviewClass:(Class)cls
{
    for (UIView *view in [self subviews]) {
        if ([view isKindOfClass:cls])
        {
            [view removeFromSuperview];
        }
    }
}

-(void)removeSubviewsWithSubviewTag:(NSInteger)tag
{
    UIView *view = [self viewWithTag:tag];
    [view removeFromSuperview];
}
#pragma mark === 判断View是否显示在屏幕上
-(BOOL)isDisplayedInScreen
{
    if (self == nil)
    {
        return FALSE;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    //转换view对应window的Rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect))
    {
        return FALSE;
    }
    
    //若view 隐藏
    if (self.hidden) {
        return FALSE;
    }
    
    //若没有superView
    if (self.superview == nil) {
        return FALSE;
    }
    
    //若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero))
    {
        return FALSE;
    }
    
    //获取 该view与window 交叉的Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return FALSE;
    }
    
    return TRUE;
}
-(void)setTapActionWithBlock:(void (^)(void))block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(__handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
    }
}
-(void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        if (action) {
            action();
        }
    }
}

-(void)setLongPressActionWithBlock:(void (^)(void))block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerLongPressGestureKey);
    if (!gesture) {
        gesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(__handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kDTActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}
-(void)__handleActionForLongPressGesture:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerLongPressBlockKey);
        if (action) {
            action();
        }
    }
}

@end
