//
//  VerticalCenterTextLabel.h
//  kd_study
//
//  Created by hour on 2020/1/20.
//  Copyright © 2020 hour. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    myVerticalAlignmentNone = 0,
    myVerticalAlignmentCenter,
    myVerticalAlignmentTop,
    myVerticalAlignmentBottom
} myVerticalAlignment;
 
NS_ASSUME_NONNULL_BEGIN

@interface VerticalCenterTextLabel : UILabel

@property (nonatomic) UIEdgeInsets edgeInsets;
 
/**
 *  对齐方式
 */
@property (nonatomic) myVerticalAlignment verticalAlignment;
 
@end

NS_ASSUME_NONNULL_END

 
