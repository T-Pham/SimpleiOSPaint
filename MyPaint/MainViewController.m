//
//  MainViewController.m
//  MyPaint
//
//  Created by Tam Tran Swink on 1/18/13.
//  Copyright (c) 2013 tpham. All rights reserved.
//

#import "MainViewController.h"
#import "PaintView.h"

@interface MainViewController ()

@end

@implementation MainViewController
{
    PaintView *paint;
}

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
    // Do any additional setup after loading the view from its nib.
    paint = [[PaintView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:paint];
    [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) [paint clearScreen];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
