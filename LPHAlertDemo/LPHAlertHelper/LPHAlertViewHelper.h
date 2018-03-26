//
//  LPHAlertViewHelper.h
//  xiaobanlong
//
//  Created by Pierce on 2018/3/22.
//

#import <UIKit/UIKit.h>

#import "LPHAlertAction.h"

@interface LPHAlertViewHelper : NSObject

/**
 弹出一个有两个按键的弹窗
 
 @param title 弹窗的标题
 @param msg 弹窗的Message
 @param cancelAction 取消按钮的title和回调
 @param sureAction 确认按钮的title和回调
 @param rootVC 弹出该弹窗的VC，在UIAlertController中使用，如果传空，则是使用UIAlertView弹窗
 */
+ (void)showAlert:(NSString *_Nullable)title
              msg:(NSString *_Nullable)msg
           cancel:(LPHAlertAction *_Nullable)cancelAction
             sure:(LPHAlertAction*_Nullable)sureAction
           rootVC:(UIViewController *_Nullable)rootVC;


/**
 弹出一个只有一个按钮的弹窗
 
 @param title 弹窗的标题
 @param msg 弹窗的Message
 @param cancelAction 取消按钮的title和回调
 @param rootVC 弹出该弹窗的VC，在UIAlertController中使用，如果传空，则是使用UIAlertView弹窗
 */
+ (void)showOnlyCancelBtnAlert:(NSString *_Nullable)title
                           msg:(NSString *_Nullable)msg
                        cancel:(LPHAlertAction*_Nullable)cancelAction
                        rootVC:(UIViewController *_Nullable)rootVC;

/**
 弹出一个只有一个按钮的弹窗，点击取消有不带回调
 
 @param title 弹窗的标题
 @param msg 弹窗的Message
 @param cancelTitle 取消按钮的title
 @param rootVC 弹出该弹窗的VC，在UIAlertController中使用，如果传空，则是使用UIAlertView弹
 */
+ (void)showOnlyCancelBtnAlert:(NSString *_Nullable)title
                           msg:(NSString *_Nullable)msg
                   cancelTitle:(NSString*_Nullable)cancelTitle
                        rootVC:(UIViewController *_Nullable)rootVC;


/**
 弹出一个弹窗，可以支持带多个按钮
 
 @param rootVC 弹出该弹窗的VC，在UIAlertController中使用，如果传空，则是使用UIAlertView弹
 @param title 弹窗的标题
 @param message 弹窗的Message
 @param firstActions 第一个按钮一般放取消。
 */
+ (void)showAlertAtRootVC:(UIViewController *_Nullable)rootVC
                    title:(NSString *_Nullable)title
                  message:(NSString *_Nullable)message
            buttonActions:(LPHAlertAction *_Nullable)firstActions, ... NS_REQUIRES_NIL_TERMINATION;

@end
