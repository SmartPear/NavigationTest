//
//  MBProgressHUD+Add.h
//  HomeBox
//
//  Created by 王欣 on 16/8/18.
//  Copyright © 2016年 wangxin. All rights reserved.
//


#import <MBProgressHUD/MBProgressHUD.h>
@interface MBProgressHUD (Add)

+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;

+ (void)hideHUD;

+ (void)hideHUDForView:(UIView *)view;

+ (void)showMiddleHint:(NSString *)hint;//显示提示文字再屏幕中央

+ (void)showBottomHint:(NSString *)hint bottomOffsetY:(CGFloat)offsetY; //显示提示文字在屏幕底部

- (void)hideWithDeleyWithMessage:(NSString*)meassge;

//显示成功状态并隐藏
- (void)hideShowSuccessWithMessage:(NSString*)message;

//显示失败状态并隐藏
- (void)hideWithErrorWithMessage:(NSString*)message;

//显示警告状态并隐藏
- (void)hideShowWarningWithMessage:(NSString*)message;




/**
 添加可带遮罩效果的hud
 @param message 显示文字
 @param view hud要添加到的视图
 @param dimBackGround 是否有遮罩效果
 @return
 */
+(MBProgressHUD*)showMessag:(NSString *)message toView:(UIView *)view WithDimBackGround:(BOOL)dimBackGround;


@end
