//
//  OffScreenRenderVC.m
//  kd_study
//
//  Created by hour on 2020/1/15.
//  Copyright © 2020 hour. All rights reserved.
//

#import "OffScreenRenderVC.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/UIImage+ForceDecode.h>



@interface CornerCell : UITableViewCell

@end

@implementation CornerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor purpleColor];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//        imgView.image = [UIImage imageNamed:@"login_btn_email_normal"];
//        imgView.image = [UIImage imageNamed:@"login_btn_email_normal_no_alpha"];
        imgView.image = [UIImage imageNamed:@"2"];
        imgView.layer.cornerRadius = 20;
        imgView.layer.masksToBounds = YES;
        imgView.backgroundColor = [UIColor whiteColor];
        imgView.layer.shouldRasterize = NO;
        [self.contentView addSubview:imgView];

        UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 0, 40, 40)];
//        imgView.image = [UIImage imageNamed:@"login_btn_email_normal"];
//        imgView.image = [UIImage imageNamed:@"login_btn_email_normal_no_alpha"];
        imgView1.image = [UIImage imageNamed:@"2"];
        imgView1.layer.cornerRadius = 20;
        imgView1.layer.masksToBounds = YES;
        imgView1.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:imgView1];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 30, 20)];
        label.text = @"123";
        label.backgroundColor = [UIColor whiteColor];
        label.alpha = 1;
        [self.contentView addSubview:label];
    }
    
    return self;
}


@end


@interface OffScreenRenderVC () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
}
@end

@implementation OffScreenRenderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] init];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass: CornerCell.class forCellReuseIdentifier:NSStringFromClass(CornerCell.class)];
}


#pragma mark - table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CornerCell.class)];
    
    return cell;
}

@end
