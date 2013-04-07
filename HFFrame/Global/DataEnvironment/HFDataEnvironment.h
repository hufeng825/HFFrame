//
//  HFDataEnvironment.h
//  HFFrame
//
//  Created by jason on 13-4-7.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#define SUBJECT_USER_LOGOUT @"SUBJECT_USER_LOGOUT"
#define SUBJECT_USER_LOGIN @"SUBJECT_USER_LOGIN"


@interface HFDataEnvironment : NSObject

//@property (nonatomic, retain) HXUserInformation *currentUser;
//@property (nonatomic, retain) FundInformation *fundInfo;
@property (nonatomic, retain) NSString *publicKey;
@property (nonatomic, retain) NSString *privateKey;
@property (nonatomic, retain) NSArray *loginIDTypePickerDataArray;

//+ (HFDataEnvironment *)sharedDataEnvironment;

- (void)clearNetworkData;
- (void)clearCacheData;
- (BOOL)isUserLogined;
- (void)logout;
//- (void)userLogined:(HXUserInformation*)user;

- (void)saveLastLoginName:(NSString*)name
                   idType:(NSString*)idType;

- (NSString*)getLastLoginName;

- (NSString*)getLastLoginIdType;

- (NSString*)getLastLoginIdTypeName;

@end
