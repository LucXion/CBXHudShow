//
//  CBXProgressHudView.h
//  CaiBao
//
//  Created by 陆正现 on 2018/3/26.
//  Copyright © 2018年 91cb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CBXProgressHudViewDelegate

- (void)hidProgressView;

@end

@interface CBXProgressHudView : UIView

@property(nonatomic,weak)id<CBXProgressHudViewDelegate> delegate;

- (void)showSuccese:(NSString*)succese;

- (void)showFail:(NSString*)fail;

@property(nonatomic,copy)NSString *contentStr;

@end
