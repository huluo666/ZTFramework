//
//  debugVC.m
//  ZTFrameworkRun
//
//  Created by Fighting on 14-8-20.
//  Copyright (c) 2014年 Fighting. All rights reserved.
//

#import "debugVC.h"

@interface debugVC ()

@end

@implementation debugVC

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
    
    self.title = @"DEBUG 示例";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionClickEvent:(id)sender {
    UIButton * btn = (UIButton *)sender;
    
    switch (btn.tag) {
        case 1:
            
            ZTLog(@"ZTFramework debug: tag ===> %d", btn.tag);
            
            ZTLogD(@"ZTFramework debug: tag ===> %d", btn.tag);
            
            NSLog(@"ZTFramework debug: tag ===> %d", btn.tag);
            
            ZTLogSelf
            
            break;
            
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
