//
//  CBXChoseHudView.m
//  tishikuang
//
//  Created by 陆正现 on 2018/2/28.
//  Copyright © 2018年 陆正现. All rights reserved.
//

#import "CBXChoseHudView.h"

@interface CBXChoseHudView ()

@property(nonatomic,weak)UIButton *leftBtn;

@property(nonatomic,weak)UIButton *rightBtn;

@property(nonatomic,strong)NSMutableArray <UILabel*>*lableArr;

@end


@implementation CBXChoseHudView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame: frame];
    
    if (self != nil) {
        
        CGFloat kscreenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kscreenHeight = [UIScreen mainScreen].bounds.size.height;
        
        // 半透明背景
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight)];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.4;
        backView.userInteractionEnabled = YES;
        
        // 添加点击移除手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popViewGestureRecognizer)];
        [backView addGestureRecognizer:tap]; // 将手势识别器添加到对象上
        
        [self addSubview:backView];
        
        
        // 提示框
        UIView *hudView = [[UIView alloc]initWithFrame:CGRectMake((kscreenWidth - 250) / 2.f, (kscreenHeight - 129 - 64) / 2.f, 250, 129)];
        hudView.backgroundColor = [UIColor whiteColor];
        hudView.layer.cornerRadius = 5;
        hudView.layer.masksToBounds = YES;
        
        [self addSubview:hudView];
        
        // 提示框添加弹出动画
        hudView.alpha = 0;
        hudView.transform = CGAffineTransformScale(hudView.transform,0.1,0.1);
        [UIView animateWithDuration:0.3 animations:^{
            hudView.transform = CGAffineTransformIdentity;
            hudView.alpha = 1;
        }];
        
        // 底部按钮分隔线
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 129 - 44, kscreenWidth, 1)];
        line1.backgroundColor = [UIColor colorWithRed:228/255.f green:228/255.f blue:228/255.f alpha:1];
        
        [hudView addSubview:line1];
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(125, CGRectGetMaxY(line1.frame), 1, 44)];
        line2.backgroundColor = line1.backgroundColor;
        
        [hudView addSubview:line2];
        
        // 添加按钮
        UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line1.frame), 125, 44)];
        [leftBtn addTarget:self action:@selector(clickLeftBtnIn:) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [hudView addSubview:leftBtn];
        self.leftBtn = leftBtn;
        
        UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(125, CGRectGetMaxY(line1.frame), 125, 44)];
        [rightBtn addTarget:self action:@selector(clickRightBtnIn:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [hudView addSubview:rightBtn];
        self.rightBtn = rightBtn;
        
        // 添加5行标题显示
        self.lableArr = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectZero];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.font = [UIFont systemFontOfSize:15];
            lable.textColor = [UIColor blackColor];
            
            [hudView addSubview:lable];
            [self.lableArr addObject:lable];
        }
    }
    
    return self;
}

/**
 移除提示框
 */
- (void)popViewGestureRecognizer {
    
    [self removeFromSuperview];
}

#pragma mark 点击事件
- (void)clickLeftBtnIn:(UIButton*)sender {

    if ([self.delegate respondsToSelector:@selector(clickLeftBtn)]) {
        [self.delegate clickLeftBtn];
    }
    
    [self popViewGestureRecognizer];
}

- (void)clickRightBtnIn:(UIButton*)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickRightBtn)]) {
        [self.delegate clickRightBtn];
    }
    
    [self popViewGestureRecognizer];
}

- (void)setLeftTitle:(NSString *)leftTitle {
    
    _leftTitle = leftTitle;
    [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
}

- (void)setRightTitle:(NSString *)rightTitle {
    
    _rightTitle = rightTitle;
    [self.rightBtn setTitle:rightTitle forState:UIControlStateNormal];
}

- (void)setLeftColor:(UIColor *)leftColor {
    
    _leftColor = leftColor;
    [self.leftBtn setTitleColor:leftColor forState:UIControlStateNormal];
}

- (void)setRightColor:(UIColor *)rightColor {
    
    _rightColor = rightColor;
    [self.rightBtn setTitleColor:rightColor forState:UIControlStateNormal];
}

- (void)setTitleArr:(NSArray<NSString *> *)titleArr {
    
    _titleArr = titleArr;
    
    int count = MIN((unsigned)titleArr.count, 5);
    // 布局
    CGFloat margin = 5;
    CGFloat height = 0;
    // 根据标题的个数，还有对应lable的字体大小，得出标题总高度
    for (int i = 0; i < count; i++) {
        UILabel *lable = self.lableArr[i];
        UIFont *font = lable.font;
        height += (font.pointSize + margin + 1);
    }
    
    // 布局lable
    CGFloat top =(129 - 44 - height + margin) / 2.f;
    for (int i = 0; i < count; i++) {
        UILabel *lable = self.lableArr[i];
        lable.text = titleArr[i];
        if (i == 0) {
            lable.frame = CGRectMake(0, top, 250, lable.font.pointSize + 1);
        }else {
            UILabel *beforLable = self.lableArr[i - 1];
            lable.frame = CGRectMake(0, CGRectGetMaxY(beforLable.frame) + margin, 250, lable.font.pointSize + 1);
        }
    }
    
}


- (void)setTitleFontArr:(NSArray<NSNumber *> *)titleFontArr {
    
    _titleFontArr = titleFontArr;
    
    int count = MIN((unsigned)titleFontArr.count, 5);
    // 设置字体
    for (int i = 0; i < count; i++) {
        NSNumber *fontnum = titleFontArr[i];
        UILabel *lable = self.lableArr[i];
        lable.font = [UIFont systemFontOfSize:fontnum.intValue];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
