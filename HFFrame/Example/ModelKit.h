//
//  ModelKit.h
//  HFFrame
//
//  Created by jason on 13-1-30.
//  Copyright (c) 2013年 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 *****str =
 {"state":{"respCode":"0000","respMsg":"1"},"movie":[{"body":"一开始，这只是叶问的故事他生于佛山","pics":"/images/jz/4779-1-20121225133147.jpg,/images/jz/4779-2-20121225133147.jpg","name":"一代宗师","movid":"4779","length":"120","hasplan":"1","trailor":"/4779.m4v","director":"梁朝伟章子怡张震","type":"动作/传记/剧情/IMAX","url":"http://img.fun-guide.mobi/show?src=http://zhaohang.fun-guide.mobi:8080/tm/images/hb/4779-20121225133147.jpg&w=140","popularity":"6","dict":{"name":"jason","array":["a","b"]}},{"body":"一开始，这只是叶问的故事他生于佛山","pics":"/images/jz/4779-1-20121225133147.jpg,/images/jz/4779-2-20121225133147.jpg","name":"一代宗师","movid":"4779","length":"120","hasplan":"1","trailor":"/4779.m4v","director":"梁朝伟章子怡张震","type":"动作/传记/剧情/IMAX","url":"http://img.fun-guide.mobi/show?src=http://zhaohang.fun-guide.mobi:8080/tm/images/hb/4779-20121225133147.jpg&w=140","popularity":"6","dict":{"name":"jason","array":["a","b"]}}]}
 
 */

/*
 {
 state: {
 respCode: "0000",
 respMsg: "1"
 },
 movie: [
 {
 body: "一开始，这只是叶问的故事他生于佛山",
 pics: "/images/jz/4779-1-20121225133147.jpg,/images/jz/4779-2-20121225133147.jpg",
 name: "一代宗师",
 movid: "4779",
 length: "120",
 hasplan: "1",
 trailor: "/4779.m4v",
 director: "梁朝伟章子怡张震",
 type: "动作/传记/剧情/IMAX",
 url: "http://img.fun-guide.mobi/show?src=http://zhaohang.fun-guide.mobi:8080/tm/images/hb/4779-20121225133147.jpg&w=140",
 popularity: "6",
 dict: {
 name: "jason",
 array: [
 "a",
 "b"
 ]
 }
 },
 {
 body: "一开始，这只是叶问的故事他生于佛山",
 pics: "/images/jz/4779-1-20121225133147.jpg,/images/jz/4779-2-20121225133147.jpg",
 name: "一代宗师",
 movid: "4779",
 length: "120",
 hasplan: "1",
 trailor: "/4779.m4v",
 director: "梁朝伟章子怡张震",
 type: "动作/传记/剧情/IMAX",
 url: "http://img.fun-guide.mobi/show?src=http://zhaohang.fun-guide.mobi:8080/tm/images/hb/4779-20121225133147.jpg&w=140",
 popularity: "6",
 dict: {
 name: "jason",
 array: [
 "a",
 "b"
 ]
 }
 }
 ]
 }
 */
@interface ModelKit : NSObject
@end


@interface StateModel : ModelKit
@property(nonatomic,copy) NSString *respCode;
@property(nonatomic,copy) NSString  *respMsg;
@end


@interface  ContextModel :ModelKit
@property (nonatomic,retain) NSArray *movieList;
@property (nonatomic,retain) StateModel *state;
@end


@interface DictModel : ModelKit
@property (nonatomic,copy) NSString *name;
@property (nonatomic,retain) NSArray *array;
@end

@interface  MovieModel : ModelKit
@property (nonatomic,copy) NSString * body;
@property (nonatomic,copy) NSString *pics;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *movid;
@property (nonatomic,copy) NSString *length;
@property (nonatomic,copy) NSString *hasplan;
@property (nonatomic,copy) NSString *trailor;
@property (nonatomic,copy) NSString *director;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *popularity;
@property (nonatomic,copy) DictModel *dict;
@end






























