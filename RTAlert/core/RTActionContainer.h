//
//  RTActionContainer.h
//  RTAlert
//
//  Created by hc-jim on 2019/1/2.
//  Copyright © 2019 ENUUI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTActionItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface RTActionContainer : UITableView
+ (instancetype)actionContainerWithTitle:(NSString * __nullable)title withMessage:(NSString * __nullable)message withStyle:(RTAlertControllerStyle)style;

+ (instancetype)actionContainerWithAttributedTitle:(NSAttributedString * __nullable)attributedTitle withAttributedMessage:(NSAttributedString * __nullable)attributedMessage withStyle:(RTAlertControllerStyle)style;

- (void)addActionItems:(NSArray <RTActionItem *>*)actionItems;
- (void)sizeTVHeader;
@end

NS_ASSUME_NONNULL_END
