//
//  RTAlertLayout.h
//  RTAlert
//
//  Created by hc-jim on 2019/1/2.
//  Copyright © 2019 ENUUI. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RT_ALERT_SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define RT_ALERT_WIDTH (MIN(RT_ALERT_SCREEN_SIZE.width, RT_ALERT_SCREEN_SIZE.height) * 0.7)
#define RT_SHEET_WIDTH (MIN(RT_ALERT_SCREEN_SIZE.width, RT_ALERT_SCREEN_SIZE.height) * 0.9)


UIKIT_EXTERN NSLayoutConstraint *RTAlertLayoutWidth(UIView *item, UIView *toItem, CGFloat constant);
UIKIT_EXTERN NSLayoutConstraint *RTAlertLayoutHeight(UIView *item, UIView *toItem, CGFloat constant);

UIKIT_EXTERN NSLayoutConstraint *RTAlertLayoutTop(UIView *item, UIView *toItem, CGFloat constant);
UIKIT_EXTERN NSLayoutConstraint *RTAlertLayoutBottom(UIView *item, UIView *toItem, CGFloat constant);
UIKIT_EXTERN NSLayoutConstraint *RTAlertLayoutLeft(UIView *item, UIView *toItem, CGFloat constant);
UIKIT_EXTERN NSLayoutConstraint *RTAlertLayoutRight(UIView *item, UIView *toItem, CGFloat constant);

UIKIT_EXTERN NSLayoutConstraint *RTAlertLayoutTopToBottom(UIView *item, UIView *toItem, CGFloat constant);
UIKIT_EXTERN NSLayoutConstraint *RTAlertLayoutBottomToTop(UIView *item, UIView *toItem, CGFloat constant);
UIKIT_EXTERN NSLayoutConstraint *RTAlertLayoutLeftToRight(UIView *item, UIView *toItem, CGFloat constant);
UIKIT_EXTERN NSLayoutConstraint *RTAlertLayoutRightToLeft(UIView *item, UIView *toItem, CGFloat constant);

UIKIT_EXTERN NSLayoutConstraint *RTAlertLayoutCenterX(UIView *item, UIView *toItem, CGFloat constant);
UIKIT_EXTERN NSLayoutConstraint *RTAlertLayoutCenterY(UIView *item, UIView *toItem, CGFloat constant);

UIKIT_EXTERN void RTAlertLayoutEdge(UIView *item, UIView *toItem, CGFloat constant);
