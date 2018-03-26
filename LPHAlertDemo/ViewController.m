//
//  ViewController.m
//  LPHAlertDemo
//
//  Created by Pierce on 2018/3/22.
//  Copyright © 2018年 Pierce. All rights reserved.
//

#import "ViewController.h"

#import "LPHAlertViewHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)clickCancleTitleBtnAction:(UIButton *)sender {
    
    [LPHAlertViewHelper showOnlyCancelBtnAlert:@"测试alert标题"
                                           msg:@"测试alert message cancelTitle"
                                   cancelTitle:@"确定"
                                        rootVC:nil];
}

- (IBAction)clickCancelActionBtnAction:(UIButton *)sender {
    
    LPHAlertAction *cancelAction = [LPHAlertAction actionWithTitle:@"确定"
                                                            action:^{
                                                                NSLog(@"点击了确定按钮");
                                                            } isCancel:YES];
    
    [LPHAlertViewHelper showOnlyCancelBtnAlert:@"测试alert标题"
                                           msg:@"测试alert message cancelaction"
                                        cancel:cancelAction
                                        rootVC:nil];
}

- (IBAction)clickCancelSureBtnAction:(UIButton *)sender {
    
    LPHAlertAction *cancelAction = [LPHAlertAction actionWithTitle:@"取消"
                                                            action:^{
                                                                NSLog(@"点击了取消按钮");
                                                            } isCancel:YES];
    
    LPHAlertAction *sureAction = [LPHAlertAction actionWithTitle:@"确定"
                                                          action:^{
                                                              NSLog(@"点击了确定按钮");
                                                          }];
    
    [LPHAlertViewHelper showAlert:@"测试alert标题"
                              msg:@"测试alert cancel sure"
                           cancel:cancelAction
                             sure:sureAction
                           rootVC:nil];
}

- (IBAction)clickMultiButtonAction:(UIButton *)sender {
    
    LPHAlertAction *cancelAction = [LPHAlertAction actionWithTitle:@"取消"
                                                            action:^{
                                                                NSLog(@"点击了取消按钮");
                                                            } isCancel:YES];
    
    LPHAlertAction *action1 = [LPHAlertAction actionWithTitle:@"按钮1"
                                                       action:^{
                                                           NSLog(@"点击了按钮1");
                                                       }];
    
    LPHAlertAction *action2 = [LPHAlertAction actionWithTitle:@"按钮2"
                                                       action:^{
                                                           NSLog(@"点击了按钮2");
                                                       }];
    
    LPHAlertAction *action3 = [LPHAlertAction actionWithTitle:@"按钮3"
                                                       action:^{
                                                           NSLog(@"点击了按钮3");
                                                       }];
    
    [LPHAlertViewHelper showAlertAtRootVC:nil
                                    title:@"测试alert标题"
                                  message:@"测试alert message multi"
                            buttonActions:cancelAction,action1,action2,action3, nil];
}

@end
