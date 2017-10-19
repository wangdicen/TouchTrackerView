//
//  UIBezierPath+Points.m
//  Exercise
//
//  Created by 汪迪岑 on 2017/10/19.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "UIBezierPath+Points.h"
#define VALUE(_INDEX_) [NSValue valueWithCGPoint:points[_INDEX_]]
@implementation UIBezierPath (Points)

void getPointsFormBezier(void *info,const CGPathElement *element)
{
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    CGPathElementType type = element -> type;
    CGPoint *points = element->points;
    
    if(type != kCGPathElementCloseSubpath)
    {
        [bezierPoints addObject:VALUE(0)];
        if (type != kCGPathElementAddLineToPoint && type != kCGPathElementMoveToPoint) {
            [bezierPoints addObject:VALUE(1)];
        }
    }
    if (type == kCGPathElementAddCurveToPoint) {
        [bezierPoints addObject:VALUE(2)];
    }
}

- (NSArray *)points
{
    NSMutableArray *points = [NSMutableArray array];
    CGPathApply(self.CGPath, (__bridge void *)points, getPointsFormBezier);
    return points;
}

@end
