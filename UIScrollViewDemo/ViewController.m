//
//  ViewController.m
//  UIScrollViewDemo
//
//  Created by OnePiece on 15/9/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ViewController.h"

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
{
    //因为要自动滚动 所以写个计时器
    NSTimer *_timer;
    
    UIScrollView *scrollView;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self creatScrollView];
    
    //因为进到页面 就要执行 计时器方法 所以写在viewDidLoad里
    [self creatTimer];
}
-(void)creatTimer{
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(loop:) userInfo:nil repeats:YES];
    
}
-(void)loop:(NSTimer *)timer{
    
    //要实现自动滚动，也就是每隔一段时间 去改变scrollview的偏移量
    
    CGFloat x = scrollView.contentOffset.x;
    x+=WIDTH;
    //计时器的时间一定要大于动画时间 最好计时器的时间是动画时间的2倍
    [UIView animateWithDuration:1 animations:^{
        
        scrollView.contentOffset = CGPointMake(x, 0);
        
    } completion:^(BOOL finished) {
        //当15张图 全部滚出屏幕,第16张图出现的时候，重置scrollview的偏移量
        if (scrollView.contentOffset.x == 15*WIDTH) {
            
            scrollView.contentOffset = CGPointMake(0, 0);
        }
    }];
    
    
}
-(void)creatScrollView{
    
    scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    for (int i = 1; i<16; i++) {
        //先把15张图 加到scrollview上
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"圣斗士%02d.jpg",i]];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((i-1)*WIDTH, 0, WIDTH, HEIGHT)];
        imageV.image = image;
        
        [scrollView addSubview:imageV];
        
    }
    //在15张图的后面 为了循环滚动 再加一张图，这张图是为了造成视觉时间差效果的，所以加第一张图片
    UIImageView *IV = [[UIImageView alloc]initWithFrame:CGRectMake(15*WIDTH, 0, WIDTH, HEIGHT)];
    [IV setImage:[UIImage imageNamed:@"圣斗士01.jpg"]];
    
    [scrollView addSubview:IV];
    
    //因为在15张图后 又加了一张图 所以内容尺寸为16*320
    scrollView.contentSize = CGSizeMake(16*WIDTH, HEIGHT);
    
    //设置默认偏移量
    scrollView.contentOffset = CGPointZero;
    //设置分页效果
    scrollView.pagingEnabled = YES;
    
    
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
