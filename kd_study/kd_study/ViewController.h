//
//  ViewController.h
//  kd_study
//
//  Created by hour on 2018/8/14.
//  Copyright © 2018 hour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end


typedef NS_ENUM(NSInteger, KDHomeModelType) {
    KDHomeModelCALayer = 0,  //
    KDHomeModelAnimation,  // 
    KDHomeModelAgreement,  // 用户协议
    KDHomeModelLog // 上传日志
};

@class KDHomeRowModel;

@interface KDHomeSectionModel: NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray<KDHomeRowModel *> *rowModels;

- (instancetype)initWithTitle:(NSString *)title rowModels:(NSArray<KDHomeRowModel *> *)models;

@end

@interface KDHomeRowModel: NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) KDHomeModelType type;

- (instancetype)initWithType:(KDHomeModelType)type title:(NSString *)title;

@end


