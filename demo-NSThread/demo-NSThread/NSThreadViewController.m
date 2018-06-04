//
//  NSThreadViewController.m
//  demo-NSThread
//
//  Created by 雷神 on 2018/6/2.
//  Copyright © 2018年 雷神. All rights reserved.
//

#import "NSThreadViewController.h"

@interface NSThreadViewController ()
{
    NSInteger tickets;//剩余票数
    NSInteger sellNum;//卖出票数
    NSThread *thread1;//买票线程1
    NSThread *thread2;//买票线程2
    NSLock *theLock;//锁
}
@property (nonatomic, strong) NSThread *myThread;
@end

@implementation NSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //https://www.cnblogs.com/zhanglinfeng/p/4980536.html
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [btn setTitle:@"开始抢票" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(twoPeopleBuy:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)twoPeopleBuy:(UIButton *)sender {
    tickets = 9;
    sellNum = 0;
    theLock = [[NSLock alloc] init];
    
    thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(buy) object:nil];
    [thread1 setName:@"Thread-1"];
    [thread1 start];
    
    thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(buy) object:nil];
    [thread2 setName:@"Thread-2"];
    [thread2 start];
    
    
}

- (void)buy {
    while (TRUE) {
        [theLock lock];
        if (tickets >= 0) {
            [NSThread sleepForTimeInterval:0.09];
            sellNum = 9 - tickets;
            NSLog(@"当前票数是：%ld,售出：%ld,线程名：%@",tickets,sellNum,[[NSThread currentThread] name]);
            tickets--;
        } else {
            break;
        }
        [theLock unlock];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
