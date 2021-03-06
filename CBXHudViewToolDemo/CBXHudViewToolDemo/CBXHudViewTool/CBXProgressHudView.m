//
//  CBXProgressHudView.m
//  CaiBao
//
//  Created by 陆正现 on 2018/3/26.
//  Copyright © 2018年 91cb. All rights reserved.
//

#import "CBXProgressHudView.h"

@interface CBXProgressHudView ()

@property(nonatomic,weak)UIView *hudBackView;

@property(nonatomic,weak)UIView *hudProgressView;

@property(nonatomic,weak)UILabel *contentLable;

@end

static NSInteger STROKE_WIDTH = 3;

@implementation CBXProgressHudView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame: frame];
    if (self) {
        
        [self showHud];
        
    }
    return self;
}

- (void)showHud {
    
    // 添加提示框背景
    UIView *viewBack = [[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 100, [UIScreen mainScreen].bounds.size.height / 2 - 164, 200, 125)];
    
    viewBack.backgroundColor = [UIColor whiteColor];
    viewBack.layer.cornerRadius = 5;
    viewBack.layer.masksToBounds = YES;
    
    // 添加弹出动画
    viewBack.alpha = 0;
    viewBack.transform = CGAffineTransformScale(viewBack.transform,0.1,0.1);
    [UIView animateWithDuration:0.3 animations:^{
        viewBack.transform = CGAffineTransformIdentity;
        viewBack.alpha = 1;
    }];
    
    [self addSubview:viewBack];
    self.hudBackView = viewBack;
    
    // 提示框内容
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, 200, 15)];
    lable.textColor = [UIColor blackColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:15];
    
    [self.hudBackView addSubview:lable];
    self.contentLable = lable;
    
    // 添加加载中的提示框
    UIView *viewProgress = [[UIView alloc]initWithFrame:CGRectMake(200 / 2 - 25, 20, 50, 50)];
    viewProgress.layer.cornerRadius = 25;
    
    [viewBack addSubview:viewProgress];
    self.hudProgressView = viewProgress;
    
    // 绘制外部透明的圆形
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter: CGPointMake(viewProgress.frame.size.width / 2, viewProgress.frame.size.height / 2) radius:viewProgress.frame.size.width / 2  startAngle:  0 * M_PI/180 endAngle: 360 * M_PI/180 clockwise: NO];
    // 创建外部透明圆形的图层
    CAShapeLayer *alphaLineLayer = [CAShapeLayer layer];
    alphaLineLayer.path = circlePath.CGPath;// 设置透明圆形的绘图路径
    alphaLineLayer.strokeColor = [UIColor colorWithRed:245/255.f green:245/255.f blue:250/255.f alpha:1].CGColor;
    // ↑ 设置图层的透明圆形的颜色，取图标颜色之后设置其对应的0.1透明度的颜色
    alphaLineLayer.lineWidth = STROKE_WIDTH;// 设置圆形的线宽
    alphaLineLayer.fillColor = [UIColor clearColor].CGColor;// 填充颜色透明
    
    [viewProgress.layer addSublayer: alphaLineLayer];
    
    // 创建 CAShapeLayer 对象
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = viewProgress.bounds;
    // 根据frame 获取内切圆弧路径
    //    UIBezierPath *Spath = [UIBezierPath bezierPathWithOvalInRect:view.bounds];
    // 可以设置起点 和 旋转角度
    UIBezierPath *Spath = [UIBezierPath bezierPath];
    [Spath addArcWithCenter: CGPointMake(viewProgress.frame.size.width / 2, viewProgress.frame.size.height / 2) radius:viewProgress.frame.size.width / 2 startAngle: 90 * M_PI / 180 endAngle: 450 * M_PI / 180 clockwise: YES];
    
    shapeLayer.path = Spath.CGPath;
    // 内部填充颜色
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    // 线条宽度
    shapeLayer.lineWidth = 3.0f;
    // 线条颜色
    shapeLayer.strokeColor = [UIColor colorWithRed:66/255.f green:213/255.f blue:81/255.f alpha:1].CGColor;
    
    
    shapeLayer.lineCap = kCALineCapRound;
    
    // 添加到视图上
    [viewProgress.layer addSublayer:shapeLayer];
    
    // 给 CAShapeLayer 添加动画
    // 基于三次曲线的定时函数<设置动画曲线> (float)c1x :(float)c1y :(float)c2x :(float)c2y
    CAMediaTimingFunction *progressRotateTimingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 :0.80 :0.75 :1.00];
    // 开始画线的动画
    CABasicAnimation *progressLongAnimation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    // 开始的 百分比 弧度  0 为圆右切点
    progressLongAnimation.fromValue = [NSNumber numberWithFloat: 0.0];
    // 结束的 百分比 弧度
    progressLongAnimation.toValue = [NSNumber numberWithFloat: 1.0];
    progressLongAnimation.duration = 2;
    progressLongAnimation.timingFunction = progressRotateTimingFunction;
    progressLongAnimation.repeatCount = CGFLOAT_MAX;
    
    // 填充整个圆圈的线条
    [shapeLayer addAnimation:progressLongAnimation forKey: @"strokeEnd"];
    
    // 线条逐渐变短收缩的动画
    CABasicAnimation *progressLongEndAnimation = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
    progressLongEndAnimation.fromValue = [NSNumber numberWithFloat: 0.0];
    progressLongEndAnimation.toValue = [NSNumber numberWithFloat: 1.0];
    progressLongEndAnimation.duration = 2;
    CAMediaTimingFunction *strokeStartTimingFunction = [[CAMediaTimingFunction alloc] initWithControlPoints: 0.65 : 0.0 :1.0 : 1.0];
    progressLongEndAnimation.timingFunction = strokeStartTimingFunction;
    progressLongEndAnimation.repeatCount = CGFLOAT_MAX;
    
    [shapeLayer addAnimation: progressLongEndAnimation forKey: @"strokeStart"];
}


- (void)showSuccese:(NSString *)succese {
    
    [self.hudProgressView removeFromSuperview];
    self.contentLable.text = succese;
    
    // 移除整个进度界面，使方法可以单独使用
    UIView *viewProgress = [[UIView alloc]initWithFrame:CGRectMake(200 / 2 - 25, 20, 50, 50)];
    viewProgress.layer.cornerRadius = 25;
    
    [self.hudBackView addSubview:viewProgress];
    self.hudProgressView = viewProgress;
    
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter: CGPointMake(self.hudProgressView.frame.size.width / 2, self.hudProgressView.frame.size.height / 2) radius:self.hudProgressView.frame.size.width / 2  startAngle:  0 * M_PI/180 endAngle: 360 * M_PI/180 clockwise: NO];
    
    // 创建外部透明圆形的图层
    CAShapeLayer *alphaLineLayer = [CAShapeLayer layer];
    alphaLineLayer.path = circlePath.CGPath;// 设置透明圆形的绘图路径
    alphaLineLayer.strokeColor = [UIColor colorWithRed:66/255.f green:213/255.f blue:81/255.f alpha:1].CGColor;
    // ↑ 设置图层的透明圆形的颜色，取图标颜色之后设置其对应的0.1透明度的颜色
    alphaLineLayer.lineWidth = STROKE_WIDTH;// 设置圆形的线宽
    alphaLineLayer.fillColor = [UIColor clearColor].CGColor;// 填充颜色透明
    
    [self.hudProgressView.layer addSublayer: alphaLineLayer];
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.hudProgressView.bounds;
    
    // 线条颜色
    shapeLayer.strokeColor = [UIColor colorWithRed:66/255.f green:213/255.f blue:81/255.f alpha:1].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;// 填充颜色透明
    
    // 圆角画笔
    shapeLayer.lineCap = kCALineCapRound;
    
    shapeLayer.lineWidth = STROKE_WIDTH;
    
    // 2. 半圆+动画的绘制路径初始化
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 绘制大半圆
    [path addArcWithCenter: CGPointMake(shapeLayer.frame.size.width / 2, shapeLayer.frame.size.height / 2) radius:shapeLayer.frame.size.width / 2  startAngle:  67 * M_PI / 180 endAngle: 202 * M_PI / 180 clockwise: YES];

    // 绘制对号第一笔
    [path addLineToPoint: CGPointMake(shapeLayer.frame.size.width * 0.42, shapeLayer.frame.size.width * 0.68)];
    // 绘制对号第二笔
    [path addLineToPoint: CGPointMake(shapeLayer.frame.size.width * 0.77, shapeLayer.frame.size.width * 0.35)];
    // 把路径设置为当前图层的路径
    shapeLayer.path = path.CGPath;
    
    // 基于三次曲线的定时函数 (float)c1x :(float)c1y :(float)c2x :(float)c2y
    CAMediaTimingFunction *timing = [[CAMediaTimingFunction alloc] initWithControlPoints:0.3 :0.6 :0.8 :1.1];
    
    // 创建路径顺序绘制的动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    animation.duration = 0.5;// 动画使用时间
    animation.fromValue = [NSNumber numberWithInt: 0.0];// 从头
    animation.toValue = [NSNumber numberWithInt: 1.0];// 画到尾
    
    // 创建路径顺序从结尾开始消失的动画
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
    // 动画使用时间
    strokeStartAnimation.duration = 0.4;
    // 延迟0.2秒执行动画
    strokeStartAnimation.beginTime = CACurrentMediaTime() + 0.2;
    // 从开始消失
    strokeStartAnimation.fromValue = [NSNumber numberWithFloat: 0.0];
    // 一直消失到整个绘制路径的74%，这个数没有啥技巧，一点点调试看效果，希望看此代码的人不要被这个数值怎么来的困惑
    strokeStartAnimation.toValue = [NSNumber numberWithFloat: 0.66];
    strokeStartAnimation.timingFunction = timing;
    
    // 设置最终效果，防止动画结束之后效果改变
    shapeLayer.strokeStart = 0.66;
    shapeLayer.strokeEnd = 1.0;
    
    [shapeLayer addAnimation: animation forKey: @"strokeEnd"];// 添加俩动画
    [shapeLayer addAnimation: strokeStartAnimation forKey: @"strokeStart"];
    
    [self.hudProgressView.layer addSublayer:shapeLayer];
    
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf removeView];
    });
    
}

- (void)showFail:(NSString *)fail {
    
    // 移除进度的动画
    [self.hudProgressView removeFromSuperview];
    self.contentLable.text = fail;
    
    // 移除整个进度界面，使方法可以单独使用
    UIView *viewProgress = [[UIView alloc]initWithFrame:CGRectMake(200 / 2 - 25, 20, 50, 50)];
    viewProgress.layer.cornerRadius = 25;
    
    [self.hudBackView addSubview:viewProgress];
    self.hudProgressView = viewProgress;
    
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter: CGPointMake(self.hudProgressView.frame.size.width / 2, self.hudProgressView.frame.size.height / 2) radius:self.hudProgressView.frame.size.width / 2  startAngle:  0 * M_PI/180 endAngle: 360 * M_PI/180 clockwise: NO];
    
    // 创建外部透明圆形的图层
    CAShapeLayer *alphaLineLayer = [CAShapeLayer layer];
    alphaLineLayer.path = circlePath.CGPath;// 设置透明圆形的绘图路径
    alphaLineLayer.strokeColor = [UIColor colorWithRed:239/255.f green:214/255.f blue:214/255.f alpha:1].CGColor;
    // ↑ 设置图层的透明圆形的颜色，取图标颜色之后设置其对应的0.1透明度的颜色
    alphaLineLayer.lineWidth = STROKE_WIDTH;// 设置圆形的线宽
    alphaLineLayer.fillColor = [UIColor clearColor].CGColor;// 填充颜色透明
    
    [self.hudProgressView.layer addSublayer: alphaLineLayer];
    
    
    // 开始画叉的两条线，首先画逆时针旋转的线
    CAShapeLayer *leftLayer = [CAShapeLayer layer];
    // 设置当前图层的绘制属性
    leftLayer.frame = viewProgress.bounds;
    leftLayer.fillColor = [UIColor clearColor].CGColor;
    leftLayer.lineCap = kCALineCapRound;// 圆角画笔
    leftLayer.lineWidth = STROKE_WIDTH;
    leftLayer.strokeColor = [UIColor redColor].CGColor;
    
    // 半圆+动画的绘制路径初始化
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    // 绘制大半圆
    [leftPath addArcWithCenter: CGPointMake(viewProgress.frame.size.width / 2, viewProgress.frame.size.height / 2) radius:viewProgress.frame.size.width / 2  startAngle:  -43 * M_PI / 180 endAngle: -315 * M_PI / 180 clockwise: NO];
    
    [leftPath addLineToPoint: CGPointMake(viewProgress.frame.size.width * 0.34, viewProgress.frame.size.width * 0.33)];
    
    // 把路径设置为当前图层的路径
    leftLayer.path = leftPath.CGPath;
    
    [viewProgress.layer addSublayer: leftLayer];
    
    
    // 逆时针旋转的线
    CAShapeLayer *rightLayer = [CAShapeLayer layer];
    // 设置当前图层的绘制属性
    rightLayer.frame = viewProgress.bounds;
    rightLayer.fillColor = [UIColor clearColor].CGColor;
    rightLayer.lineCap = kCALineCapRound;// 圆角画笔
    rightLayer.lineWidth = STROKE_WIDTH;
    rightLayer.strokeColor = [UIColor redColor].CGColor;
    
    // 半圆+动画的绘制路径初始化
    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    // 绘制大半圆
    [rightPath addArcWithCenter: CGPointMake(viewProgress.frame.size.width / 2, viewProgress.frame.size.height / 2) radius:viewProgress.frame.size.width / 2  startAngle:  -128 * M_PI / 180 endAngle: 133 * M_PI / 180 clockwise: YES];
    
    [rightPath addLineToPoint: CGPointMake(viewProgress.frame.size.width * 0.66, viewProgress.frame.size.width * 0.33)];
    
    // 把路径设置为当前图层的路径
    rightLayer.path = rightPath.CGPath;
    
    [viewProgress.layer addSublayer: rightLayer];
    
    
    CAMediaTimingFunction *timing = [[CAMediaTimingFunction alloc] initWithControlPoints:0.3 :0.6 :0.8 :1.1];
    // 创建路径顺序绘制的动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    animation.duration = 0.5;// 动画使用时间
    animation.fromValue = [NSNumber numberWithInt: 0.0];// 从头
    animation.toValue = [NSNumber numberWithInt: 1.0];// 画到尾
    // 创建路径顺序从结尾开始消失的动画
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath: @"strokeStart"];
    strokeStartAnimation.duration = 0.4;// 动画使用时间
    strokeStartAnimation.beginTime = CACurrentMediaTime() + 0.2;// 延迟0.2秒执行动画
    strokeStartAnimation.fromValue = [NSNumber numberWithFloat: 0.0];// 从开始消失
    strokeStartAnimation.toValue = [NSNumber numberWithFloat: 0.84];// 一直消失到整个绘制路径的84%，这个数没有啥技巧，一点点调试看效果，希望看此代码的人不要被这个数值怎么来的困惑
    strokeStartAnimation.timingFunction = timing;
    
    leftLayer.strokeStart = 0.84;// 设置最终效果，防止动画结束之后效果改变
    leftLayer.strokeEnd = 1.0;
    rightLayer.strokeStart = 0.84;// 设置最终效果，防止动画结束之后效果改变
    rightLayer.strokeEnd = 1.0;
    
    
    [leftLayer addAnimation: animation forKey: @"strokeEnd"];// 添加俩动画
    [leftLayer addAnimation: strokeStartAnimation forKey: @"strokeStart"];
    [rightLayer addAnimation: animation forKey: @"strokeEnd"];// 添加俩动画
    [rightLayer addAnimation: strokeStartAnimation forKey: @"strokeStart"];
    
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf removeView];
    });
}

- (void)setContentStr:(NSString *)contentStr {
    
    _contentStr = contentStr;
    self.contentLable.text = contentStr;
}

- (void)removeView {
    
    [self removeFromSuperview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
