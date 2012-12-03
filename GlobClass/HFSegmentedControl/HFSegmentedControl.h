/*
 * BSSegmentedControl
 * 
 * 为了跟UISegmentedControl保持一致
 * 方法名基本跟UISegmentedControl相同
 * 并且添加了addTarget:action:forControlEvents方法
 *
 * 基本用法
 * 1. 使用initWithItems:方法初始化
 * 2. setSelectedItems:方法设置selected状态下的图片
 * 3. 可以从XIB创建
 * copy from https://github.com/Lamod/BSSegmentedControl
 * thanks lamod
 */

#import <UIKit/UIKit.h>

@interface HFSegmentedControl : UIView

@property (nonatomic, readonly) NSArray *items;
@property (nonatomic, readonly) NSInteger numberOfSegments;
@property (nonatomic, assign) NSInteger selectedSegmentIndex;

- (id) initWithItems:(NSArray *)items;

- (void) addTarget:(id)target action:(SEL)action
    forControlEvents:(UIControlEvents)controlEvents;

- (void) setImage:(UIImage *)image forSegmentIndex:(NSInteger)index
    andState:(UIControlState)state;
- (void) setImage:(UIImage *)image forSegmentIndex:(NSInteger)index;
- (void) setSelectedItems:(NSArray *)items;

@end
