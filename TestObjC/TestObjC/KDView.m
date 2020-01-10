//
//  KDView.m
//  TestObjC
//
//  Created by hour on 2019/3/12.
//  Copyright © 2019 hour. All rights reserved.
//

#import "KDView.h"

@implementation KDView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //
        
        self.backgroundColor = [UIColor redColor];
        
        /*
        [self setNeedsDisplay];
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
        
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
         */
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        //
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)updateConstraints {
    [super updateConstraints];
    NSLog(@"=== subview updateConstraints");
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"=== subview layoutSubviews");
    
}

- (void)didAddSubview:(UIView *)subview {
    NSLog(@"=== subview didAddSubview");
}

- (void)willRemoveSubview:(UIView *)subview {
    NSLog(@"=== subview willRemoveSubview");

}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    NSLog(@"=== subview willMoveToSuperview");

}

- (void)didMoveToSuperview {
    NSLog(@"=== subview didMoveToSuperview");

}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    NSLog(@"=== subview willMoveToWindow");

}

- (void)didMoveToWindow {
    NSLog(@"=== subview didMoveToWindow");

}


@end
