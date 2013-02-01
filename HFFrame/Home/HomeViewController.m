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
#import "HFLoadingExampleViewController.h"
#import "GifExampleViewController.h"
#import "MTAnimatedLabelExampleViewController.h"
#import "AlertActionSheetBlockExampleViewController.h"
#import "MacroSingletonViewController.h"
#import "HFInfoViewController.h"
#import "HFSEFilterControlViewController.h"
#import "HFObjectMapViewController.h"

#import "SearchCoreManager.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize context_array;
@synthesize  nameArray;

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
    
    
    self.context_array = [[[NSArray alloc]initWithObjects:@"网络请求",@"网络图片",@"Button类",@"NSString NSArray …… ",@"Animation",@"语音播报",@"语音识别",@"循环Scrollview",@"TTTAttributedLabel",@"截屏函数 用于特殊动画需要",@"组动画和delegate",@"loading",@"Gif 图片支持",@"仿开机的动画label",@"UIAlert、ActionSheet+Blocks",@"宏定义单例",@"测试崩溃",@"自动消失提示框",@"指示选择器",@"序列化",nil]autorelease];
    
    for (NSUInteger i=0; i< [context_array count]; i++)
    {
        [[SearchCoreManager share] AddContact: [NSNumber  numberWithInteger:i]  name:[context_array objectAtIndex:i] phone:nil];
    }
    
     self.nameArray = [NSMutableArray array];
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
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *indexTiles = [NSMutableArray arrayWithArray:[@"A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|#"
    componentsSeparatedByString:@"|"]];
    [indexTiles insertObject:UITableViewIndexSearch atIndex:0];//添加搜索符号
//    [indexTiles addObject:@"{search}"];//等价于[indexTiles addObject:UITableViewIndexSearch];
    return indexTiles;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSLog(@"title = %@ \n index = %d ",title,index);
    [nameArray removeAllObjects];
   //如果等于0 则清楚拼音搜索标记
    if (index != 0)
    {
        [[SearchCoreManager share] Search:title searchArray:nil nameMatch:nameArray phoneMatch:nil];
        //默认只跳转到首个上面
        if ([nameArray count]>0)
        {
            NSLog(@"array = %@", nameArray);
        }
    }
    [tableView beginUpdates];
    [tableView reloadData];
    [tableView endUpdates];
    NSUInteger *scrollRow;
    if ([nameArray count]>0)
    {
        scrollRow = [[nameArray objectAtIndex:0]intValue] ;//默认滑倒第一个
    }
    else
    {
        scrollRow = 0;//点击了搜索图标 则复位滑倒第一行
    }
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:scrollRow inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return 1;
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
    NSMutableString *matchString = [NSMutableString string];
    NSMutableArray *matchPos = [NSMutableArray array];
    if ([nameArray count]>0)
    {
        [nameArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             [[SearchCoreManager share] GetPinYin:obj pinYin:matchString matchPos:matchPos];
             NSInteger i = [obj intValue];
             if (i == indexPath.row)
             {
                 cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ == 匹配坐标%@",matchString,matchPos];
             }
         }];
    }
    else
    {
        cell.detailTextLabel.text = nil;
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
    id vc = [[NSClassFromString(str) alloc]initWithNibName:str bundle:nil];
//    vc.title =  [context_array objectAtIndex:index];
    [vc setTitle:[context_array objectAtIndex:index]];
    [self.navigationController pushViewController:vc animated:YES];
    RELEASE_SAFELY(vc);
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
            break;
        case 11:
        {
            [self funcFromeString:@"HFLoadingExampleViewController" index:row];
        }
            break;
        case 12:
        {
            [self funcFromeString:@"GifExampleViewController" index:row];
        }
            break;
        case 13:
        {
            [self funcFromeString:@"MTAnimatedLabelExampleViewController" index:row];
        }
            break;
        case 14:
        {
            [self funcFromeString:@"AlertActionSheetBlockExampleViewController" index:row];
        }
            break;
        case 15:
        {
            [self funcFromeString:@"MacroSingletonViewController" index:row];
        }
            break;
        case 16:
        {
            [self hfff];
        }
            break;
        case 17:
        {
            [self funcFromeString:@"HFInfoViewController" index:row];
        }
            break;
        case 18:
        {
            [self funcFromeString:@"HFSEFilterControlViewController" index:row];
        }
            break;
        case 19:
        {
            [self funcFromeString:@"HFObjectMapViewController" index:row];
        }
        default:
            break;
    }
    //    alert(@"%d",ISJailBreak);
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
    [flipcalayer release];
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
    HFAlert(@"%@",parm);
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
