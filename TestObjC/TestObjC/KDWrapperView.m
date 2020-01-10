//
//  KDWrapperView.m
//  TestObjC
//
//  Created by hour on 2019/3/12.
//  Copyright © 2019 hour. All rights reserved.
//

#import "KDWrapperView.h"
#import <Masonry/Masonry.h>

@implementation KDWrapperView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)updateConstraints {
    [super updateConstraints];
    NSLog(@"=== wrapper updateConstraints");

    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"=== wrapper layoutSubviews");
    
    // 这个方法又会触发一次layoutSubviews
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.superview).mas_offset(180);
//    }];
}

- (void)didAddSubview:(UIView *)subview {
    NSLog(@"=== wrapper didAddSubview");
}

- (void)willRemoveSubview:(UIView *)subview {
    NSLog(@"=== wrapper willRemoveSubview");
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    NSLog(@"=== wrapper willMoveToSuperview");
    
}

- (void)didMoveToSuperview {
    NSLog(@"=== wrapper didMoveToSuperview");
    
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    NSLog(@"=== wrapper willMoveToWindow");
    
}

- (void)didMoveToWindow {
    NSLog(@"=== wrapper didMoveToWindow");
    
}


@end

