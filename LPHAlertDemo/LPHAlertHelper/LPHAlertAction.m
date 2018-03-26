//
//  LPHAlertAction.m
//  xiaobanlong
//
//  Created by Pierce on 2018/3/22.
//

#import "LPHAlertAction.h"

@implementation LPHAlertAction

- (instancetype)initWithTitle:(NSString *)title {
    
    return [self initWithTitle:title
                        action:nil];
}

- (instancetype)initWithTitle:(NSString *)title
                       action:(LPHAlertActionHandler)alertAction {
    
    return [self initWithTitle:title
                        action:alertAction
                      isCancel:NO];
}

- (instancetype)initWithTitle:(NSString *)title
                       action:(LPHAlertActionHandler)alertAction
                     isCancel:(BOOL)isCancel {
    
    self = [super init];
    if (self) {
        _title = title;
        _actionHandler = alertAction;
        _isCancel = isCancel;
    }
    return self;
}

@end
