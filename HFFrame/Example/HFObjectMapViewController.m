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
    HttpSucessResponBlock sua = HFHttp_Sucess_Respon
    {
        NSLog(@"json %@",[JSON class]);
        
        NSDictionary *dictmap = @{@"array":@"arrays"};
        
        NSDictionary *mapmap= [NSDictionary dictionaryWithObjectsAndKeys:[DictModel mappingWithKey:@"dict" mapping:dictmap],@"dict", nil];
        
        NSDictionary *dict = [NSDictionary  dictionaryWithObjectsAndKeys:
                              [MovieModel mappingWithKey:@"movieList" mapping:mapmap],@"movie",
                              [StateModel mappingWithKey:@"state" mapping:nil],@"state",nil];
        ContextModel *model =  [ContextModel objectFromJSONObject:JSON mapping:dict];
        
        
        
        NSArray *array = [[NSArray alloc]initWithObjects:model, nil];
        NSData *encodedCurBirdSightingList = [NSKeyedArchiver archivedDataWithRootObject:array];
        [USER_DEFAULT setObject:encodedCurBirdSightingList forKey:@"test"];
        [USER_DEFAULT synchronize];
        
        NSData *savedEncodedData = [USER_DEFAULT objectForKey:@"test"];
        if(savedEncodedData == nil)
        {
            NSMutableArray *sightingList = [[NSMutableArray alloc] init];
            array = sightingList;
        }
        else{
            array = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:savedEncodedData];
        }
        model = [array objectAtIndex:0];
        NSString *text = [NSString stringWithFormat: @"movie->dict0->array= %@ \n  movie->state->respCode= %@  \n  movie->dict1->body=%@",
                          [[model.movieList objectAtIndex:0] dict].arrays,
                          model.state.respCode,
                          [[model.movieList objectAtIndex:1]movid]];
        NSLog( @"%@",text);
        self.resultView.text = text;
    };
    NSURL *url = [[NSBundle mainBundle] URLForResource: @"j" withExtension:@"json"];
    [self gettUrl:[[url absoluteString] stringByReplacingOccurrencesOfString:@"" withString:@""] sucessBlock:sua failBlock:nil downloadProgressBlock:
     HFHttp_DownloadProgress
     {
         
     }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_resultView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setResultView:nil];
    [super viewDidUnload];
}
@end
