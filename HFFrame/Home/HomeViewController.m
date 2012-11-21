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



const NSString *warningStr = @"这是一个开源的工程 目前集成了 一些开发常用的开源库，纯属个人爱好 方便大家能快速迭代开发，如果侵犯到您的版权信息 请联系 550230997@qq.com";

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize context_array;

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
//    UILabel *label = [[[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.view.width, 100)]autorelease];
//    [label setText:warningStr];
//    [label setNumberOfLines:0];
//    [self.view addSubview:label];
    
    
    self.title = @"例程说明";
       // Do any additional setup after loading the view from its nib.
    /**************************************************************
     ************************下载图片代码段****************************
    
     UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:imageView];
    [imageView setImageWithURL:[NSURL URLWithString:@"http://img.my.csdn.net/uploads/201101/25/3619941_1295933551y8U4.jpg"]
                   placeholderImage:[UIImage imageNamed:@"default.png"]];
    
    *********************************************************************/
     
     
//    NSString *initParam = [[NSString alloc] initWithFormat:@"appid=%@",APPID];
    /********************----识别---******************
    IFlyRecognizeControl *_iflyRecognizeControl = [[IFlyRecognizeControl alloc] initWithOrigin:H_CONTROL_ORIGIN initParam:initParam];
    [self.view addSubview:_iflyRecognizeControl];
    // Configure the RecognizeControl
    // 设置语音识别控件的参数,具体参数可参看开发文档
	[_iflyRecognizeControl setEngine:@"sms" engineParam:nil grammarID:nil];
    [_iflyRecognizeControl setSampleRate:16000];
	_iflyRecognizeControl.delegate = self;
    [initParam release];
	[_iflyRecognizeControl start];
    *************************************************/
    
    /********************----播报---******************
    IFlySynthesizerControl *_iflySynizeControl = [[IFlySynthesizerControl alloc] initWithOrigin:H_CONTROL_ORIGIN initParam:initParam];
    [self.view addSubview:_iflySynizeControl];
    // Configure the RecognizeControl
    // 设置语音识别控件的参数,具体参数可参看开发文档
	[_iflySynizeControl setText:warningStr params:nil ];
	_iflySynizeControl.delegate = self;
    [_iflySynizeControl setVoiceName:@"xiaoyu"];
//    [_iflySynizeControl setSpeed:];
    [initParam release];
    [_iflySynizeControl setShowUI:NO];
	[_iflySynizeControl setSpeed:100];
	[_iflySynizeControl start];
     ***********************************************/
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
    
    
    self.context_array = [[[NSArray alloc]initWithObjects:@"网络请求",@"网络图片",@"Button类",@"NSString",@"Animation",@"语音播报",@"语音识别", nil]autorelease];
    

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

#pragma -
#pragma - UItableView delegate
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
    [self pushController:[context_array objectAtIndex:indexPath.row]];
}

#pragma -

-(void)pushController:(NSString*)title
{
    switch ([title intValue])
    {
        case 0:
        {
            HttpExampleViewController *vc = [[HttpExampleViewController alloc]initWithNibName:@"HttpExampleViewController" bundle:nil];
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}




#pragma -  语音接口实现
#pragma    识别接口实现
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
#pragma -


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
    RELEASE_CF_SAFELY(context_array);
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
