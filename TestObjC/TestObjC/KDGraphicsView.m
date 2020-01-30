//
//  KDGraphicsView.m
//  TestObjC
//
//  Created by hour on 2019/3/26.
//  Copyright © 2019 hour. All rights reserved.
//

#import "KDGraphicsView.h"

@interface KDGraphicsView ()

@property (nonatomic, strong) UIBezierPath * _Nullable bezierPath;
@property (nonatomic, assign) CGPoint point;

@end

@implementation KDGraphicsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // fill
    [[UIColor redColor] setFill];
    UIRectFill(CGRectMake(50, 100, 100, 100));
//    UIRectFillUsingBlendMode(CGRectMake(100, 100, 100, 100), kCGBlendModeNormal);
    
    // stroke
    [[UIColor purpleColor] setStroke];
    UIRectFrame(CGRectMake(200, 100, 100, 100));
    
    
    // Bezier Path
    [[UIColor blackColor] setStroke];
//    UIBezierPath *path1 =[UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 250, 100, 100) cornerRadius:5];
    UIBezierPath *path1 =[UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 250, 100, 100)
                                               byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                     cornerRadii:CGSizeMake(20, 20)];   // 圆角的size
    path1.lineWidth = 5;
    [path1 stroke];
    
    [[UIColor blackColor] setFill];
    UIBezierPath *path2 =[UIBezierPath bezierPathWithOvalInRect:CGRectMake(200, 250, 100, 100)];
    [path2 fill];
    
    [[UIColor orangeColor] setStroke];
    UIBezierPath *path3 =[UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(50, 400)];
    [path3 addLineToPoint:CGPointMake(50, 500)];
    [path3 addLineToPoint:CGPointMake(100, 500)];
    [path3 closePath];  // 闭合图形
    [path3 setLineWidth:4];
    [path3 setLineCapStyle:kCGLineCapRound];
    [path3 setLineJoinStyle:kCGLineJoinBevel];
    [path3 stroke];
    self.bezierPath = path3;
    

    [[UIColor orangeColor] setStroke];
    UIBezierPath *path4 =[UIBezierPath bezierPath];
    [path4 addArcWithCenter:CGPointMake(120, 400) radius:30 startAngle:0 endAngle:M_PI clockwise:NO];
    [path4 setLineWidth:4];
    [path4 stroke];
    
    // 随手指动
    [[UIColor redColor] setStroke];
    [[UIColor blackColor] setFill];
    UIBezierPath *path5 =[UIBezierPath bezierPath];
    [path5 addArcWithCenter:self.point radius:10 startAngle:0 endAngle:2 * M_PI clockwise:NO];
    [path5 fill];
    [path5 stroke];
    
    // NSString
    NSDictionary *attrs = @{
      NSForegroundColorAttributeName: [UIColor redColor]
    };
    [@"123你好" drawInRect:CGRectMake(200, 400, 200, 200) withAttributes:attrs];
    
    // image
    UIImage *image = [UIImage imageNamed:@"widget_btn_card_normal"];
    [image drawInRect:CGRectMake(150, 450, 50, 50)];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self];
    self.point = location;
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self];
    
    if ([self.bezierPath containsPoint:location]) {
        NSLog(@"点击到了 三角形");
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
