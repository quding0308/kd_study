//
//  KDLayerVC.m
//  kd_study
//
//  Created by hour on 2019/4/1.
//  Copyright © 2019 hour. All rights reserved.
//

#import "KDLayerVC.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface KDLayerVC ()

@property (nonatomic, strong) CALayer *layer;

/// Text、Shape、Gradient
@property (nonatomic, strong) CATextLayer *textLayer;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

/// particle system(粒子系统)
/// emitter 发射器   particle 粒子
@property (nonatomic, strong) CAEmitterLayer *emitterLayer;

/// Advanced Layer Options
@property (nonatomic, strong) CAScrollLayer *scrollLayer;
@property (nonatomic, strong) CATiledLayer *titledLayer;
@property (nonatomic, strong) CATransformLayer *transformLayer;
@property (nonatomic, strong) CAReplicatorLayer *replicatorLayer;
@property (nonatomic, strong) CALayer *rotationLayer;

/// Metal、OpenGL
//@property (nonatomic, strong) CAMetalLayer *metalLayer;
@property (nonatomic, strong) CAEAGLLayer *eaglLayer;   // opengl es 从 iOS2以后将要被废弃

@property (nonatomic, strong) NSTimer  *m_timer2;

@end

@implementation KDLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
//    [self.view.layer addSublayer:self.textLayer];
//    [self.view.layer addSublayer:self.shapeLayer];
//    [self.view.layer addSublayer:self.gradientLayer];
    
//    [self.view.layer addSublayer:self.emitterLayer];
    
//    [self.view.layer addSublayer:self.rotationLayer];
//    [self.view.layer addSublayer:self.transformLayer];

    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (CATextLayer *)textLayer {
    if (_textLayer == nil) {
        _textLayer = [[CATextLayer alloc] init];
        _textLayer.bounds = CGRectMake(0, 0, 350, 350);
        _textLayer.position = CGPointMake(175, 175);
        _textLayer.backgroundColor = [UIColor yellowColor].CGColor;
        
        _textLayer.opaque = YES;
        
        // NSString 或 NSAttributedString
        _textLayer.string = @"123fasdfasdfasdfasdfasdfadsfasdfasdfasdfasdfasdfadsfasdfadsfadsfadsfadsfadsfadsfadsfa";
        
        // CFTypeRef
        UIFont *font = [UIFont systemFontOfSize:10];
        _textLayer.font = CGFontCreateWithFontName((CFStringRef)font.fontName);
        _textLayer.fontSize = 20;
        _textLayer.foregroundColor = [[UIColor redColor] CGColor];
        
        // 文字是否像素画
//        _textLayer.allowsFontSubpixelQuantization = NO;
        
        // 不会出现锯齿
        _textLayer.contentsScale = [[UIScreen mainScreen] scale];

        // 是否自适应边界  是否会换行
        _textLayer.wrapped = YES;
        
        // ... 省略号的位置 kCATruncationStart kCATruncationEnd kCATruncationMiddle
        _textLayer.truncationMode = kCATruncationNone;
        
        // 水平对齐方式
        /*
         kCAAlignmentCenter
         kCAAlignmentLeft
         kCAAlignmentRight
         kCAAlignmentJustified
         kCAAlignmentNatural
         */
        _textLayer.alignmentMode = kCAAlignmentRight;
        
        // 抗锯齿 怎么处理？
        // sub-pixel antialiasing
    }
    
    return _textLayer;
}

- (CAShapeLayer *)shapeLayer {
    if (_shapeLayer == nil) {
        _shapeLayer = [[CAShapeLayer alloc] init];
        _shapeLayer.bounds = CGRectMake(0, 0, 350, 350);
        _shapeLayer.position = CGPointMake(175, 175);
        _shapeLayer.backgroundColor = [UIColor yellowColor].CGColor;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(100, 100)];
        [path addLineToPoint:CGPointMake(100, 200)];
        [path addLineToPoint:CGPointMake(200, 100)];
        [path closePath];
        [[UIColor redColor] setStroke];
        [path setLineWidth:3];
        [path stroke];
        
        _shapeLayer.path = path.CGPath;
    }
    
    return _shapeLayer;
}

- (CAGradientLayer *)gradientLayer {
    if (_gradientLayer == nil) {
        _gradientLayer = [[CAGradientLayer alloc] init];
        _gradientLayer.bounds = CGRectMake(0, 0, 350, 350);
        _gradientLayer.position = CGPointMake(175, 175);
        
        _gradientLayer.colors =  [NSArray arrayWithObjects:
                                  UIColor.redColor.CGColor,
                                  UIColor.yellowColor.CGColor,
                                  UIColor.blueColor.CGColor, nil];
  
//                                @[UIColor.redColor.CGColor,
//                                  (CGColorRef *)UIColor.yellowColor.CGColor,
//                                  (CGColorRef *)UIColor.blueColor.CGColor];
        
        _gradientLayer.startPoint = CGPointMake(0, 0);
//        _gradientLayer.endPoint = CGPointMake(0.5, 0.5);
        _gradientLayer.endPoint = CGPointMake(1, 1);
        _gradientLayer.locations = @[@(0), @(0.8), @(1)]; // 每个颜色停止的点
        
        _gradientLayer.type = kCAGradientLayerAxial;    // 沿 轴方向 根据 startPoint 和 endPoint 确定x y轴
//        _gradientLayer.type = kCAGradientLayerConic;    // 圆锥形
//        _gradientLayer.type = kCAGradientLayerRadial; // 放射状 弧形
    }
    
    return _gradientLayer;
}

- (CAEmitterLayer *)emitterLayer {
    if (_emitterLayer == nil) {
        _emitterLayer = [[CAEmitterLayer alloc] init];
        _emitterLayer.bounds = CGRectMake(0, 0, 350, 350);
        _emitterLayer.position = CGPointMake(175, 175);
        _emitterLayer.backgroundColor = [UIColor whiteColor].CGColor;
        
        // 发射点
        _emitterLayer.emitterPosition = CGPointMake(175, 175);
        
//        _emitterLayer.renderMode = kCAEmitterLayerOutline;
        
        CAEmitterCell *cell = [[CAEmitterCell alloc] init];
        cell.birthRate = 100;
        cell.lifetime = 10;
        cell.velocity = 100;
        cell.scale = 0.1;
        
        cell.emissionRange = M_PI * 2.0;
        cell.contents = (id)[UIImage imageNamed:@"login_btn_email_normal"].CGImage;
        
        _emitterLayer.emitterCells = @[cell];
    }
    
    return _emitterLayer;
}

- (CALayer *)rotationLayer {
    if (_rotationLayer == nil) {
        _rotationLayer = [[CALayer alloc] init];
        _rotationLayer.frame = CGRectMake(50, 200, 150, 150);
        _rotationLayer.backgroundColor = [UIColor redColor].CGColor;
        
        CATransform3D plane_3D = CATransform3DIdentity;
        plane_3D.m34           = 1.0/ -500;
        plane_3D               = CATransform3DRotate(plane_3D, DEGREES_TO_RADIANS(30), 0, 1, 0);
        _rotationLayer.transform    = plane_3D;
        
    }
    return _rotationLayer;
}

/// 创建3D图层
- (CATransformLayer *)transformLayer {
    if (_transformLayer == nil) {
        _transformLayer = [[CATransformLayer alloc] init];
        _transformLayer.bounds = CGRectMake(0, 0, 350, 350);
        _transformLayer.position = CGPointMake(175, 175);
//        _transformLayer.backgroundColor = [UIColor redColor].CGColor;
        
        [_transformLayer addSublayer:[self kd_layer:[UIColor redColor] zPosition:20]];
        [_transformLayer addSublayer:[self kd_layer:[UIColor greenColor] zPosition:40]];
        [_transformLayer addSublayer:[self kd_layer:[UIColor blueColor] zPosition:60]];
        
        CATransform3D perspective = CATransform3DIdentity;
        perspective.m34 = -1 / 100;
        _transformLayer.transform = CATransform3DRotate(perspective, 0.1, 0, 1, 0);
    }
    
    return _transformLayer;
}

- (CALayer *)kd_layer:(UIColor *)color zPosition:(CGFloat)zPosition {
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = CGRectMake(20, 20, 200, 200);
    layer.backgroundColor = color.CGColor;
    layer.zPosition = zPosition;
    layer.opacity = 0.5;
    
    return nil;
}

- (CAReplicatorLayer *)replicatorLayer {
    if (_replicatorLayer == nil) {
        _replicatorLayer = [[CAReplicatorLayer alloc] init];
    }
    return _replicatorLayer;
}

@end
