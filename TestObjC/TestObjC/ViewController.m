//
//  ViewController.m
//  TestObjC
//
//  Created by hour on 2018/11/29.
//  Copyright © 2018 hour. All rights reserved.
//

#import "ViewController.h"
#import "KDView.h"
#import "KDWrapperView.h"
#import "KDContainer.h"
#import "KDGraphicsView.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) KDWrapperView * _Nullable wrapperView;

@property (nonatomic, strong) KDView * _Nullable kdview;

@property (nonatomic, strong) KDContainer * _Nullable container;


@property (nonatomic, strong) KDGraphicsView * _Nullable grahpicsView;
@property (nonatomic, strong) UIImageView * _Nullable imgView;

@property (atomic, assign) NSInteger num;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.grahpicsView];
    [self.grahpicsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(100);
    }];
    
    self.grahpicsView.backgroundColor = UIColor.lightGrayColor;
    [self testBasic];
    
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [[UIColor yellowColor] CGColor];
    layer.frame =  CGRectMake(self.view.bounds.origin.x,
                              self.view.bounds.origin.y + 64, 100, 100);
    layer.contents = (id)[[UIImage imageNamed:@"widget_btn_card_normal"] CGImage];
    [[self.view layer] addSublayer:layer];
//    [layer setNeedsDisplay];
    
    /*
    [self.view addSubview:self.container];
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(0);
    }];
//    self.container.frame = CGRectMake(0, 0, 200, 200);
    NSLog(@"===1 container layoutSubviews %@", NSStringFromCGRect(self.container.frame));
    
    for (int i=0; i<1000; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @synchronized (self) {
                self.num ++;
            }
        });
    }
    
    [self.container addSubview:self.wrapperView];
    [self.wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.container);
        make.top.mas_equalTo(self.container).mas_offset(180);
    }];
    
    [self.wrapperView addSubview:self.kdview];
    [self.kdview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.wrapperView);
        make.top.mas_equalTo(self.wrapperView).mas_offset(10);
    }];
     */
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (KDView *)kdview {
    if (_kdview == nil) {
        _kdview = [[KDView alloc] initWithFrame:CGRectZero];
    }
    
    return _kdview;
}

- (KDWrapperView *)wrapperView {
    if (_wrapperView == nil) {
        _wrapperView = [[KDWrapperView alloc] init];
        _wrapperView.backgroundColor = [UIColor grayColor];
    }
    
    return _wrapperView;
}

- (KDContainer *)container {
    if (_container == nil) {
        _container = [[KDContainer alloc] initWithFrame:CGRectZero];
        _container.backgroundColor = [UIColor yellowColor];
    }
    
    return _container;
}

- (KDGraphicsView *)grahpicsView {
    if (_grahpicsView == nil) {
        _grahpicsView = [[KDGraphicsView alloc] init];
    }
    
    return _grahpicsView;
}

- (void)testBasic {
    self.imgView = [[UIImageView alloc] init];
    [self.view addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.view).mas_offset(-20);
        make.width.height.mas_equalTo(100);
    }];
    self.imgView.backgroundColor = UIColor.purpleColor;
//    self.imgView.image = [UIImage imageNamed:@"widget_btn_card_normal"];
//    self.imgView.contentMode = UIViewContentModeScaleToFill;
    
    self.imgView.layer.cornerRadius = 50.0f;
    self.imgView.clipsToBounds = YES;
//    self.imgView.layer.masksToBounds = true;
//    self.imgView.layer.maskedCorners = kCALayerMaxXMaxYCorner;
    
    
//    UIView *maskView = [[UIView alloc] init];
//    maskView.alpha = 0.5;
//    self.imgView.maskView = maskView;
    
    CALayer *maskLayer = [CALayer layer];
//    maskLayer.opacity = 1;
    maskLayer.backgroundColor = UIColor.redColor.CGColor;
    maskLayer.bounds = CGRectMake(0, 0, 10, 10);
    maskLayer.position = self.imgView.layer.position;
//    self.imgView.layer.mask = maskLayer;
    [self.imgView.layer addSublayer:maskLayer];
    
}

@end

@implementation MyClass

- (void)hello {
    NSLog(@"");
}

@end
