

static NSBundle* globalBundle = nil;

/**
 * 设置全局bundle,默认为main bundle, 如多主题可以使用
 */
void HFSetDefaultBundle(NSBundle* bundle)
{
    [bundle retain];
    [globalBundle release];
    globalBundle = bundle;
}

/**
 * 返回全局默认bundle
 */
NSBundle *HFGetDefaultBundle()
{
    return (nil != globalBundle) ? globalBundle : [NSBundle mainBundle];
}

/**
 * 返回bundle资源路径
 */
NSString *HFPathForBundleResource(NSString* relativePath)
{
    NSString* resourcePath = [HFGetDefaultBundle() resourcePath];
    return [resourcePath stringByAppendingPathComponent:relativePath];
}

/**
 * 返回Documents资源路径
 */
NSString *HFPathForDocumentsResource(NSString* relativePath)
{
    static NSString* documentsPath = nil;
    if (nil == documentsPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsPath = [dirs[0] retain];
    }
    return [documentsPath stringByAppendingPathComponent:relativePath];
}


/**
 * 返回Cache资源路径
 */
NSString *HFPathForCacheResource(NSString* relativePath)
{
    static NSString* documentsPath = nil;
    if (nil == documentsPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        documentsPath = [dirs[0] retain];
    }
    return [documentsPath stringByAppendingPathComponent:relativePath];
}


