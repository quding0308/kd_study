//
//  AttrStrVC.m
//  kd_study
//
//  Created by hour on 2020/1/20.
//  Copyright © 2020 hour. All rights reserved.
//

#import "AttrStrVC.h"
#import "VerticalCenterTextLabel.h"

@interface AttrStrVC ()

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) VerticalCenterTextLabel *verticalLabel;

@end

@implementation AttrStrVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.lightGrayColor;
    
    [self test0];
//    [self test1];
//    [self test2];
//    [self test3];
}

- (void)test0 {
    [self.view addSubview:self.verticalLabel];
    self.verticalLabel.frame = CGRectMake(10, 100, 300, 300);

    
    NSDictionary *attr = @{
        NSForegroundColorAttributeName: UIColor.whiteColor,
        NSFontAttributeName: [UIFont systemFontOfSize:25],
        NSKernAttributeName: @(5.0f),   // 字间距
        NSBackgroundColorAttributeName: UIColor.redColor,
//        NSShadowAttributeName: shadow
//        NSUnderlineStyleAttributeName: @(5),
//        NSStrikethroughStyleAttributeName: @(5)
        
    };
    
//    self.label.attributedText = [[NSAttributedString alloc] initWithString:@"NSFontAttributeName(字体)该属性所对应的值是一个 UIFont 对象。该属性用于改变一段文本的字体。如果不指定该属性，则默认为12-point Helvetica(Neue)。" attributes:attr];
    
    self.verticalLabel.text = @"12345";
    self.verticalLabel.verticalAlignment = myVerticalAlignmentBottom;
}

- (void)test1 {
    [self.view addSubview:self.label];
    self.label.frame = CGRectMake(10, 100, 300, 300);

    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blueColor];
    shadow.shadowOffset = CGSizeMake(1, 1);
    shadow.shadowBlurRadius = 5;
    
    
    
    NSDictionary *attr = @{
        NSForegroundColorAttributeName: UIColor.whiteColor,
        NSFontAttributeName: [UIFont systemFontOfSize:25],
        NSKernAttributeName: @(5.0f),   // 字间距
//        NSBackgroundColorAttributeName: UIColor.redColor,
//        NSShadowAttributeName: shadow
//        NSUnderlineStyleAttributeName: @(5),
//        NSStrikethroughStyleAttributeName: @(5)
        
    };
    
    self.label.attributedText = [[NSAttributedString alloc] initWithString:@"NSFontAttributeName(字体)该属性所对应的值是一个 UIFont 对象。该属性用于改变一段文本的字体。如果不指定该属性，则默认为12-point Helvetica(Neue)。" attributes:attr];
    
//    self.label.text = @"12345";
}

- (void)test2 {
    [self.view addSubview:self.label];
    self.label.frame = CGRectMake(10, 100, 300, 300);

    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blueColor];
    shadow.shadowOffset = CGSizeMake(1, 1);
    shadow.shadowBlurRadius = 5;
    
    
    
    NSDictionary *attr = @{
        NSForegroundColorAttributeName: UIColor.whiteColor,
        NSFontAttributeName: [UIFont systemFontOfSize:25],
        NSKernAttributeName: @(5.0f),   // 字间距
//        NSBackgroundColorAttributeName: UIColor.redColor,
//        NSShadowAttributeName: shadow
//        NSUnderlineStyleAttributeName: @(5),
//        NSStrikethroughStyleAttributeName: @(5)
        
        NSStrokeColorAttributeName: UIColor.blueColor,
        NSStrokeWidthAttributeName: @(2)
        
    };
    
    self.label.attributedText = [[NSAttributedString alloc] initWithString:@"NSFontAttributeName(字体)该属性所对应的值是一个 UIFont 对象。该属性用于改变一段文本的字体。如果不指定该属性，则默认为12-point Helvetica(Neue)。" attributes:attr];
}

- (void)test3 {
    [self.view addSubview:self.label];
    self.label.frame = CGRectMake(10, 100, 300, 300);

    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    
    paragraph.lineSpacing = 5;
    paragraph.paragraphSpacing = 0;
    paragraph.paragraphSpacingBefore = 10;
    
    paragraph.alignment = NSTextAlignmentLeft; // 水平对齐
    
    
    paragraph.firstLineHeadIndent = 0;
    paragraph.headIndent = 10;
    
    paragraph.baseWritingDirection = NSWritingDirectionEmbedding;
    
    // 连接符
//    paragraph.hyphenationFactor
    
    NSDictionary *attr = @{
        NSForegroundColorAttributeName: UIColor.whiteColor,
        NSBackgroundColorAttributeName: UIColor.redColor,
        
        NSFontAttributeName: [UIFont systemFontOfSize:15],
        NSKernAttributeName: @(5.0f),   // 字间距
        NSParagraphStyleAttributeName: paragraph
    };
    
    self.label.attributedText = [[NSAttributedString alloc] initWithString:@"【NSFontAttributeName(字体)该属性所对应的值是一个 UIFont 对象。该属性用于改变一段文本的字体。\n该属性所对应的值是一个 UIFont\n该属性所对应的值是一个 UIFont" attributes:attr];
}

- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.numberOfLines = 0;
        _label.backgroundColor = UIColor.darkGrayColor;
    }
    
    return _label;
}

- (VerticalCenterTextLabel *)verticalLabel {
    if (_verticalLabel == nil) {
        _verticalLabel = [[VerticalCenterTextLabel alloc] init];
        _verticalLabel.backgroundColor = UIColor.yellowColor;
    }
    
    return _verticalLabel;
}

@end
