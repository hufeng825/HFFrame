//
//  HomeViewController.m
//  HFFrame
//
//  Created by jason on 12-11-8.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "HomeViewController.h"
#import "HFAnimation.h"
#import "UIImageView+WebCache.h"

#import "HttpExampleViewController.h"
#import "WebPictureViewController.h"
#import "HFButtonExampleViewController.h"
#import "AnimationExampleViewController.h"
#import "VoiceReadViewController.h"
#import "VoiceExampleViewController.h"
#import "HFScrollViewViewController.h"
#import "AttributedLabelControllViewController.h"
#import "ScreenshotExampleViewController.h"
#import "FlodExampleViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize context_array;

/******用于翻转动画 工程中没用到可注释******/
@synthesize flipcalayer;
/******        结束翻转动画       ******/

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"例程说明";
       // Do any additional setup after loading the view from its nib.
    
//    //HFbutton类使用
//    bt.userInfo = @"d";
//    [bt addTarget:self action:@selector(btClick:) forControlEvents:UIControlEventTouchUpInside];
////    [bt beginWarningAnimation];
//    
//    //arrary 数组去重复
//    NSArray *array = [NSArray arrayWithObjects:@"1",@"1",@"2",@"3",@"4",nil];
//    NSLog(@"%@",array);
//    NSLog(@"%@", [array uniqueMembers]);
////     [HFAnimation animationHeartbeat:bt];
//    [HFAnimation animationShake:bt];
    
    
    self.context_array = [[[NSArray alloc]initWithObjects:@"网络请求",@"网络图片",@"Button类",@"NSString NSArray …… ",@"Animation",@"语音播报",@"语音识别",@"循环Scrollview",@"TTTAttributedLabel",@"截屏函数 用于特殊动画需要",@"组动画和delegate",nil]autorelease];
}
//-(void)btClick:(id)sender
//{
//    if([sender isKindOfClass:[HFButton class]])
//    {
//        //停止醒目提示
////        [(HFButton*)sender stopWarningAnimation];
//        NSLog(@"%@",bt.userInfo);
//        [HFAnimation removeAllAnimation:sender];
//    }
//}

#pragma mark -
#pragma mark - UItableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [context_array count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (cell == nil)
    {
        // Create a cell to display an ingredient.
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:showUserInfoCellIdentifier]
                autorelease];
    }
    
    // Configure the cell.
    cell.textLabel.text= [context_array objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self pushController:indexPath.row];
}

#pragma mark -
-(void)funcFromeString:(NSString*)str index:(NSInteger)index
{
    id vc = [[[NSClassFromString(str) alloc]initWithNibName:str bundle:nil]autorelease];
//    vc.title =  [context_array objectAtIndex:index];
    [vc setTitle:[context_array objectAtIndex:index]];
    [self.navigationController pushViewController:vc animated:YES];
   
}


-(void)pushController:(NSInteger)row
{
    switch (row)
    {
        case 0:
        {
            [self funcFromeString:@"HttpExampleViewController" index:row];
        }
            break;
        case 1:
        {
            [self funcFromeString:@"WebPictureViewController" index:row];
        }
            break;
        case 2:
        {
            [self funcFromeString:@"HFButtonExampleViewController" index:row];
        }
            break;
        case 3:
        {
            HFAlert(@"详情请参阅头文件 对原有数据格式添加了很多方法 例如 数组去重复  string 判断 等等");
        }
            break;
        case 4:
        {
            [self funcFromeString:@"AnimationExampleViewController" index:row];
        }
            break;
        case 5:
        {
            [self funcFromeString:@"VoiceReadViewController" index:row];
        }
            break;
        case 6:
        {
            [self funcFromeString:@"VoiceExampleViewController" index:row];
        }
			break;
		case 7:
		{
            [self funcFromeString:@"HFScrollViewViewController" index:row];
		}
			break;
        case 8:
        {
            [self funcFromeString:@"AttributedLabelControllViewController" index:row];
        }
            break;
        case 9:
        {
            [self funcFromeString:@"ScreenshotExampleViewController" index:row];
        }
            break;
        case 10:
        {
//            [self funcFromeString:@"FlipViewController" index:row];
            FlipViewController *vc = [[[FlipViewController alloc]initWithNibName:@"FlipViewController" bundle:nil]autorelease];
            [vc setTitle:[context_array objectAtIndex:row]];
            vc.delegate = self;
            [self.navigationController pushViewController:vc animated:NO];
        }
        default:
            break;
    }
    NSLog(@"%d",ISJailBreak);
}


#pragma  mark


#pragma mark flip
-(void)FlipViewControllerClose:(FlipViewController *)flipViewController
{
    self.flipcalayer = [[FlipCAlayer alloc]init];
    
    
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    [self.navigationController.view.layer addSublayer:flipcalayer];
    [CATransaction commit];
    
    //变化layer的大小，从小到大
    CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    boundsAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 0, 0)];
    boundsAnimation.toValue = [NSValue valueWithCGRect:self.navigationController.view.bounds];
    
    
    //变化layer的位置
    CABasicAnimation *positonAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positonAnimation.fromValue = [NSValue valueWithCGPoint:self.flipcalayer.position];
    positonAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.navigationController.view.bounds), CGRectGetMidY(self.navigationController.view.bounds))];
    
    //组合动画
    CAAnimationGroup *group =[CAAnimationGroup animation];
    group.duration = 0.5;
    group.animations = [NSArray arrayWithObjects:boundsAnimation,positonAnimation, nil];
    group.delegate = self;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    [self.flipcalayer addAnimation:group forKey:@"zoomIn"];
    
    //页面翻转
    CATransition *transition = [CATransition animation];
    transition.type =@"flip";// kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.duration = 0.25;
    
    self.flipcalayer.contents = (id)[[UIApplication sharedApplication].keyWindow screenshot].CGImage;
    [self.flipcalayer addAnimation:transition forKey:@"push"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	if (anim == [self.flipcalayer animationForKey:@"zoomIn"])
    {
        [self.navigationController popViewControllerAnimated:NO];
		self.flipcalayer.hidden = YES;
	}
}

#pragma mark 


#pragma mark -  语音接口实现
#pragma  mark 识别接口实现
- (void) onGrammer:(NSString *)grammer error:(int)err
{
    NSLog(@"the error is:%d",err);
    
}

- (void) onRecognizeEnd:(IFlyRecognizeControl *)iFlyRecognizeControl theError:(int)error
{
    NSLog(@"识别结束回调finish.....");
//	NSLog(@"getUpflow:%d,getDownflow:%d",[iFlyRecognizeControl getUpflow],[iFlyRecognizeControl getDownflow]);
    
}

-(void)action:(id)parm
{
    HFAlert(parm);
}

- (void) onResult:(IFlyRecognizeControl *)iFlyRecognizeControl theResult:(NSArray *)resultArray
{
    [self onRecognizeResult:resultArray];
}
- (void)onRecognizeResult:(NSArray *)array
{
    //  execute the onUpdateTextView function in main thread
    //  在主线程中执行onUpdateTextView方法
	[self performSelectorOnMainThread:@selector(action:) withObject:
	 [[array objectAtIndex:0] stringForKey:@"NAME"] waitUntilDone:YES];
}



#pragma 合成接口实现
- (void)onSynthesizerEnd:(IFlySynthesizerControl *)iFlySynthesizerControl theError:(SpeechError) error
{
    
	NSLog(@"finish.....");
//	[self enableButton];
    
	// get the upload flow and download flow
    // 获取上传流量和下载流量
	NSLog(@"upFlow:%d,downFlow:%d",[iFlySynthesizerControl getUpflow],[iFlySynthesizerControl getDownflow]);
}
// get the player buffer progress
// 获取播放器缓冲进度
- (void)onSynthesizerBufferProgress:(float)bufferProgress
{
    NSLog(@"the playing buffer :%f",bufferProgress);
}
// get the player progress
// 获取播放器的播放进度
- (void)onSynthesizerPlayProgress:(float)playProgress
{
    NSLog(@"the playing progress :%f",playProgress);
}
#pragma mark -


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    RELEASE_SAFELY(context_array);
    RELEASE_SAFELY (flipcalayer);
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
