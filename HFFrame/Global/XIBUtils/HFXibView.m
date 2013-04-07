
#import "HFXibView.h"
#import "HFXibViewUtils.h"

@implementation HFXibView

+ (id)loadFromXib
{
    return [HFXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}
@end
