
#import "HFXibView.h"
#import "ITTXibViewUtils.h"

@implementation HFXibView

+ (id)loadFromXib
{
    return [ITTXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}
@end
