
#import "HFSegmentedControl.h"
#import "UIViewAdditions.h"
#define BS_SEG_BASE_TAG 101
#define freeObject(OBJECT_) ([OBJECT_ release],OBJECT_ = nil)

@interface HFSegmentedControl ()

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL action;

@end

@implementation HFSegmentedControl
@synthesize target = target_, action = action_;
@synthesize items = items_;
@synthesize selectedSegmentIndex;

- (IBAction) segmentPressed:(id)sender {
    self.selectedSegmentIndex = [sender tag] - BS_SEG_BASE_TAG;
}

#pragma mark - accessors

- (NSInteger) numberOfSegments {
    return self.items.count;
}

- (void) setSelectedSegmentIndex:(NSInteger)index {
    selectedSegmentIndex = index;

    for (int i = 0; i < self.items.count; ++i) {
        UIButton *v = (UIButton *)[self viewWithTag:i + BS_SEG_BASE_TAG];
        v.enabled = (index != i);
    }
    if (target_ != nil && action_ != nil) {
        [target_ performSelector:action_ withObject:self];
    }
}

- (NSInteger) selectedSegmentIndex {
    if (self.items.count == 0) {
        return UISegmentedControlNoSegment;
    }
    return selectedSegmentIndex;
}

- (void) setItems:(NSArray *)items {
    [items retain];
    [items_ release];
    items_ = items;

    CGFloat x = .0;
    CGFloat maxh = .0;
    UIButton *b = nil;

    for (int i = 0; i < items_.count; ++i) {
        id o = [items_ objectAtIndex:i];

        if ([o isKindOfClass:[UIImage class]]) {
            b = [UIButton buttonWithType:UIButtonTypeCustom];
            [b setImage:o forState:UIControlStateNormal];
            b.frame = (CGRect){CGPointZero, [(UIImage *)o size]};
        } else if ([o isKindOfClass:[UIButton class]]) {
            b = o;
        } else {
            [NSException raise:@"error"
                format:@"attempt to initialize with instance of %@", [o class]];
        }
        b.tag = i + BS_SEG_BASE_TAG;
        b.left = x;
        b.top = .0;
        [self addSubview:b];
        [b addTarget:self action:@selector(segmentPressed:)
            forControlEvents:UIControlEventTouchDown];

        x += b.width;
        CGFloat h = b.height;
        if (maxh < h) {
            maxh = h;
        }
    }
    self.width = x;
    self.height = maxh;
}

#pragma mark - lifecycle

/*
 * 可以从XIB创建，需要满足
 * 1. 设置highlighted和disabled状态的图片
 * 2. 指定tag
 * 3. 绑定TouchDown到segmentPressed:
 * 4. 没有其他子视图
 */
- (void) awakeFromNib {
    items_ = [[self subviews] retain];
}

- (id) initWithItems:(NSArray *)items {
    if (self = [super init]) {
        self.items = items;
    }
    return self;
}

- (void) dealloc {
    freeObject(items_);
    [super dealloc];
}

#pragma mark - custom

- (void) addTarget:(id)target action:(SEL)action
    forControlEvents:(UIControlEvents)controlEvents {

    if (controlEvents == UIControlEventValueChanged) {
        self.target = target;
        self.action = action;
    }
}

- (void) setImage:(UIImage *)image forSegmentIndex:(NSInteger)index
    andState:(UIControlState)state {

    UIButton *b = (UIButton *)[self viewWithTag:index + BS_SEG_BASE_TAG];
    [b setImage:image forState:state];
}

- (void) setImage:(UIImage *)image forSegmentIndex:(NSInteger)index {
    [self setImage:image forSegmentIndex:index andState:UIControlStateNormal];
}

- (void) setSelectedItems:(NSArray *)items {
    for (int i = 0; i < items.count; ++i) {
        UIButton *b = (UIButton *)[self viewWithTag:i + BS_SEG_BASE_TAG];
        if (b == nil) {
            break;
        }
        [b setImage:[items objectAtIndex:i] forState:UIControlStateHighlighted];
        [b setImage:[items objectAtIndex:i] forState:UIControlStateDisabled];
    }
}

@end
