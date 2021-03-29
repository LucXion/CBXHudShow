//
//  CBXNoticeHudView.m
//  精品课
//
//  Created by 陆正现 on 2018/3/1.
//  Copyright © 2018年 陆正现. All rights reserved.
//

#import "CBXNoticeHudView.h"

@interface CBXNoticeHudView ()

@property(nonatomic,weak)UIImageView *imgView;

@property(nonatomic,weak)UILabel *contentLable;

@end


@implementation CBXNoticeHudView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        
        CGFloat kscreenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat kscreenHeight = [UIScreen mainScreen].bounds.size.height;
        
        // 半透明背景
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kscreenWidth, kscreenHeight)];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.4;
        backView.userInteractionEnabled = YES;
        
        [self addSubview:backView];
        
        
        // 提示框
        UIView *hudView = [[UIView alloc]initWithFrame:CGRectMake((kscreenWidth - 250) / 2.f, (kscreenHeight - 129 - 64) / 2.f, 250, 129)];
        hudView.backgroundColor = [UIColor whiteColor];
        hudView.layer.cornerRadius = 5;
        hudView.layer.masksToBounds = YES;
        
        [self addSubview:hudView];
        
        // 添加提示图片
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(110, 25, 30, 30)];
        
        [hudView addSubview:imgView];
        self.imgView = imgView;
        
        // 添加提示
        UILabel *promptLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame) + 22, 250, 16)];
        promptLable.font = [UIFont systemFontOfSize:15];
        promptLable.textColor = [UIColor blackColor];
        promptLable.textAlignment = NSTextAlignmentCenter;
        
        [hudView addSubview:promptLable];
        self.contentLable = promptLable;
    }
    
    return self;
}


- (void)setImg:(UIImage *)img {
    
    _img = img;
    self.imgView.image = img;
}

- (void)setContent:(NSString *)content {
    
    _content = content;
    self.contentLable.text = content;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
