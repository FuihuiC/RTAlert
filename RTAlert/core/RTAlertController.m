//
//  RTAlertController.m
//  RTAlert
//
//  Created by hc-jim on 2019/1/2.
//  Copyright © 2019 ENUUI. All rights reserved.
//

#import "RTAlertController.h"
#import "RTActionContainer.h"
#import "RTAlertLayout.h"


@interface RTAlertController () {
    RTAlertControllerStyle _style;
    UIView *_actionSheetAnimationView;
    
    NSMutableArray <RTActionItem *>*_mActionItems;
}
@property (nonatomic, strong) RTActionContainer *actionContainer;
@property (nonatomic, strong) NSLayoutConstraint *containerHeight;
@end

@implementation RTAlertController

+ (instancetype)alertControllerWithTitle:(NSString *)title withMessage:(NSString *)message withStyle:(RTAlertControllerStyle)style {
    RTActionContainer *container = [RTActionContainer actionContainerWithTitle:title withMessage:message withStyle:style];
    
    return [self alertControllerWithActionView:container withStyle:style];;
}

+ (instancetype)alertControllerWithAttributedTitle:(NSAttributedString *)attributedTitle withAttributedMessage:(NSAttributedString *)attributedMessage withStyle:(RTAlertControllerStyle)style {
    
    RTActionContainer *container = [RTActionContainer actionContainerWithAttributedTitle:attributedTitle withAttributedMessage:attributedMessage withStyle:style];
    
    return [self alertControllerWithActionView:container withStyle:style];
}

+ (instancetype)alertControllerWithActionView:(UIView *)actionView withStyle:(RTAlertControllerStyle)style {
    
    RTAlertController *alertController = [RTAlertController new];
    alertController->_style = style;
    if ([actionView isKindOfClass:[RTActionContainer class]]) {
        alertController.actionContainer = (RTActionContainer *)actionView;
    }
    [alertController addActionContainer:actionView];
    return alertController;
}

// 
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self didInitialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize {
    _mActionItems = [NSMutableArray <RTActionItem *> array];
    self.touchOut = YES;
    
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.view.backgroundColor =  [UIColor colorWithWhite:.2 alpha:.55];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (_touchOut) {
        [self exitAlert];
    } else {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)exitAlert {
    if (_actionContainer) {
        [_actionContainer removeObserver:self forKeyPath:@"contentSize"];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_actionContainer) {
        [_actionContainer addActionItems:_mActionItems.copy];
    }
    
    if (_style == RTAlertControllerStyleActionSheet) {

        _actionSheetAnimationView.frame = (CGRect){0, RT_ALERT_SCREEN_SIZE.height, RT_ALERT_SCREEN_SIZE};
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self->_actionSheetAnimationView.frame = (CGRect){0, 0, RT_ALERT_SCREEN_SIZE};
        } completion:nil];
    }
}

- (void)setActionContainer:(RTActionContainer *)actionContainer {
    _actionContainer = actionContainer;
    
    [_actionContainer addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        
        CGFloat height = [change[NSKeyValueChangeNewKey] CGSizeValue].height;
        if (height > RT_ALERT_SCREEN_SIZE.height * 0.8) {
            height = RT_ALERT_SCREEN_SIZE.height * 0.8;
            _actionContainer.scrollEnabled = YES;
        } else {
            _actionContainer.scrollEnabled = NO;
        }
        _containerHeight.constant = height;
    }
}

- (void)addActionContainer:(UIView *)container {
    container.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (_style == RTAlertControllerStyleAlert) {
        [self layoutAlertContainer:container];
    } else {
        [self layoutActionSheetContainer:container];
    }
}

- (void)layoutAlertContainer:(UIView *)container {
    [self.view addSubview:container];
    
    NSLayoutConstraint *containerCenterX = RTAlertLayoutCenterX(container, self.view, 0.0);
    NSLayoutConstraint *containerCenterY = RTAlertLayoutCenterY(container, self.view, 0.0);

    NSLayoutConstraint *containerWidth = RTAlertLayoutWidth(container, nil, RT_ALERT_WIDTH);
    _containerHeight = RTAlertLayoutHeight(container, nil, 1.0);
    
    [self.view addConstraints:@[containerCenterX, containerCenterY, containerWidth, _containerHeight]];
}

- (void)layoutActionSheetContainer:(UIView *)container {
    
    _actionSheetAnimationView = [[UIView alloc] init];
    [self.view addSubview:_actionSheetAnimationView];

    [_actionSheetAnimationView addSubview:container];

    NSLayoutConstraint *containerCenterX = RTAlertLayoutCenterX(container, _actionSheetAnimationView, 0.0);
    NSLayoutConstraint *containerWidth = RTAlertLayoutWidth(container, nil, RT_SHEET_WIDTH);
    _containerHeight = RTAlertLayoutHeight(container, nil, 1.0);
    if (@available(iOS 11.0, *)) {
        [container.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-8.0].active = YES;
    } else {
        NSLayoutConstraint *containerBottom = RTAlertLayoutBottom(container, _actionSheetAnimationView, 8.0);
        [_actionSheetAnimationView addConstraint:containerBottom];
    }
    
    [_actionSheetAnimationView addConstraints:@[containerCenterX, containerWidth, _containerHeight]];
}

- (void)addActionItem:(RTActionItem *)actionItem {
    
    if (actionItem.actionStyle == RTAlertActionStyleCancel) {
        [self addActionCancelItem:actionItem];
    } else {
        [_mActionItems addObject:actionItem];
    }
}

- (void)addActionCancelItem:(RTActionItem *)actionItem {
    if (_mActionItems.count) {
        NSAssert(actionItem.actionStyle != _mActionItems[0].actionStyle && actionItem.actionStyle != RTAlertActionStyleCancel, @"RTAlertController can only have one action with a style of RTAlertActionStyleCancel!");
        
        [_mActionItems insertObject:actionItem atIndex:0];
    } else {
        [_mActionItems addObject:actionItem];
    }
}

- (BOOL)shouldAutorotate {
    BOOL re = [super shouldAutorotate];
    if (re && _actionContainer) {
        [_actionContainer sizeTVHeader];
    }
    if (re && _actionSheetAnimationView) {
        _actionSheetAnimationView.frame = (CGRect){0, 0, RT_ALERT_SCREEN_SIZE};
    }
    return re;
}

@end
