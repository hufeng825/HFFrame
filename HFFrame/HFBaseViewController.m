//
//  HFBaseViewController.m
//  HFFrame
//
//  Created by jason on 12-10-20.
//  Copyright (c) 2012年 jason. All rights reserved.
//


/*********** 正则代码块******************
NSString *email = @"13068319870609101X";
bool ye =[email isMatchedByRegex:@""];
 *************************************/



#import "HFBaseViewController.h"
#import "RegexKitLite.h"
#import "UIColor+Hex.h"




@interface HFBaseViewController ()

@end




@implementation HFBaseViewController
@synthesize titleLabel,hfClient;

- (id)init
{
//    self = [super init];
    [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
    }
    
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {

    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}


/*------------------------------------------
 *设置背景
------------------------------------------*/

 - (void)changeBaseBackgourndColorWithImageName:(NSString *)imageName
{
    UIColor *bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
    if ([self.view isKindOfClass:[UITableView class]]) {
        UIView *viewi = [[[UIView alloc] initWithFrame:self.view.bounds] autorelease];
        viewi.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        viewi.backgroundColor = bgColor;
        UITableView *tView = (UITableView *)self.view;
        if ([tView respondsToSelector:@selector(setBackgroundView:)]) {
            [tView setBackgroundView:viewi];
        }
    }
    self.view.backgroundColor = bgColor;
}

/*------------------------------------------
 *隐藏tabbar
 ------------------------------------------*/
- (void) hideTabBar:(BOOL) hidden{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    UIView *window = [UIApplication sharedApplication].keyWindow;
    for(UIView *view in self.tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, window.height, view.frame.size.width, view.frame.size.height)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, window.height-49, view.frame.size.width, view.frame.size.height)];
            }
        }
        else
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, window.height)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, window.height-49)];
            }
        }
    }
    
    [UIView commitAnimations];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //ios5++
	if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0"))
    {
        [[UIBarButtonItem appearance] setTintColor:
         [UIColor colorWithHex:0xD60016]
//         [UIColor colorWithred:174 green:22 blue:21]
         ];
	}
    
    [self toSetTitleLable];
    
//    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];    
//    NSString *path = [NSString stringWithFormat:@"myapipath/?value=%@", value];
   
//    [[client operationQueue]cancelAllOperations];
}

#pragma mark  - 返回上级页面
-(void)goBack
{
    if ([[self.navigationController viewControllers]count]>1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissModalViewControllerAnimated:YES];
    }
}


#pragma mark  - 设置title
-(void) toSetTitleLable
{
    if (!titleLabel) {
        self.titleLabel = [[[UILabel alloc] initWithFrame:self.navigationController.navigationBar.frame] autorelease];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:22.0];
        titleLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor]; // change this color
//        [titleLabel setAutoresizingMask:UIViewAutoresizingNone ];
        self.navigationItem.titleView = titleLabel;
    }
}
-(void)setTitle:(NSString *)title
{
    if (!titleLabel)
    {
        [self toSetTitleLable];
    }
    if (title)
    {
        self.titleLabel.text = title;
    }
}

-(NSString*)title
{
    return self.titleLabel.text;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  -  网络请求
-(HFHttpRequest *)hfClient
{
    if (!hfClient) {
        self.hfClient = [HFHttpRequest client];
    }
    return hfClient;
}

-(void)postUrl:(NSString*)url parameters:(NSDictionary *)parameters
   sucessBlock:(HttpSucessResponBlock)sucessRespon failBlock:(HttpFailResponBlock)failRespon downloadProgressBlock:(HttpDownloadProgressBlock)downloadProgressBlock
{
    [self.hfClient Url:url  parameters:parameters sucessBlock:sucessRespon failBlock:failRespon method:POSTHttpMethod progressBlock:downloadProgressBlock] ;
}

-(void)gettUrl:(NSString*)url sucessBlock:(HttpSucessResponBlock)sucessRespon failBlock:(HttpFailResponBlock)failRespon downloadProgressBlock:(HttpDownloadProgressBlock)downloadProgressBlock;
{
    [self.hfClient Url:url  parameters:nil sucessBlock:sucessRespon failBlock:failRespon method:GETHttpMethod progressBlock:downloadProgressBlock];
}


- (void)dealloc
{
    
    //[[hfClient operationQueue]cancelAllOperations];
    RELEASE_SAFELY(hfClient);

    RELEASE_SAFELY(titleLabel);
    [super dealloc];
}





@end
