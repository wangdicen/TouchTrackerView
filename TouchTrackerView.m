//
//  TouchTrackerView.m
//  Exercise
//
//  Created by 汪迪岑 on 2017/10/19.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "TouchTrackerView.h"
#import "UIBezierPath+Smoothing.h"

@implementation TouchTrackerView
{
//    UIBezierPath *path;
    NSMutableArray *strokes;
    NSMutableDictionary *touchPaths;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.multipleTouchEnabled = YES;
        strokes = [NSMutableArray array];
        touchPaths = [NSMutableDictionary dictionary];
    }
    return self;
}


-(void)clear
{
    [strokes removeAllObjects];
    [self setNeedsDisplay];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    path = [UIBezierPath bezierPath];
//    path.lineWidth = 4.0f;
//
//    UITouch *touch = [touches anyObject];
//    [path moveToPoint:[touch locationInView:self]];
    
    for (UITouch *touch in touches) {
        NSString *key = [NSString stringWithFormat:@"%d",(int)touch];
        CGPoint pt = [touch locationInView:self];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineWidth = 4.0f;
        path.lineCapStyle = kCGLineCapRound;
        [path moveToPoint:pt];
        
        [touchPaths setObject:path forKey:key];
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    UITouch *touch = [touches anyObject];
//    [path addLineToPoint:[touch locationInView:self]];
    for (UITouch *touch in touches) {
        NSString *key = [NSString stringWithFormat:@"%d",(int) touch];
        UIBezierPath *path = [touchPaths objectForKey:key];
        if(!path) break;
        CGPoint pt = [touch locationInView:self];
        [path addLineToPoint:pt];
    }
    
    [self setNeedsDisplay];
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    UITouch *touch = [touches anyObject];
//    [path addLineToPoint:[touch locationInView:self]];
//    path= [path smoothedPath:4];
    for (UITouch *touch in touches) {
        NSString *key = [NSString stringWithFormat:@"%d",(int) touch];
        UIBezierPath *path = [touchPaths objectForKey:key];
        path= [path smoothedPath:4];
        if (path) [strokes addObject:path];
        [touchPaths removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (UIBezierPath *path in strokes) {
        [path stroke];
    }
    for (UIBezierPath *path in [touchPaths allValues]) {
        [path stroke];
    }
}


@end
