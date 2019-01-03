//
//  RTAlertController.h
//  RTAlert
//
//  Created by hc-jim on 2019/1/2.
//  Copyright © 2019 ENUUI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTActionItem.h"


NS_ASSUME_NONNULL_BEGIN


@interface RTAlertController : UIViewController

/** 是否可点击灰色区域退出, YES: 点击灰色区域退出. 默认为 YES */
@property (nonatomic, assign) BOOL touchOut;

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title withMessage:(nullable NSString *)message withStyle:(RTAlertControllerStyle)style;

+ (instancetype)alertControllerWithAttributedTitle:(nullable NSAttributedString *)attributedTitle withAttributedMessage:(nullable NSAttributedString *)attributedMessage withStyle:(RTAlertControllerStyle)style;

+ (instancetype)alertControllerWithActionView:(UIView *)actionView withStyle:(RTAlertControllerStyle)style;

- (void)addActionItem:(RTActionItem *)actionItem;

- (void)addActionCancelItem:(RTActionItem *)actionItem;
@end

NS_ASSUME_NONNULL_END
