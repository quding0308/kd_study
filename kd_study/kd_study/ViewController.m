//
//  ViewController.m
//  kd_study
//
//  Created by hour on 2018/8/14.
//  Copyright © 2018 hour. All rights reserved.
//

#import "ViewController.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/UIImage+ForceDecode.h>

#import "kd_study-Swift.h"

#import "DispatchTest.h"

#import "RuntimeDemo.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) NSTextStorage *textStorage;



@property (nonatomic, strong) CALayer *layer1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [[[Hello alloc] init] hello];
//
//    [DispatchTest test];

    self.view.backgroundColor = UIColor.lightGrayColor;
    
    self.layer1 = [[CALayer alloc] init];
    self.layer1.backgroundColor = UIColor.redColor.CGColor;
    self.layer1.bounds = CGRectMake(0, 0, 300, 300);
    
    
    [self.view.layer addSublayer:self.layer1];
    
//    [self testImageLoad];
//    [self testTextView];
    
    [RuntimeDemo test];
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"=1== %@", [NSThread currentThread]);
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiTask:) name:UIApplicationDidBecomeActiveNotification object:nil];
//    });
}

- (void)testImageLoad {
    [self.view addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(40);
        make.left.mas_equalTo(self.view);
        
        make.width.height.mas_equalTo(300);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        UIImage *img = [UIImage imageNamed:@"3"];
        UIImage *img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"3" ofType:@"png"]];

                img = [UIImage decodedImageWithImage:img];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.imgView.image = img;
        });
    });
}

- (void)testTextView {
    CGRect textViewRect = CGRectInset(self.view.bounds, 10.0, 20.0);
    
    // NSTextContainer
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:CGSizeMake(10, CGFLOAT_MAX)];
//    container.widthTracksTextView = YES;
    
    // NSLayoutManager
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [layoutManager addTextContainer:container];
    
    // NSTextStorage
    self.textStorage = [[NSTextStorage alloc] init];
    [self.textStorage addLayoutManager:layoutManager];
    
    // UITextView
    UITextView *newTextView = [[UITextView alloc] initWithFrame:textViewRect textContainer:container];
    newTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    newTextView.scrollEnabled = YES;
    newTextView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.textView = newTextView;
    [self.view addSubview:self.textView];
    
    [self.textStorage beginEditing];
    
    NSMutableAttributedString *mutableAttrString = [[NSMutableAttributedString alloc] initWithString:@"Letterpress" attributes:@{NSTextEffectAttributeName: NSTextEffectLetterpressStyle}];
    [mutableAttrString appendAttributedString:[[NSAttributedString alloc] initWithString:@" \n 234"]];
    [mutableAttrString appendAttributedString:[[NSAttributedString alloc] initWithString:@" \n 567"]];
    
    [self.textStorage setAttributedString:mutableAttrString];
    
    [self.textStorage endEditing];
}

- (void)notiTask:(NSNotification *)not {
    NSLog(@"=== %@", [NSThread currentThread]);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIResponder *responder = [self nextResponder];
    
    NSLog(@"111");
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
//        _imgView.clipsToBounds = YES;
//        _imgView.image = [UIImage imageNamed:@"2"];
        
        UIImage *img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"2" ofType:@"png"]];
        _imgView.image = img;
        
//        _imgView.contentMode = UIViewContentModeTop;
//        _imgView.contentMode = UIViewContentModeRedraw;
    }
    
    return _imgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    NSLog(@"");
    
    return YES;
}

- (void)cut:(id)sender {
    NSLog(@"");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *arrayTouch = [touches allObjects];
    UITouch *touch = (UITouch *)[arrayTouch lastObject];
    CGFloat force = touch.force;
    NSLog(@"压力值为 %f",force);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    // 事物可以嵌套
    [CATransaction begin];
    self.layer1.zPosition = 200.0;
    [CATransaction setValue:@(1.0) forKey:kCATransactionAnimationDuration];
    
    [CATransaction begin];
//    [CATransaction setValue:@(NO) forKey:kCATransactionDisableActions];
    [CATransaction setValue:@(3.0) forKey:kCATransactionAnimationDuration];
    self.layer1.opacity = 0.0;
    
    [CATransaction commit];
    [CATransaction commit];
}

@end
