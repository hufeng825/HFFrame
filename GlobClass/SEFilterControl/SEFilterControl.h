/*例程*/
/*
SEFilterControl *filter = [[SEFilterControl alloc]initWithFrame:[self.view viewWithTag:10].frame
                                                         Titles:[NSArray arrayWithObjects:@"50元", @"100元", @"200元", @"300元",@"500元", nil]];
[filter setProgressColor:[UIColor lightGrayColor]];
//[filter setHandlerColor:[UIColor redColor]];
[filter setTitlesColor:[UIColor whiteColor]];
[filter addTarget:self action:@selector(filterValueChanged:) forControlEvents:UIControlEventValueChanged];
[self.view addSubview:filter];
[filter release];
 
*/
/*
-(void)filterValueChanged:(SEFilterControl *) sender{
    HFButton *bt = (HFButton*)[self.view viewWithTag:11];
    //    [bt setText:[NSString stringWithFormat:@"%d", sender.SelectedIndex]];
    [bt setTitle:[NSString stringWithFormat:@"去充值%@", [sender.titleArray objectAtIndex:sender.SelectedIndex] ] forState:UIControlStateNormal];
}
*/


#import <UIKit/UIKit.h>
#import "SEFilterKnob.h"

@interface SEFilterControl : UIControl{

}
-(id) initWithFrame:(CGRect) frame Titles:(NSArray *) titles;
-(void) setSelectedIndex:(int)index;
-(void) setTitlesColor:(UIColor *)color;
-(void) setTitlesFont:(UIFont *)font;
-(void) setHandlerColor:(UIColor *)color;

@property(nonatomic, retain) UIColor *progressColor;
@property(nonatomic, retain) NSArray *titleArray;
@property(nonatomic, readonly) int SelectedIndex;
//添加最大可以点击响应的索引
@property(nonatomic,assign) int EnableFromIndex;
@end
