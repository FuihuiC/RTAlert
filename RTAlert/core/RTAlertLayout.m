//
//  RTAlertLayout.m
//  RTAlert
//
//  Created by hc-jim on 2019/1/2.
//  Copyright © 2019 ENUUI. All rights reserved.
//

#import "RTAlertLayout.h"

NSLayoutConstraint *RTAlertLayoutWidth(UIView *item, UIView *toItem, CGFloat constant) {
    return [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeWidth multiplier:1.0 constant:constant];
}

NSLayoutConstraint *RTAlertLayoutHeight(UIView *item, UIView *toItem, CGFloat constant) {
    return [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeHeight multiplier:1.0 constant:constant];
}

NSLayoutConstraint *RTAlertLayoutTop(UIView *item, UIView *toItem, CGFloat constant) {
    return [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeTop multiplier:1.0 constant:constant];
}

NSLayoutConstraint *RTAlertLayoutBottom(UIView *item, UIView *toItem, CGFloat constant) {
    return [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeBottom multiplier:1.0 constant:constant];
}

NSLayoutConstraint *RTAlertLayoutLeft(UIView *item, UIView *toItem, CGFloat constant) {
    return [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeLeft multiplier:1.0 constant:constant];
}

NSLayoutConstraint *RTAlertLayoutRight(UIView *item, UIView *toItem, CGFloat constant) {
    return [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeRight multiplier:1.0 constant:constant];
}

NSLayoutConstraint *RTAlertLayoutTopToBottom(UIView *item, UIView *toItem, CGFloat constant) {
    return [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeBottom multiplier:1.0 constant:constant];
}

NSLayoutConstraint *RTAlertLayoutBottomToTop(UIView *item, UIView *toItem, CGFloat constant) {
    return [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeTop multiplier:1.0 constant:constant];
}

NSLayoutConstraint *RTAlertLayoutLeftToRight(UIView *item, UIView *toItem, CGFloat constant) {
    return [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeRight multiplier:1.0 constant:constant];
}

NSLayoutConstraint *RTAlertLayoutRightToLeft(UIView *item, UIView *toItem, CGFloat constant) {
    return [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeLeft multiplier:1.0 constant:constant];
}

NSLayoutConstraint *RTAlertLayoutCenterX(UIView *item, UIView *toItem, CGFloat constant) {
    return [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:constant];
}

NSLayoutConstraint *RTAlertLayoutCenterY(UIView *item, UIView *toItem, CGFloat constant) {
    return [NSLayoutConstraint constraintWithItem:item attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:toItem attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:constant];
}

void RTAlertLayoutEdge(UIView *item, UIView *toItem, CGFloat constant) {
    NSLayoutConstraint *left = RTAlertLayoutLeft(item, toItem, constant);
    NSLayoutConstraint *right = RTAlertLayoutRight(item, toItem, -constant);
    NSLayoutConstraint *top = RTAlertLayoutTop(item, toItem, constant);
    NSLayoutConstraint *bottom = RTAlertLayoutBottom(item, toItem, -constant);
    
    item.translatesAutoresizingMaskIntoConstraints = NO;
    
    [toItem addConstraints:@[left, right, top, bottom]];
}
