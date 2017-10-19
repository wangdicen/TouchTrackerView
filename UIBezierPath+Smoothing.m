//
//  UIBezierPath+Smoothing.m
//  Exercise
//
//  Created by 汪迪岑 on 2017/10/19.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import "UIBezierPath+Smoothing.h"
#import "UIBezierPath+Points.h"


#define POINT(_INDEX_) [(NSValue *)[points objectAtIndex:_INDEX_] CGPointValue]
@implementation UIBezierPath (Smoothing)



-(UIBezierPath *)smoothedPath:(int)granularity
{
    NSMutableArray *points = [self.points mutableCopy];
    if (points.count < 4) {
        return [self copy];
    }
    
    [points insertObject:[points objectAtIndex:0] atIndex:0];
    [points addObject:[points lastObject]];
    
    UIBezierPath *smoothedPath = [UIBezierPath bezierPath];
    
    smoothedPath.lineWidth = self.lineWidth;
    
    [smoothedPath moveToPoint:POINT(0)];
    
    for (int index = 1; index <3;index++) {
        [smoothedPath addLineToPoint:POINT(index)];
    }
    
    for (int index = 4; index <points.count; index++) {
        CGPoint p0 = POINT(index -3);
        CGPoint p1 = POINT(index -2);
        CGPoint p2 = POINT(index -1);
        CGPoint p3 = POINT(index);
        
        for (int i=1; i<granularity; i++) {
            float t = (float) i*(1.0f/(float)granularity);
            float tt = t*t;
            float ttt = t*t*t;
            
            CGPoint pi;
            pi.x = 0.5*(2*p1.x + (p2.x - p0.x) *t +
                        (2*p0.x - 5*p1.x + 4*p2.x - p3.x)*tt +
                        (3*p1.x - p0.x - 3*p2.x + p3.x)*ttt);
            pi.y = 0.5*(2*p1.y + (p2.y - p0.y) *t +
                        (2*p0.y - 5*p1.y + 4*p2.y - p3.y)*tt +
                        (3*p1.y - p0.y - 3*p2.y + p3.y)*ttt);
            [smoothedPath addLineToPoint:pi];
        }
        [smoothedPath addLineToPoint:p2];
    }
    [smoothedPath addLineToPoint:POINT(points.count - 1)];
    return smoothedPath;
}


@end
