//
//  LPHAlertViewHelper.m
//  xiaobanlong
//
//  Created by Pierce on 2018/3/22.
//

#import "LPHAlertViewHelper.h"
#import <objc/runtime.h>

//only For iOS7
static NSString * const LPHAlertActionKey = @"LPHAlertActionKey";
typedef void(^LPHAlertViewBlock)(NSInteger buttonIndex);

@interface LPHAlertViewHelper () <UIAlertViewDelegate>

@end

@implementation LPHAlertViewHelper

#pragma mark - Public Methods

+ (void)showOnlyCancelBtnAlert:(NSString *_Nullable)title
                           msg:(NSString *_Nullable)msg
                   cancelTitle:(NSString*_Nullable)cancelTitle
                        rootVC:(UIViewController *_Nullable)rootVC {
    
    LPHAlertAction *cancelAction = [[LPHAlertAction alloc] initWithTitle:cancelTitle
                                                                  action:nil
                                                                isCancel:YES];
    [self showOnlyCancelBtnAlert:title
                             msg:msg
                          cancel:cancelAction
                          rootVC:rootVC];
}

+ (void)showOnlyCancelBtnAlert:(NSString *_Nullable)title
                           msg:(NSString *_Nullable)msg
                        cancel:(LPHAlertAction*_Nullable)cancelAction
                        rootVC:(UIViewController *_Nullable)rootVC {
    
    [self showAlertAtRootVC:rootVC
                      title:title
                    message:msg
              buttonActions:cancelAction,nil];
}

+ (void)showAlert:(NSString *_Nullable)title
              msg:(NSString *_Nullable)msg
           cancel:(LPHAlertAction *_Nullable)cancelAction
             sure:(LPHAlertAction*_Nullable)sureAction
           rootVC:(UIViewController *_Nullable)rootVC {
    
        [self showAlertAtRootVC:rootVC
                          title:title
                        message:msg
                  buttonActions:cancelAction,sureAction,nil];
}

+ (void)showAlertAtRootVC:(UIViewController *_Nullable)rootVC
                    title:(NSString *_Nullable)title
                  message:(NSString *_Nullable)message
            buttonActions:(LPHAlertAction *_Nullable)firstActions, ... NS_REQUIRES_NIL_TERMINATION {
    
    NSMutableArray <LPHAlertAction *> *actionList = [NSMutableArray array];
    // 定义一个指向可选参数列表的指针
    va_list actions;
    
    // 获取第一个可选参数的地址，此时参数列表指针指向函数参数列表中的第一个可选参数
    va_start(actions, firstActions);
    if (firstActions) {
        [actionList addObject:firstActions];
        // 遍历参数列表中的参数，并使参数列表指针指向参数列表中的下一个参数
        LPHAlertAction *nextAction;
        while ((nextAction = va_arg(actions, LPHAlertAction *))) {
            [actionList addObject:nextAction];
        }
    }
    // 结束可变参数的获取(清空参数列表)
    va_end(actions);
    
    [self showAlertAtRootVC:rootVC
                      title:title
                    message:message
                 actionList:actionList];
}

+ (void)showAlertAtRootVC:(UIViewController *)rootVC
                    title:(NSString *)title
                  message:(NSString *)message
               actionList:(NSArray<LPHAlertAction *> *)actionList {
    
    if (!actionList.count) {
        return;
    }
    
    if (rootVC) {
        if (@available(iOS 8_0, *)) {
            
            [self showAlertForIOS8AtRootVC:rootVC
                                     title:title
                                   message:message
                             buttonActions:actionList];
            return;
        }
    }
    
    [self showAlertForIos7withTitle:title
                            message:message
                      buttonActions:actionList];
}

#pragma mark - Private iOS8 Methods
+ (void)showAlertForIOS8AtRootVC:(UIViewController *)rootVC
                           title:(NSString *)title
                         message:(NSString *)message
                   buttonActions:(NSArray<LPHAlertAction *> *)actionList NS_AVAILABLE_IOS(8_0) {
    
    if (!rootVC) {
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    for (LPHAlertAction *alertAction in actionList) {
        [self addLPHAlertAction:alertAction intoAlert:alert];
    }
    
    [rootVC presentViewController:alert
                         animated:YES
                       completion:nil];
}

+ (void)addLPHAlertAction:(LPHAlertAction *)alertAction
                intoAlert:(UIAlertController *)alert NS_AVAILABLE_IOS(8_0) {
    
    if (!alertAction) {
        return;
    }
        
    UIAlertActionStyle style = alertAction.isCancel ? UIAlertActionStyleCancel : UIAlertActionStyleDefault;
    
    UIAlertAction *alertActionForUI = [UIAlertAction actionWithTitle:alertAction.title
                                                               style:style
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 
                                                                 if (alertAction.actionHandler) {
                                                                     alertAction.actionHandler();
                                                                 }
                                                             }];
    
    [alert addAction:alertActionForUI];
}

#pragma mark - Private iOS7 Methods

+ (instancetype)sharedInstance {
    
    static id shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[super alloc] init];
    });
    
    return shared;
}

+ (void)showAlertForIos7withTitle:(NSString *)title
                          message:(NSString *)message
                    buttonActions:(NSArray<LPHAlertAction *> *)actionList {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[LPHAlertViewHelper sharedInstance]
                                          cancelButtonTitle:actionList.firstObject.title
                                          otherButtonTitles:nil];
    
    for (NSInteger i = 1; i < actionList.count; i++) {
        
        [alert addButtonWithTitle:actionList[i].title];
    }
    
    LPHAlertViewBlock actionBlock = ^(NSInteger buttonIndex) {
        
        if (actionList[buttonIndex].actionHandler) {
            actionList[buttonIndex].actionHandler();
        }
    };
    
    objc_setAssociatedObject(alert,
                             (__bridge const void * _Nonnull)(LPHAlertActionKey),
                             actionBlock,
                             OBJC_ASSOCIATION_COPY);
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView
didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    LPHAlertViewBlock actionBlock = objc_getAssociatedObject(alertView,
                                                             (__bridge const void * _Nonnull)(LPHAlertActionKey));
    actionBlock (buttonIndex);
}

@end
