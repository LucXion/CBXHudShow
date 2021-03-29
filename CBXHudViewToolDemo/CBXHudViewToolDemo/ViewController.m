//
//  ViewController.m
//  CBXHudViewToolDemo
//
//  Created by 陆正现 on 2018/3/26.
//  Copyright © 2018年 陆正现. All rights reserved.
//

#import "ViewController.h"
#import "CBXHudViewTool.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *choseBtn;

@property (weak, nonatomic) IBOutlet UIButton *staticImageBtn;

@property (weak, nonatomic) IBOutlet UIButton *sportProgressBtn;

@property (weak, nonatomic) IBOutlet UIButton *sportSucceseBtn;

@property (weak, nonatomic) IBOutlet UIButton *sportFailBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
}

- (IBAction)choseBtn:(id)sender {
    
    // 开始测试
    
    // 1. 选择提示框
    /*
     ContentTitle: 最多5个元素
     FontArr：默认字体大小为 15， 可以传nil
     LeftColor： 默认黑色，可以传nil
     */
    [[CBXHudViewTool shareHud] showHudWithContentTitle:@[@"标题1",@"标题2",@"标题3标题3标题3标题3标题3标题3标题3标题3标题3标题3标题3标题3标题3标题3标题3标题3标题3标题3"] andFontArr:@[@(17),@(15),@(12)] andLeftChose:@"左选项" andLeftColor:[UIColor redColor] andRightChose:@"右选项" andRightColor:nil inViewController:self clickBlock:^void(ClickType type) {
        
    }];
    
}

- (IBAction)StaticImageClick:(id)sender {
    
    [[CBXHudViewTool shareHud]showHudWithImage:[UIImage imageNamed:@"free_practice_mission_copper"] andContent:@"恭喜获得奖杯" andTime:3 inVc:self];
    
}

- (IBAction)progressClick:(id)sender {
    
    [[CBXHudViewTool shareHud]showProgressHudViewWithContent:@"正在加载中,请稍后..." andVc:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[CBXHudViewTool shareHud]hiddeHud];
    });
}

- (IBAction)clickSuccese:(id)sender {
    
    [[CBXHudViewTool shareHud]showSuccessHudViewWithContent:@"成功获取数据"];
    
}
- (IBAction)clickFail:(id)sender {
    
        [[CBXHudViewTool shareHud]showFailHudViewWithContent:@"获取数据失败"];
}


- (IBAction)clickTwoBtn:(id)sender {
    
        [[CBXHudViewTool shareHud]showProgressHudViewWithContent:@"正在加载中,请稍后..." andVc:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[CBXHudViewTool shareHud]showSuccessHudViewWithContent:@"成功获取数据"];
    });
    
}




- (void)clickBtn:(UIButton*)sender {
    
}


- (void)bringFront {
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
