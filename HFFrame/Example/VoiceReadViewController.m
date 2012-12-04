//
//  VoiceReadViewController.m
//  HFFrame
//
//  Created by jason on 12-11-21.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "VoiceReadViewController.h"

@interface VoiceReadViewController ()

@end

@implementation VoiceReadViewController
IFlySynthesizerControl *_iflySynizeControl;
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
    // Do any additional setup after loading the view from its nib.
    /********************----播报---******************///
    NSString *initParam = [[[NSString alloc] initWithFormat:@"appid=%@",APPID]autorelease];
    _iflySynizeControl = [[IFlySynthesizerControl alloc] initWithOrigin:H_CONTROL_ORIGIN initParam:initParam];
    [self.view addSubview:_iflySynizeControl];
    // Configure the RecognizeControl
    // 设置语音识别控件的参数,具体参数可参看开发文档
    [_iflySynizeControl setText:@"白日依山尽,黄河入海流,欲穷千里目,更上一层楼  北京新空气" params:nil ];
    _iflySynizeControl.delegate = self;
    [_iflySynizeControl setVoiceName:@"xiaoyu"];
    [_iflySynizeControl setShowUI:YES];
    [_iflySynizeControl setSpeed:100];
    [_iflySynizeControl start];
    /***********************************************/

}
-(void)viewDidDisappear:(BOOL)animated
{
    [_iflySynizeControl  cancel];
    _iflySynizeControl.delegate = nil;
    [super viewDidDisappear:YES];
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
    [super dealloc];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
- (IBAction)readBtClick:(id)sender
{
   

}
@end
