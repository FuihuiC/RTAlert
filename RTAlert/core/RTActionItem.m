//
//  RTActionItem.m
//  RTAlert
//
//  Created by hc-jim on 2019/1/2.
//  Copyright © 2019 ENUUI. All rights reserved.
//

#import "RTActionItem.h"

@implementation RTActionItem
+ (instancetype)actionWithTitle:(NSString *)title style:(RTAlertActionStyle)actionStyle handler:(RTActionItemHandler)handler {
    
    return [[RTActionItem alloc] initWithTitle:title style:actionStyle handler:handler];
}

+ (instancetype)actionWithAttributedTitle:(NSAttributedString *)attributedTitle style:(RTAlertActionStyle)actionStyle handler:(RTActionItemHandler)handler {
    return [[RTActionItem alloc] initWithAttributedTitle:attributedTitle style:actionStyle handler:handler];
}

+ (instancetype)actionWithActionView:(UIView *)actionView handler:(RTActionItemHandler)handler {
    return [[RTActionItem alloc] initWithActionView:actionView handler:handler];
}

- (instancetype)initWithTitle:(NSString *)title style:(RTAlertActionStyle)actionStyle handler:(RTActionItemHandler)handler {
    if (self = [super init]) {
        _actionTitle = title;
        _actionStyle = actionStyle;
        _handler = handler;
        
        UIFont *titleFont = nil;
        if (actionStyle == RTAlertActionStyleCancel) {
            titleFont = [UIFont fontWithName:@"PingFangSC-Medium" size:17.0];
        } else {
            titleFont = [UIFont systemFontOfSize:17.0];
        }
        NSDictionary *attributes = @{NSFontAttributeName: titleFont,
                                     NSForegroundColorAttributeName: [UIColor colorWithRed:57.0 / 255.0 green:121.0 / 255.0 blue:246.0 / 255.0 alpha:1.0]
                                     };
        
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attributes];
        _actionAttributedTitle = attributedTitle;
    }
    return self;
}

- (instancetype)initWithAttributedTitle:(NSAttributedString *)attributedTitle style:(RTAlertActionStyle)actionStyle handler:(RTActionItemHandler)handler {
    if (self = [super init]) {
        _actionStyle = actionStyle;
        _actionAttributedTitle = attributedTitle;
        _handler = handler;
    }
    return self;
}

- (instancetype)initWithActionView:(UIView *)actionView handler:(RTActionItemHandler)handler {
    if (self = [super init]) {
        _actionView = actionView;
        _handler = handler;
    }
    return self;
}
@end
