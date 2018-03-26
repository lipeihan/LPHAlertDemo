//
//  LPHAlertAction.m
//  xiaobanlong
//
//  Created by Pierce on 2018/3/22.
//

#import "LPHAlertAction.h"

@implementation LPHAlertAction

+ (instancetype _Nullable )actionWithTitle:(NSString *_Nonnull)title {
    
    LPHAlertAction *action = [[LPHAlertAction alloc] init];
    action.title = title;
    
    return action;
}

+ (instancetype _Nullable )actionWithTitle:(NSString *_Nonnull)title
                                    action:(LPHAlertActionHandler _Nullable )alertAction {
    
    LPHAlertAction *action = [[LPHAlertAction alloc] init];
    action.title = title;
    action.actionHandler = alertAction;
    
    return action;
}

+ (instancetype _Nullable )actionWithTitle:(NSString *_Nonnull)title
                                    action:(LPHAlertActionHandler _Nullable )alertAction
                                  isCancel:(BOOL)isCancel {
    
    LPHAlertAction *action = [[LPHAlertAction alloc] init];
    action.title = title;
    action.actionHandler = alertAction;
    action.isCancel = isCancel;
    
    return action;
}

@end
