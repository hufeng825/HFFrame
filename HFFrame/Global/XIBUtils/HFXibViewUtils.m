
#import "HFXibViewUtils.h"

@implementation HFXibViewUtils

+ (id)loadViewFromXibNamed:(NSString*)xibName withFileOwner:(id)fileOwner
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:xibName owner:fileOwner options:nil];
    if (array && [array count]) {
        return array[0];
    }else {
        return nil;
    }
}

+ (id)loadViewFromXibNamed:(NSString*)xibName
{
    return [HFXibViewUtils loadViewFromXibNamed:xibName withFileOwner:self];
}

@end
