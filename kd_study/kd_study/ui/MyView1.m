//
//  MyView.m
//  kd_study
//
//  Created by hour on 2018/12/18.
//  Copyright © 2018 hour. All rights reserved.
//

#import "MyView1.h"

//#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

@implementation MyView1

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)test {
    
    // layer 的state 改变，通过 Transaction 提供 动画过渡  默认是 渐变
    CATransaction *transaction = [[CATransaction alloc] init];
    
    [CATransaction begin];
    
    
    [CATransaction commit];
    
}

@end
