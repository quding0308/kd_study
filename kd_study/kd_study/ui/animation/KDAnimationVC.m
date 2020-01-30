//
//  KDAnimationVC.m
//  kd_study
//
//  Created by hour on 2019/4/1.
//  Copyright © 2019 hour. All rights reserved.
//

#import "KDAnimationVC.h"

@interface KDAnimationVC () <CAAnimationDelegate>

@property (nonatomic, strong) UIView *contentView;

@end

@implementation KDAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.contentView];
    self.contentView.frame = CGRectMake(10, 10, 100, 100);
    
    self.contentView.alpha = 1;
    self.contentView.layer.opacity = 1;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self testAnimation1];
//
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self testAnimation11];
//        });
//    });
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////        [self testAnimation2];
//        [self testAnimation3];
//        [self testAnimation4];
//        [self testAnimation5];
//    });
}

- (void)testAnimation1 {
    NSLog(@"position %@", @(self.contentView.layer.position));

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.delegate = self;
    
    animation.fromValue = @(CGPointMake(60, 60));
    animation.toValue = @(CGPointMake(200, 200));
    
    // seconds
    animation.duration = 2;
    
    // 子层级相对于父层级的起始时间。
    animation.beginTime = CACurrentMediaTime() + 2;
    // 子层级相对于父层级的时间流逝速度
    animation.speed = 1;
    // 为本地时间增加一个偏移。动画持续2s，offset 为1时，动画会从中间突然开始变
    animation.timeOffset = 1;
    
    // Determines if the value specified by the animation is added to the current render tree value to produce the new render tree value.
//    animation.additive = YES;
    
    /**
     kCAFillModeForwards
     The receiver remains visible in its final state when the animation is completed.

     kCAFillModeBackwards
     The receiver clamps values before zero to zero when the animation is completed.
     回到初始位置
     */
//    animation.fillMode = kCAFillModeRemoved;

    /* A convenience method for creating common timing functions. The
     * currently supported names are `linear', `easeIn', `easeOut' and
     * `easeInEaseOut' and `default' (the curve used by implicit animations
     * created by Core Animation).
     * 也可以自定义贝塞尔曲线
     */
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // repeat 重复
//    animation.repeatCount = 5;
//    animation.repeatDuration = 20;
    
    
    // 是否从 receiver 中删除对应的 animation (animationKeys 中会删除)
//    animation.removedOnCompletion = NO;
    
    // plays backwards after playing forwards
//    animation.autoreverses = YES;
    
    [self.contentView.layer addAnimation:animation forKey:@"animation_opacity"];
}

- (void)testAnimation11 {
    NSLog(@"modelLayer position %@", @(self.contentView.layer.modelLayer.position));
    NSLog(@"presentationLayer position %@", @(self.contentView.layer.presentationLayer.position));
    
    self.contentView.layer.position = self.contentView.layer.presentationLayer.position;

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.toValue = @(CGPointMake(100, 300));
    animation.duration = 2;
    [self.contentView.layer addAnimation:animation forKey:@"animation_opacity"];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.contentView.layer.position = self.contentView.layer.presentationLayer.position;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
        animation.toValue = @(CGPointMake(300, 100));
        animation.duration = 2;
        [self.contentView.layer addAnimation:animation forKey:@"animation_opacity"];

//        self.contentView.layer.position = CGPointMake(300, 100);
    });
}

- (void)testAnimation2 {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // value
//    animation.values = @[@(CGPointMake(60, 60)), @(CGPointMake(200, 200)), @(CGPointMake(100, 300))];
    
//    UIBezierPath *path3 =[UIBezierPath bezierPath];
//    [path3 moveToPoint:CGPointMake(60, 60)];
//    [path3 addLineToPoint:CGPointMake(200, 200)];
//    [path3 addLineToPoint:CGPointMake(100, 400)];
//    [path3 addLineToPoint:CGPointMake(400, 400)];
//    [path3 closePath];  // 闭合图形
//    animation.path = path3.CGPath;
    
//    UIBezierPath *path4 =[UIBezierPath bezierPath];
//    [path4 addArcWithCenter:CGPointMake(60, 60) radius:30 startAngle:0 endAngle:M_PI clockwise:NO];
//    [path4 setLineWidth:4];
//    [path4 stroke];
//    animation.path = path4.CGPath;
    
    // time
//    animation.keyTimes = @[@(0), @(0.2), @(1)];
    animation.duration = 2;
    
    animation.repeatCount = 10;
    animation.autoreverses = YES;
    
    [self.contentView.layer addAnimation:animation forKey:@"animation_backgroundColor"];
}

- (void)testAnimation3 {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 2;
    
    animation.values = @[@(1), @(0.8), @(0.2)];
    animation.keyTimes = @[@(0), @(0.7), @(1)];

    animation.repeatCount = 10;
    animation.autoreverses = YES;
    
    [self.contentView.layer addAnimation:animation forKey:@"animation3"];
}

- (void)testAnimation4 {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    animation.values = @[@(0), @(-M_PI_4/4), @(0.0), @(M_PI_4/4), @(0)];
    animation.duration = 0.2;
    animation.repeatCount = 10;
    animation.autoreverses = YES;
    [self.contentView.layer addAnimation:animation forKey:@"animation4"];
}

- (void)testAnimation5 {
    // 弹簧效果
    CASpringAnimation *spring = [CASpringAnimation animationWithKeyPath:@"position.x"];
    
    spring.damping = 5;
    spring.fromValue = @(self.contentView.layer.position.x);
    spring.toValue = @(self.contentView.layer.position.x + 100.0);
    spring.duration = spring.settlingDuration;
    
    [self.contentView.layer addAnimation:spring forKey:@"animation5"];
}

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = UIColor.redColor;
        
        _contentView.layer.cornerRadius = 10;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}

#pragma makr - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"animationDidStart %@", anim);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"animationDidStop %@ flag: %i", anim, flag);
    
    NSLog(@"animationKeys %@", self.contentView.layer.animationKeys);
    
    NSLog(@"position %@", @(self.contentView.layer.position));
    NSLog(@"presentationLayer position %@", @(self.contentView.layer.presentationLayer.position));

//    self.contentView.layer.position = CGPointMake(200, 200);
//    NSLog(@"position %@", @(self.contentView.layer.position));
}

@end
