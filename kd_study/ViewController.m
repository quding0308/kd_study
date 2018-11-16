//
//  ViewController.m
//  kd_study
//
//  Created by hour on 2018/8/14.
//  Copyright © 2018 hour. All rights reserved.
//

#import "ViewController.h"

#import <Masonry/Masonry.h>

#import "kd_study-Swift.h"

#import "DispatchTest.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [[[Hello alloc] init] hello];
//
//    [DispatchTest test];
//
//    self.view.backgroundColor = UIColor.lightGrayColor;
//    [self.view addSubview:self.imgView];
//    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view).mas_offset(40);
//        make.left.mas_equalTo(self.view);
//        make.right.mas_equalTo(self.view).mas_offset(0);
//        make.height.mas_equalTo(300);
//    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIResponder *responder = [self nextResponder];
    
    NSLog(@"111");
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2.png"]];
        _imgView.clipsToBounds = YES;
        
//        _imgView.contentMode = UIViewContentModeTop;
        _imgView.contentMode = UIViewContentModeRedraw;
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



@end
