//
//  ModelKit.m
//  HFFrame
//
//  Created by jason on 13-1-30.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import "ModelKit.h"
@implementation ModelKit
@end

/*-------------------------------------------------*/
@implementation StateModel
@synthesize respCode,respMsg;
-(void)encodeWithCoder:(NSCoder *)aCoder{
    //encode properties/values
    [aCoder encodeObject:self.respCode      forKey:@"respCode"];
    [aCoder encodeObject:self.respMsg  forKey:@"respMsg"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if((self = [super init])) {
        //decode properties/values
        self.respCode       = [aDecoder decodeObjectForKey:@"respCode"];
        self.respMsg   = [aDecoder decodeObjectForKey:@"respMsg"];
    }
    
    return self;
}
- (void)dealloc
{
    [respCode release];
    [respMsg release];
    [super dealloc];
}
@end

/*-------------------------------------------------*/
@implementation DictModel
@synthesize name,arrays;
-(void)encodeWithCoder:(NSCoder *)aCoder{
    //encode properties/values
    [aCoder encodeObject:self.name      forKey:@"name"];
    [aCoder encodeObject:self.arrays  forKey:@"arrays"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if((self = [super init])) {
        //decode properties/values
        self.name       = [aDecoder decodeObjectForKey:@"state"];
        self.arrays   = [aDecoder decodeObjectForKey:@"arrays"];
    }
    
    return self;
}
- (void)dealloc
{
    [name release];
    [arrays release];
    [super dealloc];
}

@end

/*-------------------------------------------------*/
@implementation MovieModel
@synthesize body,pics,name,movid,length,hasplan,trailor,director,type,url,dict;
-(void)encodeWithCoder:(NSCoder *)aCoder{
    //encode properties/values
    [aCoder encodeObject:self.body      forKey:@"body"];
    [aCoder encodeObject:self.pics  forKey:@"pics"];
    [aCoder encodeObject:self.name      forKey:@"name"];
    [aCoder encodeObject:self.movid  forKey:@"movid"];
    [aCoder encodeObject:self.length      forKey:@"length"];
    [aCoder encodeObject:self.hasplan  forKey:@"hasplan"];
    [aCoder encodeObject:self.trailor      forKey:@"trailor"];
    [aCoder encodeObject:self.director  forKey:@"director"];
    [aCoder encodeObject:self.type      forKey:@"type"];
    [aCoder encodeObject:self.url  forKey:@"url"];
    [aCoder encodeObject:self.dict      forKey:@"dict"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if((self = [super init])) {
        //decode properties/values
        self.body       = [aDecoder decodeObjectForKey:@"body"];
        self.pics   = [aDecoder decodeObjectForKey:@"pics"];
        self.name       = [aDecoder decodeObjectForKey:@"name"];
        self.movid   = [aDecoder decodeObjectForKey:@"movid"];
        self.length       = [aDecoder decodeObjectForKey:@"length"];
        self.hasplan   = [aDecoder decodeObjectForKey:@"hasplan"];
        self.trailor       = [aDecoder decodeObjectForKey:@"trailor"];
        self.director   = [aDecoder decodeObjectForKey:@"director"];
        self.type       = [aDecoder decodeObjectForKey:@"type"];
        self.url   = [aDecoder decodeObjectForKey:@"url"];
        self.dict       = [aDecoder decodeObjectForKey:@"dict"];
    }
    
    return self;
}
- (void)dealloc
{
    [body release];
    [pics release];
    [name release];
    [movid release];
    [length release];
    [hasplan release];
    [trailor release];
    [director release];
    [type release];
    [url release];
    [dict release];
    [super dealloc];
}
@end

/*-------------------------------------------------*/
@implementation ContextModel
@synthesize movieList,state;
-(void)encodeWithCoder:(NSCoder *)aCoder{
    //encode properties/values
    [aCoder encodeObject:self.state      forKey:@"state"];
    [aCoder encodeObject:self.movieList  forKey:@"movieList"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if((self = [super init])) {
        //decode properties/values
        self.state       = [aDecoder decodeObjectForKey:@"state"];
        self.movieList   = [aDecoder decodeObjectForKey:@"movieList"];
    }
    
    return self;
}
-(void) dealloc
{
    [state release];
    [movieList release];
    [super dealloc];
}

@end
