//
//  CBXChoseHudView.h
//  tishikuang
//
//  Created by 陆正现 on 2018/2/28.
//  Copyright © 2018年 陆正现. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CBXChoseHudViewDelegate <NSObject>

- (void)clickLeftBtn;

- (void)clickRightBtn;

@end


@interface CBXChoseHudView : UIView

@property(nonatomic,weak)id<CBXChoseHudViewDelegate> delegate;

/**
 标题数组 （最多显示5行，不在多做适配）
 */
@property(nonatomic,strong)NSArray <NSString*>*titleArr;

/**
 每一行的字体大小
 */
@property(nonatomic,strong)NSArray <NSNumber*>*titleFontArr;

@property(nonatomic,copy)NSString *leftTitle;

@property(nonatomic,copy)NSString *rightTitle;

@property(nonatomic,strong)UIColor *leftColor;

@property(nonatomic,strong)UIColor *rightColor;

@end
