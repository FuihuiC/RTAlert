//
//  RTActionContainer.m
//  RTAlert
//
//  Created by hc-jim on 2019/1/2.
//  Copyright © 2019 ENUUI. All rights reserved.
//

#import "RTActionContainer.h"
#import "RTAlertLayout.h"

static CAShapeLayer *RTLayerCorners(UIRectCorner corners, CGRect frame) {
    CGFloat radius = 10; // 圆角大小
    
    UIRectCorner corner = corners; // 圆角位置，全部位置
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = frame;
    maskLayer.path = path.CGPath;
    
    return maskLayer;
}


@interface RTAlertActionCell : UITableViewCell

@property (nonatomic, strong) RTActionItem *item;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, assign) BOOL hasCorner;
@end

@implementation RTAlertActionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)bottomCorner {
    UIRectCorner corner = UIRectCornerAllCorners;
    
    self.layer.mask = RTLayerCorners(corner, self.contentView.frame);
}

- (void)bottomTopCorner {
    if (_hasCorner) {
        return;
    }
    _hasCorner = YES;
    UIRectCorner corner = UIRectCornerBottomLeft | UIRectCornerBottomRight; // 圆角位置，全部位置
    
    self.layer.mask = RTLayerCorners(corner, self.contentView.frame);
}

- (void)setupUI {
    _lblTitle = [[UILabel alloc] init];
    _lblTitle.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_lblTitle];
    
    RTAlertLayoutEdge(_lblTitle, self.contentView, 0.0);
}

- (void)setItem:(RTActionItem *)item {
    _item = item;
    
    _lblTitle.attributedText = item.actionAttributedTitle;
}

@end


@interface RTAlertButton : UIButton

@property (nonatomic, strong) RTActionItem *item;

@end

@implementation RTAlertButton

- (void)setItem:(RTActionItem *)item {
    _item = item;
    
self.backgroundColor = [UIColor whiteColor];
    
    [self setAttributedTitle:item.actionAttributedTitle forState:UIControlStateNormal];
    
    if (item.handler) {
        [self addTarget:self action:@selector(clickedAtItem:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)clickedAtItem:(UIButton *)sender {
    self.item.handler();
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end


#define RT_WIDTH ((_style == RTAlertControllerStyleAlert) ? RT_ALERT_WIDTH : RT_SHEET_WIDTH)

@interface RTActionContainer () <UITableViewDelegate, UITableViewDataSource> {
    
    NSAttributedString *_attributedContent;
    RTAlertControllerStyle _style;
}
@property (nonatomic, strong) UIView *headerArea;
@property (nonatomic, strong) UITextView *tvHeaderContent;
@property (nonatomic, strong) UIView *alertButtonArea;


@property (nonatomic, strong) NSArray <RTActionItem *>*actionItems;
@end

static NSDictionary *RTActionContaiberTitleAttributes(RTAlertControllerStyle style) {
    NSMutableParagraphStyle *mParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    mParagraphStyle.alignment = NSTextAlignmentCenter;
    if (style == RTAlertControllerStyleActionSheet) {
        return @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:12.0],
                 NSForegroundColorAttributeName: [UIColor darkGrayColor],
                 NSParagraphStyleAttributeName: mParagraphStyle
                 };
    } else {
        return @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:17.0],
                 NSForegroundColorAttributeName: [UIColor blackColor],
                 NSParagraphStyleAttributeName: mParagraphStyle
                 };
    }
}

static NSDictionary *RTActionContaiberMessageAttributes(RTAlertControllerStyle style) {
    NSMutableParagraphStyle *mParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    mParagraphStyle.alignment = NSTextAlignmentCenter;
    
    if (style == RTAlertControllerStyleActionSheet) {
        return @{NSFontAttributeName: [UIFont systemFontOfSize:12.0],
                 NSForegroundColorAttributeName: [UIColor grayColor],
                 NSParagraphStyleAttributeName: mParagraphStyle
                 };
    } else {
        return @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                 NSForegroundColorAttributeName: [UIColor blackColor],
                 NSParagraphStyleAttributeName: mParagraphStyle
                 };
    }
}

@implementation RTActionContainer

+ (instancetype)actionContainerWithTitle:(NSString * __nullable)title withMessage:(NSString * __nullable)message withStyle:(RTAlertControllerStyle)style {
    NSMutableAttributedString *mAttributedContent = [[NSMutableAttributedString alloc] init];
    
    if (title) {
        [mAttributedContent appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:RTActionContaiberTitleAttributes(style)]];
        [mAttributedContent appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    }
    
    if (message) {
        [mAttributedContent appendAttributedString:[[NSAttributedString alloc] initWithString:message attributes:RTActionContaiberMessageAttributes(style)]];
    }

    return [[RTActionContainer alloc] initWithAttributedContent:mAttributedContent.copy withStyle:style];;
}

+ (instancetype)actionContainerWithAttributedTitle:(NSAttributedString * __nullable)attributedTitle withAttributedMessage:(NSAttributedString * __nullable)attributedMessage withStyle:(RTAlertControllerStyle)style {
    
    NSMutableAttributedString *mAttributedContent = [[NSMutableAttributedString alloc] init];
    
    if (attributedTitle) {
        [mAttributedContent appendAttributedString:attributedTitle];
        [mAttributedContent appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    }
    
    if (attributedMessage) {
        [mAttributedContent appendAttributedString:attributedMessage];
    }
    
    return [[RTActionContainer alloc] initWithAttributedContent:mAttributedContent.copy withStyle:style];
}

#pragma mark -

- (instancetype)initWithAttributedContent:(NSAttributedString * __nullable)attributedContent withStyle:(RTAlertControllerStyle)style {
    if (self = [super initWithFrame:CGRectZero style:UITableViewStyleGrouped]) {
        _style = style;
        _attributedContent = attributedContent;
        
        self.scrollEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.dataSource = self;
        self.delegate = self;
        self.tableHeaderView = [self header];
        
        [self registerClass:[RTAlertActionCell class] forCellReuseIdentifier:@"rt.alert.action.cell.id"];
       
        [self setupCorner];
        [self setupHeader];
    }
    return self;
}

#pragma mark -

- (void)setupCorner {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10.0;
}

- (void)setupHeader {
    if (_attributedContent && _attributedContent.length > 0) {
        
        self.tvHeaderContent.attributedText = _attributedContent;
        [self sizeTVHeader];
    }
}

- (void)sizeTVHeader {
    if (_tvHeaderContent == nil) {
        return;
    }
    
    CGSize textSize = [self.tvHeaderContent sizeThatFits:CGSizeMake(RT_WIDTH - 40.0, CGFLOAT_MAX)];
    if (textSize.height > RT_ALERT_SCREEN_SIZE.height * 0.4) {
        textSize.height = RT_ALERT_SCREEN_SIZE.height * 0.4;
        self.tvHeaderContent.scrollEnabled = YES;
    }
    
    _headerArea.frame = CGRectMake(0, 0, RT_WIDTH, textSize.height + 15.0);
    self.tableHeaderView = _headerArea;
    [self.tvHeaderContent setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (UITextView *)tvHeaderContent {
    if (_tvHeaderContent == nil) {
        
        _tvHeaderContent = [[UITextView alloc] init];
        _tvHeaderContent.editable = NO;
        _tvHeaderContent.scrollEnabled = NO;
        _tvHeaderContent.textAlignment = NSTextAlignmentCenter;
        _tvHeaderContent.selectable = NO;
        _tvHeaderContent.contentInset = UIEdgeInsetsZero;
        _tvHeaderContent.textContainer.lineFragmentPadding = 0;
        
        [_headerArea addSubview:_tvHeaderContent];
        
        RTAlertLayoutEdge(_tvHeaderContent, _headerArea, 15.0);
    }
    return _tvHeaderContent;
}

#pragma mark -
- (void)addActionItems:(NSArray <RTActionItem *>*)actionItems {
    if (!actionItems || actionItems.count == 0) return;
    
    if (actionItems.count == 2 && _style == RTAlertControllerStyleAlert) {
        _actionItems = actionItems.copy;
        self.tableFooterView = [self footer];
    } else if (actionItems.count > 2) {
        NSMutableArray <RTActionItem *>*mArray = [actionItems subarrayWithRange:NSMakeRange(1, actionItems.count - 1)].mutableCopy;
        [mArray addObject:actionItems.firstObject];
        _actionItems = mArray.copy;
    }
}

- (UIView *)header {
    _headerArea = [[UIView alloc] initWithFrame:CGRectMake(0, 0, RT_WIDTH, 10.0)];
    _headerArea.backgroundColor = [UIColor whiteColor];
    _headerArea.clipsToBounds = YES;
    _headerArea.layer.mask = RTLayerCorners(UIRectCornerTopLeft | UIRectCornerTopRight, CGRectMake(0, 0, RT_WIDTH, 1000.0));
    
    return _headerArea;
}

- (UIView *)footer {
    UIView *f = [[UIView alloc] initWithFrame:CGRectMake(0, 0, RT_WIDTH, 44.0)];
    f.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    RTAlertButton *button0 = [[RTAlertButton alloc] initWithFrame:CGRectMake(0, 1, RT_WIDTH * 0.5 - 0.5, 43.0)];
    button0.item = _actionItems.firstObject;
    [f addSubview:button0];
    
    RTAlertButton *button1 = [[RTAlertButton alloc] initWithFrame:CGRectMake(RT_WIDTH * 0.5 + 0.5, 1.0, RT_WIDTH * 0.5 - 0.5, 43.0)];
    button1.item = _actionItems.lastObject;
    [f addSubview:button1];
    return f;
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_style == RTAlertControllerStyleAlert && _actionItems.count == 2) {
        return 0;
    }
    
    if (_style == RTAlertControllerStyleActionSheet && _actionItems.lastObject.actionStyle == RTAlertActionStyleCancel) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_style == RTAlertControllerStyleActionSheet && _actionItems.lastObject.actionStyle == RTAlertActionStyleCancel) {
        if (section == 0) {
            return _actionItems.count - 1;
        } else if (section == 1) {
            return 1;
        }
    } else {
        return _actionItems.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RTAlertActionCell *cell = [[RTAlertActionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rt.alert.action.cell.id"];
    
    if (indexPath.section == 0) {
        cell.item = _actionItems[indexPath.row];
    } else if (indexPath.section == 1) {
        cell.item = _actionItems.lastObject;
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_style == RTAlertControllerStyleActionSheet) {
        return 50.0;
    } else {
        return 44.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.0001;
    } else {
        return 10.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        _actionItems[indexPath.row].handler();
    }
}

//然后在UITableView的代理方法中加入以下代码
- (void)tableView:(UITableView *)tableView willDisplayCell:(RTAlertActionCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if (indexPath.section == 0) {
        BOOL needCornerSheet = (_actionItems.count - 2 == indexPath.row) && (_style == RTAlertControllerStyleActionSheet);
        BOOL needCornerAlert = (_actionItems.count - 1 == indexPath.row) && (_style == RTAlertControllerStyleAlert);
        if (_actionItems.count > 1 && (needCornerSheet || needCornerAlert)) {
            [cell bottomTopCorner];
        }
    } else if (indexPath.section == 1) {
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 10.0;
    }
}


@end
