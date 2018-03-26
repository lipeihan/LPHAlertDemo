//
//  LPHAlertAction.h
//  xiaobanlong
//
//  Created by Pierce on 2018/3/22.
//

#import <Foundation/Foundation.h>

typedef void (^LPHAlertActionHandler)();

@interface LPHAlertAction : NSObject

@property (nonatomic, copy) NSString * _Nonnull title;
@property (nonatomic, copy) LPHAlertActionHandler _Nullable actionHandler;

@property (nonatomic, assign) BOOL isCancel;

+ (instancetype _Nullable )actionWithTitle:(NSString *_Nonnull)title;

+ (instancetype _Nullable )actionWithTitle:(NSString *_Nonnull)title
                                    action:(LPHAlertActionHandler _Nullable )alertAction;

+ (instancetype _Nullable )actionWithTitle:(NSString *_Nonnull)title
                                    action:(LPHAlertActionHandler _Nullable )alertAction
                                  isCancel:(BOOL)isCancel;

@end
