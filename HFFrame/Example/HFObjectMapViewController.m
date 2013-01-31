//
//  HFObjectMapViewController.m
//  HFFrame
//
//  Created by jason on 13-1-30.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import "HFObjectMapViewController.h"
#import "NSObject+JTObjectMapping.h"

@interface HFObjectMapViewController ()

@end

@implementation HFObjectMapViewController

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
    
    /***********************网络请求例子*****************************/
    HttpSucessRespon sua = HFHttpSucessResponClass
    {
        NSLog(@"json %@",[JSON class]);
        NSDictionary *dictmap = [NSDictionary dictionaryWithObjectsAndKeys:@"arrays" ,@"array"
                                 , nil];
        NSDictionary *dict = [NSDictionary  dictionaryWithObjectsAndKeys:
                              [MovieModel mappingWithKey:@"movieList" mapping:
                               [NSDictionary dictionaryWithObjectsAndKeys:[DictModel mappingWithKey:@"dict" mapping:dictmap],@"dict", nil] ]
                               ,@"movie",
                              [StateModel mappingWithKey:@"state" mapping:nil],@"state",nil];
        ContextModel *model =  [ContextModel objectFromJSONObject:JSON mapping:dict];
        NSLog(@"movie->dict0->array= %@ \n  movie->state->respCode= %@  \n  movie->dict1->body=%@",
              [[model.movieList objectAtIndex:0] dict].arrays,
              model.state.respCode,
              [[model.movieList objectAtIndex:1]body]
              );
        
    };
    NSURL *url = [[NSBundle mainBundle] URLForResource: @"j" withExtension:@"json"];
//    NSLog(@"url 输出 %@",[url absoluteString]);

    [self gettUrl:[[url absoluteString] stringByReplacingOccurrencesOfString:@"" withString:@""] sucessBlock:sua failBlock:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
