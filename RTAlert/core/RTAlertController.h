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


/**
 Creates and returns a view controller for displaying an alert to the user.
 
 @discussion After creating the alert controller, configure any actions that you want the user to be able to perform by calling the addActionItem: method one or more times. When specifying a preferred style of RTAlertControllerStyle, you may also configure one or more text fields to display in addition to the actions.
 @param title The title of the alert. Use this string to get the user’s attention and communicate the reason for the alert.
 @param message Descriptive text that provides additional details about the reason for the alert.
 @param style The style to use when presenting the alert controller. Use this parameter to configure the alert controller as an action sheet or as a modal alert.
 @return An initialized alert controller object.
 */
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title withMessage:(nullable NSString *)message withStyle:(RTAlertControllerStyle)style;

/**
 Creates and returns a view controller for displaying an alert to the user.
 
 @discussion After creating the alert controller, configure any actions that you want the user to be able to perform by calling the addActionItem: method one or more times. When specifying a preferred style of RTAlertControllerStyle, you may also configure one or more text fields to display in addition to the actions.
 @param attributedTitle The title of the alert. Use this attributed string to get the user’s attention and communicate the reason for the alert.
 @param attributedMessage Descriptive text that provides additional details about the reason for the alert.
 @param style The style to use when presenting the alert controller. Use this parameter to configure the alert controller as an action sheet or as a modal alert.
 @return An initialized alert controller object.
 */
+ (instancetype)alertControllerWithAttributedTitle:(nullable NSAttributedString *)attributedTitle withAttributedMessage:(nullable NSAttributedString *)attributedMessage withStyle:(RTAlertControllerStyle)style;

/**
 Creates and returns a view controller for displaying an alert to the user.
 
 @discussion After creating the alert controller, configure any actions that you want the user to be able to perform by calling the addActionItem: method one or more times. When specifying a preferred style of RTAlertControllerStyle, you may also configure one or more text fields to display in addition to the actions.
 @param actionView Custom view for alert.
 @param style The style to use when presenting the alert controller. Use this parameter to configure the alert controller as an action sheet or as a modal alert.
 @return An initialized alert controller object.
 */
+ (instancetype)alertControllerWithActionView:(UIView *)actionView withStyle:(RTAlertControllerStyle)style;

/**
 Attaches an action object to the alert or action sheet.
 @discussion If your alert has multiple actions, the order in which you add those actions determines their order in the resulting alert or action sheet.
 @param actionItem The action object to display as part of the alert. Actions are displayed as cells in the alert. The action object provides the cell text and the action to be performed when that cell is tapped.
 */
- (void)addActionItem:(RTActionItem *)actionItem;
@end
NS_ASSUME_NONNULL_END
