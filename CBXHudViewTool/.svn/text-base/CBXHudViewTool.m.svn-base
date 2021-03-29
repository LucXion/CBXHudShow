//
//  CBXHudViewTool.m
//  CaiBao
//
//  Created by 陆正现 on 2018/3/26.
//  Copyright © 2018年 91cb. All rights reserved.
//

#import "CBXHudViewTool.h"

#import<objc/runtime.h>

#import "CBXChoseHudView.h"
#import "CBXNoticeHudView.h"
#import "CBXProgressHudView.h"

@interface CBXHudViewTool ()<CBXProgressHudViewDelegate,CBXChoseHudViewDelegate>

/**
 选择提示框
 */
@property(nonatomic,weak) CBXChoseHudView *choseHudView;

/**
 进度提示框
 */
@property(nonatomic,weak) CBXProgressHudView *progressHudView;

/**
 临时属性：点击选择提示框调用的block
 */
@property(nonatomic,strong)Block block;

@end

static CBXHudViewTool *shareInstance;

@implementation CBXHudViewTool

/**
 创建单例对象
 
 @return <#return value description#>
 */
+ (instancetype)shareHud {
    
    if (shareInstance == nil) {
        shareInstance = [[CBXHudViewTool alloc]init];
    }
    return shareInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [super allocWithZone:zone];
    });
    
    return shareInstance;
}



// 选择提示框
- (void)showHudWithContentTitle:(NSArray<NSString *> *)titleArr andFontArr:(NSArray<NSNumber *> *)fontArr andLeftChose:(NSString *)leftStr andLeftColor:(UIColor *)leftColor andRightChose:(NSString *)rightStr andRightColor:(UIColor *)rightColor inViewController:(UIViewController *)vc clickBlock:(Block)block{
    
    self.block = block;
    
    // 避免重复调用
    if (self.choseHudView == nil) {
        
        CBXChoseHudView *view= [[CBXChoseHudView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        if (fontArr.count > 0)
            view.titleFontArr = fontArr;
        view.titleArr = titleArr;
        view.leftTitle = leftStr;
        view.rightTitle = rightStr;
        if (leftColor != nil)
            view.leftColor = leftColor;
        if (rightColor != nil)
            view.rightColor = rightColor;
        
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        view.delegate = self;
        self.choseHudView = view;
        
        self.block = block;
        
    }
}

// 带图片提示框
- (void)showHudWithImage:(UIImage *)image andContent:(NSString *)content andTime:(int)time inVc:(UIViewController *)vc{
    
    CBXNoticeHudView *view= [[CBXNoticeHudView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    view.img = image;
    view.content = content;
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [view removeFromSuperview];
    });
    
}

// 进度提示框
- (void)showProgressHudViewWithContent:(NSString *)content andVc:(UIViewController *)vc {
    
    // 避免重复调用
    if (self.progressHudView == nil) {
        
        CBXProgressHudView *view= [[CBXProgressHudView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        view.contentStr = content;
        
        view.delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        
        self.progressHudView = view;
    }else {
        self.progressHudView.contentStr = content;
    }
}

// 展示成功提示框
- (void)showSuccessHudViewWithContent:(NSString *)content {
    
    // 避免重复调用
    if (self.progressHudView == nil) {
        
        CBXProgressHudView *view= [[CBXProgressHudView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        
        self.progressHudView = view;
    }
    
    [self.progressHudView showSuccese:content];
    
}

- (void)showFailHudViewWithContent:(NSString *)content {
    
    // 避免重复调用
    if (self.progressHudView == nil) {
        
        CBXProgressHudView *view= [[CBXProgressHudView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        
        self.progressHudView = view;
    }
    
    [self.progressHudView showFail:content];
}

/**
 手动隐藏view
 */
- (void)hiddeHud {
    
    
    [self.choseHudView removeFromSuperview];
    self.choseHudView = nil;
    
    [self.progressHudView removeFromSuperview];
    self.progressHudView = nil;
}

#pragma mark CBXProgressHudViewDelegate
- (void)hidProgressView {
    
    [self hiddeHud];
}

#pragma mark CBXChoseHudViewDelegate
- (void)clickLeftBtn {
    
    self.block(clickLeft);
}

- (void)clickRightBtn {
    
    self.block(clickRight);
}




@end
