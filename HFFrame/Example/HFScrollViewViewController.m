//
//  HFScrollViewViewController.m
//  HFFrame
//
//  Created by jason on 12-11-24.
//  Copyright (c) 2012年 jason. All rights reserved.
//

#import "HFScrollViewViewController.h"
@interface HFScrollViewViewController ()

@end

@implementation HFScrollViewViewController
@synthesize cycleScrollView,picArray;
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
	NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
	
	self.picArray= [[NSMutableArray alloc] init];
	[picArray addObject:[UIImage imageNamed:@"default"]];
	[picArray addObject:[UIImage imageNamed:@"default"]];
	[picArray addObject:[UIImage imageNamed:@"default"]];
    [picArray release];
//	UIImage *cachedImage = [manager imageWithURL:url];
	//如果cache没有命中，则去下载指定网络位置的图片，并且给出一个委托方法
		// Start an async download
//		[manager downloadWithURL: delegate:self];
	

	self.cycleScrollView =[ [CycleScrollView alloc ]initWithFrame:self.view.frame cycleDirection:CycleDirectionLandscape pictures:picArray TimeInterval:3];
	cycleScrollView.delegate = self;
	[self.view addSubview:cycleScrollView];
    [cycleScrollView release];
	[self initPictureFunc];
}

-(void)initPictureFunc
{
    SDWebImageManager *manager = [[[SDWebImageManager alloc]init] autorelease];
	for (int i=0; i<3; i++)
	{
		NSURL *url =nil;
		switch (i)
		{
			case 0:
				url = [NSURL URLWithString:@"http://img.my.csdn.net/uploads/201101/25/3619941_1295933580js8j.jpg"];
				break;
			case 1:
				url = [NSURL URLWithString:@"http://img.my.csdn.net/uploads/201101/25/3619941_1295933551y8U4.jpg"];
				break;
			case 2:
				url = [NSURL URLWithString:@"http://img.my.csdn.net/uploads/201101/25/3619941_1295933464VGk8.jpg"];
				break;
			default:
				break;
		}
		[manager downloadWithURL:url delegate:self options:SDWebImageRetryFailed success:^(UIImage *image, BOOL cached)
		{
			if (cached)
			{
			}
				[picArray replaceObjectAtIndex:i withObject:image];
			cycleScrollView.imagesArray = picArray;
			[cycleScrollView refreshScrollView];
		}
		    failure:^(NSError *error)
		 {
			 NSLog(@"%d error %@",i,[error localizedDescription]);
		 }
		 ];
	}
}

#pragma mark - CycleScrollViewDelegate
- (void)cycleScrollViewDelegate:(CycleScrollView *)cycleScrollView didSelectImageView:(int)index {
    
    [[[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"点击了第%d张", index]
                                 message:nil
                                delegate:nil
                       cancelButtonTitle:@"确定"
                       otherButtonTitles: nil] autorelease] show];
}

- (void)cycleScrollViewDelegate:(CycleScrollView *)cycleScrollView didScrollImageView:(int)index {
	
    self.title = [NSString stringWithFormat:@"第%d张", index];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    cycleScrollView.delegate = nil;
    RELEASE_SAFELY(cycleScrollView);
    RELEASE_SAFELY(picArray);
    [super dealloc];
}

@end
