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
        
    self.context_array = [[[NSArray alloc]initWithObjects:@"网络请求",@"网络图片",@"Button类",@"NSString NSArray …… ",@"Animation",@"语音播报",@"语音识别", nil]autorelease];
    

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
    [self pushController:indexPath.row];
}

#pragma -

-(void)pushController:(NSInteger)row
{
    switch (row)
    {
        case 0:
        {
            HttpExampleViewController *vc = [[HttpExampleViewController alloc]initWithNibName:@"HttpExampleViewController" bundle:nil];
            vc.title =  [context_array objectAtIndex:row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            WebPictureViewController *vc = [[WebPictureViewController alloc]initWithNibName:@"WebPictureViewController" bundle:nil];
            vc.title =  [context_array objectAtIndex:row];
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 2:
        {
            HFButtonExampleViewController *vc = [[HFButtonExampleViewController alloc]initWithNibName:@"HFButtonExampleViewController" bundle:nil];
            vc.title =  [context_array objectAtIndex:row];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 3:
        {
            HFAlert(@"详情请参阅头文件 对原有数据格式添加了很多方法 例如 数组去重复  string 判断 等等");
        }
            break;
        case 4:
        {
            AnimationExampleViewController *vc = [[AnimationExampleViewController alloc]initWithNibName:@"AnimationExampleViewController" bundle:nil];
            vc.title =  [context_array objectAtIndex:row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            VoiceReadViewController *vc = [[VoiceReadViewController alloc]initWithNibName:@"VoiceReadViewController" bundle:nil];
            vc.title =  [context_array objectAtIndex:row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
        {
            VoiceExampleViewController *vc = [[VoiceExampleViewController alloc]initWithNibName:@"VoiceExampleViewController" bundle:nil];
            vc.title =  [context_array objectAtIndex:row];
            [self.navigationController pushViewController:vc animated:YES];

        }
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
