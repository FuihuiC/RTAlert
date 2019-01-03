//
//  RTActionItem.h
//  RTAlert
//
//  Created by hc-jim on 2019/1/2.
//  Copyright © 2019 ENUUI. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RTAlertControllerStyle) {
    RTAlertControllerStyleActionSheet = 0,
    RTAlertControllerStyleAlert
};

typedef NS_ENUM(NSInteger, RTAlertActionStyle) {
    RTAlertActionStyleDefault = 0,
    RTAlertActionStyleCancel,
};

typedef void(^__nullable RTActionItemHandler)(void);


@interface RTActionItem : NSObject

+ (instancetype)actionWithTitle:(NSString *)title style:(RTAlertActionStyle)actionStyle handler:(RTActionItemHandler)handler;

+ (instancetype)actionWithAttributedTitle:(NSAttributedString *)attributedTitle style:(RTAlertActionStyle)actionStyle handler:(RTActionItemHandler)handler;

+ (instancetype)actionWithActionView:(UIView *)actionView handler:(RTActionItemHandler)handler;



@property (nonatomic, copy, readonly) NSString *actionTitle;
@property (nonatomic, strong, readonly) NSAttributedString *actionAttributedTitle;

@property (nonatomic, assign, readonly) RTAlertActionStyle actionStyle;

@property (nonatomic, strong, readonly) UIView *actionView;

@property (nonatomic, copy, readonly) RTActionItemHandler handler;
@end

