//
//  ITTGobalPaths.h
//  iTotemFrame
//
//  Created by jian jin on 8/23/11.
//  Copyright 2011 caixin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 设置全局bundle,默认为main bundle, 如多主题可以使用
 */
void HFSetDefaultBundle(NSBundle* bundle);

/**
 * 返回全局默认bundle
 */
NSBundle *HFGetDefaultBundle();

/**
 * 返回bundle资源路径
 */
NSString *HFPathForBundleResource(NSString* relativePath);

/**
 * 返回Documents资源路径
 */
NSString *HFPathForDocumentsResource(NSString* relativePath);

/**
 * 返回Cache资源路径
 */
NSString *HFPathForCacheResource(NSString* relativePath);
