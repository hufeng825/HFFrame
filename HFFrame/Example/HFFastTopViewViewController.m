//
//  HFFastTopViewViewController.m
//  HFFrame
//
//  Created by jason on 13-3-27.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import "HFFastTopViewViewController.h"

@interface HFFastTopViewViewController ()

@end

@implementation HFFastTopViewViewController
@synthesize bgScrollView;
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
    [bgScrollView setContentSize:CGSizeMake(self.view.width,10000)];
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    topLabel.text = @"顶部";
    [self.bgScrollView addSubview:topLabel];
    
    UILabel *tailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10000, 100, 20)];
    tailLabel.text = @"底部";
    [self.bgScrollView addSubview:tailLabel];
    
    [bgScrollView setContentOffset:CGPointMake(0, 10000) animated:NO];
}
-  (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate)
    {
        CGPoint currentOffset = self.bgScrollView.contentOffset;
        NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
        
        NSTimeInterval timeDiff = currentTime - lastOffsetCapture;
        if(timeDiff > 0.1) {
            CGFloat distance = currentOffset.y - lastOffset.y;
            //The multiply by 10, / 1000 isn't really necessary.......
            CGFloat scrollSpeedNotAbs = (distance * 10) / 1000; //in pixels per millisecond
            
            CGFloat scrollSpeed = /*fabsf*/(scrollSpeedNotAbs);
            NSLog(@"~~~~~%f",scrollSpeed);
            if (scrollSpeed < -7.5)
            {
                //            isScrollingFast = YES;
                NSLog(@"Fast");
                [self.bgScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            } else {
                //            isScrollingFast = NO;
                NSLog(@"Slow");
            }
            ScrollDirection scrollDirection;
            if (lastOffset.y > scrollView.contentOffset.y)
                scrollDirection = ScrollDirectionUp;
            else scrollDirection = ScrollDirectionDown;
            if (scrollDirection == ScrollDirectionDown)
            {
                [self hideTabBar:NO];
            }
            else
            {
                [self hideTabBar:YES];
            }
            lastOffset = currentOffset;
            lastOffsetCapture = currentTime;
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [bgScrollView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setBgScrollView:nil];
    [super viewDidUnload];
}
@end
