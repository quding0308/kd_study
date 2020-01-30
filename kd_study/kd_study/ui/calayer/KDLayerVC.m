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
    
//    [self testImageLoad1];
    [self testImageLoad2];
    
//    [self testBasicView1];
//    [self testBasicLayer0];
//    [self testBasicLayer1];
//    [self testBasicLayer2];
//    [self testShadowLayer];
//    [self testMaskLayer];
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

- (void)testBasicView1 {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:view];
    
    view.frame = CGRectMake(10, 10, 200, 200);
    view.center = CGPointMake(210, 210);
    view.bounds = CGRectMake(-10, -10, 300, 300);
    
    NSLog(@"frame: %@", NSStringFromCGRect(view.frame));
    NSLog(@"bounds: %@", NSStringFromCGRect(view.bounds));
    NSLog(@"center: %@", NSStringFromCGPoint(view.center));
}

- (void)testImageLoad1 {
    CALayer *layer = [CALayer layer];
    
    layer.position = CGPointMake(100, 100);
    layer.bounds = CGRectMake(0, 0, 10, 10);
    
    layer.backgroundColor = UIColor.lightGrayColor.CGColor;
    
    layer.borderColor = UIColor.blueColor.CGColor;
    layer.borderWidth = 2.0f;
    
    // contents 必须是 CGImage
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"3.jpg"].CGImage);
//    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"31.jpg"].CGImage);
//    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"3.png"].CGImage);

    // 从 contents 中裁剪内容
    layer.contentsRect = CGRectMake(0.4, 0.4, 0.4, 0.4);
    
    // content
    layer.contentsGravity = kCAGravityResize;
    layer.contentsScale = [UIScreen mainScreen].scale;
    
    [self.view.layer addSublayer:layer];
}

- (void)testImageLoad2 {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
//    imgView.image = [UIImage imageNamed:@"3.jpg"];
//    imgView.image = [UIImage imageNamed:@"31.jpg"];
//    imgView.image = [UIImage imageNamed:@"3.png"];
    imgView.image = [UIImage imageNamed:@"3-no-alpha.png"];

    [self.view addSubview:imgView];
}

- (void)testBasicLayer0 {
    CALayer *layer = [CALayer layer];
    
    layer.position = CGPointMake(100, 100);
    layer.bounds = CGRectMake(0, 0, 10, 10);
    
    layer.backgroundColor = UIColor.lightGrayColor.CGColor;
    
    layer.borderColor = UIColor.blueColor.CGColor;
    layer.borderWidth = 2.0f;
    
    // contents 必须是 CGImage
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"3.jpg"].CGImage);
    
    // 从 contents 中裁剪内容
    layer.contentsRect = CGRectMake(0.4, 0.4, 0.4, 0.4);
    
    // content
    layer.contentsGravity = kCAGravityResize;
    layer.contentsScale = [UIScreen mainScreen].scale;
    
    [self.view.layer addSublayer:layer];
}

- (void)testBasicLayer2 {
    CALayer *layerLarge = [CALayer layer];
    layerLarge.position = CGPointMake(100, 100);
    layerLarge.bounds = CGRectMake(0, 0, 300, 300);
    layerLarge.opacity = 0.9;
    layerLarge.backgroundColor = UIColor.whiteColor.CGColor;
    [self.view.layer addSublayer:layerLarge];
    
    // allowsGroupOpacity = YES 子 layer 的透明度不能超过 父 layer 的透明度
    layerLarge.allowsGroupOpacity = YES;
    
    CALayer *layerSmall = [CALayer layer];
    layerSmall.position = CGPointMake(150, 150);
    layerSmall.bounds = CGRectMake(0, 0, 100, 100);
    layerSmall.opacity = 0.9;
//    layerSmall.allowsGroupOpacity = YES;
    layerSmall.backgroundColor = UIColor.blueColor.CGColor;
    [layerLarge addSublayer:layerSmall];
}

- (void)testShadowLayer {
    CALayer *layer = [CALayer layer];
    
    layer.position = CGPointMake(200, 200);
    layer.bounds = CGRectMake(0, 0, 300, 300);
    
    layer.backgroundColor = UIColor.lightGrayColor.CGColor;
    
    layer.borderColor = UIColor.blueColor.CGColor;
    layer.borderWidth = 2.0f;
    
    // contents 必须是 CGImage
//    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"3"].CGImage);
    
    layer.shadowColor = UIColor.redColor.CGColor;
    layer.shadowOpacity = 0.8;
    layer.shadowRadius = 2.0;
    layer.shadowOffset = CGSizeMake(5, -5);
    
    // 注意 指定了 shadowPath 后，不在出现离屏渲染
//    layer.shadowPath = [UIBezierPath bezierPathWithRect:layer.bounds].CGPath;
    
    [self.view.layer addSublayer:layer];
}

- (void)testMaskLayer {
    CALayer *layer = [CALayer layer];
    
    layer.position = CGPointMake(200, 200);
    layer.bounds = CGRectMake(0, 0, 300, 300);
    
//    layer.backgroundColor = UIColor.lightGrayColor.CGColor;
    
    layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"3"].CGImage);

//    layer.borderColor = UIColor.blueColor.CGColor;
//    layer.borderWidth = 2.0f;
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRect:layer.bounds].CGPath;
    maskLayer.lineWidth = 3;
    maskLayer.strokeColor = UIColor.redColor.CGColor;
    maskLayer.fillColor = UIColor.yellowColor.CGColor;
    layer.mask = maskLayer;
    
    [self.view.layer addSublayer:layer];
}

- (void)testBasicLayer1 {
    //
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = UIColor.redColor.CGColor;
    
    //
    
//    layer.frame = CGRectMake(10, 10, 100, 100);
    
    // position 默认为 center ，相对于 anchorPosition 的偏移量
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    layer.position = CGPointMake(100, 100);
    layer.bounds = CGRectMake(0, 0, 120, 80);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

//        CFTimeInterval currentTime = CACurrentMediaTime();
//        CFTimeInterval currentTimeInLayer = [layer convertTime:currentTime fromLayer:nil];
//        CFTimeInterval addTime = currentTimeInLayer;
//        layer.beginTime = 0.3 + addTime;
//        [layer setTimeOffset:0.5];

        layer.speed = 0.5;
        layer.fillMode = kCAFillModeForwards;
//        layer.autoreverses = true;
        layer.anchorPoint = CGPointMake(0, 0);
    });
    
    // 以左上角为 anchorPoint
//    layer.anchorPoint = CGPointMake(0, 0);
//    layer.position = CGPointMake(0, 10);
//    layer.bounds = CGRectMake(0, 0, 120, 80);
    
    
    // 默认 (0.5, 0.5)
    // (0, 0) 左上角
    // (1, 1) 右下角
    // anchorPoint 使用比例值
    // Rotation 围绕 position 旋转，CALayer 用 anchorPoint 指定 position 在 bounds 中的位置
//    layer.anchorPoint = CGPointMake(1, 0);
    
    
    
    NSLog(@"anchorPoint: %@", NSStringFromCGPoint(layer.anchorPoint));
    NSLog(@"position: %@", NSStringFromCGPoint(layer.position));
    NSLog(@"bounds: %@", NSStringFromCGRect(layer.bounds));
    NSLog(@"frame: %@", NSStringFromCGRect(layer.frame));

    [self.view.layer addSublayer:layer];
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
