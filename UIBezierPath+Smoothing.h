//
//  UIBezierPath+Smoothing.h
//  Exercise
//
//  Created by 汪迪岑 on 2017/10/19.
//  Copyright © 2017年 汪迪岑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (Smoothing)

-(UIBezierPath *)smoothedPath:(int)granularity;

@end
