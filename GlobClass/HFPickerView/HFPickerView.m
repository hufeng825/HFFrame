//
//  HFPickerView.m
//  HFFrame
//
//  Created by jason on 13-2-4.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import "HFPickerView.h"

@implementation HFPickerView
@synthesize view;
@synthesize pickView;
@synthesize component1Array;
@synthesize component1Dictionary;
@synthesize delegate;
@synthesize mask = _mask;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.view = [[[NSBundle mainBundle] loadNibNamed:@"PickerView" owner:self options:nil]objectAtIndex:0];
        [self customInit];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [self initWithCoder:aDecoder])
    {
        self.view= [[[NSBundle mainBundle] loadNibNamed:@"PickerView" owner:self options:nil]objectAtIndex:0];
        [self customInit];
    }
    return self;
}

-(void)customInit
{
    //    self.backgroundColor = [UIColor blackColor];
//    [self setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
//    self.imageView =(UIImageView*) [customView viewWithTag:11];
    [self.pickView setDelegate:self];
    [[self cancelButton] addTarget:self action:@selector(cancelButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [[self okButton] addTarget:self action:@selector(okButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:view];
}

-(UIPickerView*)pickView
{
   return (UIPickerView *) [self.view viewWithTag:100];
}
-(UILabel*)titleLabel
{
    return (UILabel *) [self.view viewWithTag:130];
}
-(UIButton*)okButton
{
    return (UIButton *) [self.view viewWithTag:110];
}
-(UIButton*)cancelButton
{
    return (UIButton *) [self.view viewWithTag:120];
}

-(UIWindow*)window
{
     return  [UIApplication sharedApplication].keyWindow;
}
-(void) showSelfView
{
    if ([[self.view superview] superview]) {
        return;
    }
    [self showMaskAnimated:YES];
    UIView* window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
    UIView * showView = self.view;
	showView.frame = CGRectMake(0, - showView.frame.size.height, showView.frame.size.width, showView.frame.size.height);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    //[UIView setAnimationDelegate:self];
    //[UIView setAnimationDidStopSelector:@selector(showAnimationDidStop:finished:)];
    showView.frame = CGRectMake(0,20, showView.frame.size.width, showView.frame.size.height);
    [UIView commitAnimations];
}

#pragma mark - 
-(void) showMaskAnimated:(BOOL) animated{
    [[UIApplication sharedApplication].keyWindow addSubview:self.mask];
    if(animated)
    {
        _mask.alpha = 0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.4];
        [UIView setAnimationDelegate:self.mask];
        //[UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
        _mask.alpha = 0.5;
        [UIView commitAnimations];
    }else {
        _mask.alpha = 0.5;
    }
}
-(void) dismissMaskAnimated:(BOOL) animated{
    if(animated)
    {
        _mask.alpha = 0.5;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.4];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
        _mask.alpha = 0;
        [UIView commitAnimations];
    }else {
        _mask.alpha = 0;
        [_mask removeFromSuperview];
    }
}
-(UIControl *) mask{
    if (_mask == nil) {
        _mask = [[UIControl  alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
        _mask.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        _mask.backgroundColor = [UIColor blackColor];
        [_mask addTarget:self action:@selector(dismissSelfView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mask;
}


-(void) dismissSelfView{
#ifdef TARGET_IPAD
	[_popver dismissPopoverAnimated:YES];
#else
    [self dismissMaskAnimated:YES];
    UIView * showView = self.view;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDelegate:self.view];
    [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
	showView.frame = CGRectMake(0,-showView.frame.size.height, showView.frame.size.width, showView.frame.size.height);
    [UIView commitAnimations];
//    if (_request) {
//        [_request clearDelegatesAndCancel];
//    }
#endif
}

#pragma mark -
-(void) showSelfViewFromRect:(CGRect)rect inView:(UIView *)view{
#ifdef TARGET_IPAD
	if (_popver && _popver.popoverVisible) {
		return;
	}
	if (!_popver) {
		_popver = [[UIPopoverController alloc] initWithContentViewController:self];
		_popver.popoverContentSize = self.view.frame.size;
	}
	[_popver presentPopoverFromRect:rect inView:view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
#else
	[self showSelfView];
#endif
}

#pragma mark -
#pragma mark UIPickerView delegate & datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (component1Dictionary && [component1Array count]>0) {
        return 2;
    }
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [component1Array count];
    }else {
        NSLog(@"---%@",component1Array);
        NSDictionary *selComp1Dic = [component1Array objectAtIndex:[pickerView selectedRowInComponent:0]];
        return [[component1Dictionary objectForKey:[selComp1Dic objectForKey:@"value"]] count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [[component1Array objectAtIndex:row] objectForKey:@"name"];
    }else {
        NSDictionary *selComp1Dic = [component1Array objectAtIndex:[pickerView selectedRowInComponent:0]];
        return [[[component1Dictionary objectForKey:[selComp1Dic objectForKey:@"value"]] objectAtIndex:row] objectForKey:@"name"];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component1Dictionary && [component1Array count]>0) {
        if (component == 0) {
            [pickerView reloadComponent:1];
        }
    }
}
-(void) toSetLabelText:(NSString *)title
{
    if ([title length]>0)
    {
        [self titleLabel].text = title;
    }
}
-(IBAction) cancelButtonPress:(id) sender{
    [self dismissSelfView];
}
-(IBAction) okButtonPress:(id) sender{
    [self dismissSelfView];
    NSString *name = nil;
    NSString *value = nil;
    if (!component1Array || [component1Array count]==0) {
        return;
    }
    NSDictionary *selComp1Dic = [component1Array objectAtIndex:[self.pickView selectedRowInComponent:0]];
    if (component1Dictionary) {
        NSArray *array = [component1Dictionary objectForKey:[selComp1Dic objectForKey:@"value"]];
        if([array count]>0 ){
            name = [[array objectAtIndex:[pickView selectedRowInComponent:1]] objectForKey:@"name"];
            value = [[array objectAtIndex:[pickView selectedRowInComponent:1]] objectForKey:@"value"];
        }else {
            name = [selComp1Dic objectForKey:@"name"];
            value = [selComp1Dic objectForKey:@"value"];
        }
    }else {
        name = [selComp1Dic objectForKey:@"name"];
        value = [selComp1Dic objectForKey:@"value"];
    }
    
    [self.delegate PickerViewChangeValue:HFSNumString(value) name:name component1Dictionary:selComp1Dic];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [_mask release];
    
    [view release];
    [super dealloc];
}
@end
