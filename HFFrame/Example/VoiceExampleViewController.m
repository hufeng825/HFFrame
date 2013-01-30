//
//  VoiceExampleViewController.m
//  HFFrame
//
//  Created by jason on 12-11-21.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "VoiceExampleViewController.h"

@interface VoiceExampleViewController ()

@end

@implementation VoiceExampleViewController

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
    
    NSString *initParam = [[NSString alloc] initWithFormat:@"appid=%@",APPID];
    /********************----识别---******************/
     IFlyRecognizeControl *_iflyRecognizeControl = [[IFlyRecognizeControl alloc] initWithOrigin:H_CONTROL_ORIGIN initParam:initParam];
     [self.view addSubview:_iflyRecognizeControl];
     // Configure the RecognizeControl
     // 设置语音识别控件的参数,具体参数可参看开发文档
     [_iflyRecognizeControl setEngine:@"sms" engineParam:nil grammarID:nil];
     [_iflyRecognizeControl setSampleRate:16000];
     _iflyRecognizeControl.delegate = self;
     [initParam release];
     [_iflyRecognizeControl start];
     /*************************************************/

}
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
