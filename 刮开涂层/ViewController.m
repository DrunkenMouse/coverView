//
//  ViewController.m
//  刮开涂层
//
//  Created by 王奥东 on 16/7/8.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//保存显示的imgView
@property(nonatomic,strong)UIImageView *imgView;
//保存每次清理的size
@property(nonatomic,assign)CGSize clearSumSize;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    //设置用来显示的测试信息
    UILabel *textMsg = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    textMsg.text = @"做个测试~！\n做个测试~！\n做个测试~！\n做个测试~！\n做个测试~！\n";
    textMsg.textColor = [UIColor blackColor];
    textMsg.font = [UIFont systemFontOfSize:20];
    textMsg.numberOfLines = 0;
    textMsg.textAlignment = UITextAlignmentCenter;
    textMsg.backgroundColor = self.view.backgroundColor;
    
    [self.view addSubview:textMsg];
    
    //设置用来显示的遮盖图
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:textMsg.frame];
    imgView.image = [UIImage imageNamed:@"天空-栏杆"];
    [self.view addSubview:imgView];
    
    self.imgView = imgView;
    
}

//当出现任意滑动时
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获取触摸对象进而获取触摸点
    UITouch *touch = touches.anyObject;
    
    CGPoint touchPoint = [touch locationInView:self.imgView];
    
    //通过触摸点设置一个清除的rect
    CGRect clearSize = CGRectMake(touchPoint.x, touchPoint.y, 30, 30);
    
    //  若要求滑动范围达到多少清理覆盖层时，可使用此判断
//        self.clearSumSize = CGSizeMake(clearSize.size.width + self.clearSumSize.width, clearSize.size.height + self.clearSumSize.height);
//    if (self.clearSumSize.width > 500 || self.clearSumSize.height > 500) {
//        [self.imgView removeFromSuperview];
//    }
// 
    
    //设置一张与imgView同大小的上下文
    UIGraphicsBeginImageContextWithOptions(self.imgView.bounds.size, NO, 0);
    
    //获取到此上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    //将上下文添加到imgView的layer层
    [self.imgView.layer renderInContext:ref];
    
    //清除上下文中需要清理的rect
    CGContextClearRect(ref, clearSize);
    
    //获取清理后的上下文，以Image形式
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    //重新设置imgView
    self.imgView.image = img;
    
    
}












@end
