//
//  MBProgressHUD+Add.m
//  HomeBox
//
//  Created by 王欣 on 16/8/18.
//  Copyright © 2016年 wangxin. All rights reserved.
//

#import "MBProgressHUD+Add.h"
static CGFloat const   kShowTime  = 60.0f;


@implementation MBProgressHUD (Add)
#pragma mark 显示信息
#define HudDelay 1.5f


+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    [self hideHUDForView:view];//加载新弹窗时,隐藏旧的弹窗
    [self hideHUDForView:[UIApplication sharedApplication].keyWindow];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text= text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:HudDelay];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view {

    view  = view ? view : [UIApplication sharedApplication].keyWindow;
    
    [self hideHUDForView:view];//加载新弹窗时,隐藏旧的弹窗
    [self hideHUDForView:[UIApplication sharedApplication].keyWindow];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.label.font         = [UIFont systemFontOfSize:15];
    hud.animationType       = MBProgressHUDAnimationFade;
    hud.square  = NO;;
    [hud hideAnimated:YES afterDelay:HudDelay];//过30秒没反应的话，自动消失
    // YES代表需要蒙版效果
    return hud;
}



+(MBProgressHUD*)showMessag:(NSString *)message toView:(UIView *)view WithDimBackGround:(BOOL)dimBackGround{
    
    MBProgressHUD * hud = [[self class]showMessag:message toView:view];

    if (dimBackGround) {
        hud.dimBackground = YES;
        hud.userInteractionEnabled = YES;
    }
    return hud;

}

+(void)showMiddleHint:(NSString *)hint {

    UIView * view = [UIApplication sharedApplication].keyWindow;

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];

    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = YES;
    hud.margin = 15;
    hud.labelText = hint;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hide:YES afterDelay:HudDelay];



}

+(void)showBottomHint:(NSString *)hint bottomOffsetY:(CGFloat)offsetY{ //目前暂时设置Y不起作用，MB好像做了限制
    [self showMiddleHint:hint];

}

+ (void)hideHudAnimatedWithView:(UIView *)view{
    view  = view ? view : [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view];
}

/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

-(void)hideWithDeleyWithMessage:(NSString*)message{
    self.mode = 5;
    self.labelText = message;
    [self hide:YES afterDelay:HudDelay];
}
-(void)hideShowSuccessWithMessage:(NSString*)message{
    self.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Checkmark"]];
    self.mode  = MBProgressHUDModeCustomView;
    self.square= YES;
    self.labelText = message;
    self.userInteractionEnabled = YES;
    [self hide:YES afterDelay:HudDelay];
}

-(void)hideShowWarningWithMessage:(NSString*)message{
    //HUDWarning
    self.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HUDWarning"]];
    self.mode  = MBProgressHUDModeCustomView;
    self.square= YES;
    self.labelText = message;
    self.userInteractionEnabled = YES;
    [self hide:YES afterDelay:HudDelay];
}

-(void)hideWithErrorWithMessage:(NSString*)message{
    self.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hudError"]];
    self.mode  = MBProgressHUDModeCustomView;
    self.labelText = message;
    self.square= YES;
    self.userInteractionEnabled = YES;
    [self hide:YES afterDelay:HudDelay];

}
/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view
{
    view  = view ? view : [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:YES];
}

@end
