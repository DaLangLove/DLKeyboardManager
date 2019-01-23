//
//  ViewController.m
//  Example
//
//  Created by Dalang on 2019/1/22.
//  Copyright © 2019 Dalang. All rights reserved.
//

#import "ViewController.h"
#import "DLKeyboardManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    DLKeyboardManager *manager = [DLKeyboardManager sharedManager];
    
    [manager registerForEvent:DLKeyboardEventWillShow
                     callBack:^(DLKeyboardInformation * _Nonnull info) {
                         NSLog(@"\n");
                         NSLog(@"DLKeyboardEventWillShow");
                         NSLog(@"%@", info);
                     }];
    [manager registerForEvent:DLKeyboardEventDidShow
                     callBack:^(DLKeyboardInformation * _Nonnull info) {
                         NSLog(@"\n");
                         NSLog(@"DLKeyboardEventDidShow");
                         NSLog(@"%@", info);
                     }];
    [manager registerForEvent:DLKeyboardEventWillHide
                     callBack:^(DLKeyboardInformation * _Nonnull info) {
                         NSLog(@"\n");
                         NSLog(@"DLKeyboardEventWillHide");
                         NSLog(@"%@", info);
                     }];
    [manager registerForEvent:DLKeyboardEventDidHide
                     callBack:^(DLKeyboardInformation * _Nonnull info) {
                         NSLog(@"\n");
                         NSLog(@"DLKeyboardEventDidHide");
                         NSLog(@"%@", info);
                     }];
    [manager registerForEvent:DLKeyboardEventWillChangeFrame
                     callBack:^(DLKeyboardInformation * _Nonnull info) {
                         NSLog(@"\n");
                         NSLog(@"DLKeyboardEventWillChangeFrame");
                         NSLog(@"%@", info);
                     }];
    [manager registerForEvent:DLKeyboardEventDidChangeFrame
                     callBack:^(DLKeyboardInformation * _Nonnull info) {
                         NSLog(@"\n");
                         NSLog(@"DLKeyboardEventDidChangeFrame");
                         NSLog(@"%@", info);
                     }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[DLKeyboardManager sharedManager] cancellationAllEvents];
}

- (IBAction)hideKeyboard:(id)sender {
    
    [self.view endEditing:YES];
    
}

@end
