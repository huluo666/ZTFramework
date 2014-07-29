/*
 ============================================================================
 Name           : TCTableView.m
 Author         : ZTFramework框架
 Version        : 1.0
 Copyright      : 同城
 Description    : ZTTableView declaration
 ============================================================================
 */

#import "ZTTableView.h"
#import "ZTTableMoreCell.h"

@implementation ZTTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor = [UIColor clearColor];
        
        if (DEVICE_IOS_6) {
            self.backgroundView = nil;
        }
    }
    
    return self;
}

- (void)setState:(ZTTableViewState)val {

    [moreCell stateView:val];
    
    state = val;
}



@synthesize moreCell;
@synthesize state;
@end
