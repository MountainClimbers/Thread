//
//  ViewController.m
//  demo-NSThread
//
//  Created by 雷神 on 2018/6/2.
//  Copyright © 2018年 雷神. All rights reserved.
//

#import "ViewController.h"
#import "NSThreadViewController.h"
@interface ViewController ()
@property (nonatomic, strong) NSThread *myThread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [btn setTitle:@"开始线程" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 170, 100, 50)];
    [btn1 setTitle:@"结束线程" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 240, 100, 50)];
    [btn2 setTitle:@"线程通信" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(communication:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(100, 310, 100, 50)];
    [btn4 setTitle:@"抢票问题" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(gotoPiaoVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
}

- (void)start:(UIButton *)sender {
    _myThread = [[NSThread alloc] initWithTarget:self selector:@selector(startCount) object:nil];
    [_myThread start];
}

- (void)startCount {
    
    for (NSInteger i = 0; i < 1000; i++) {
        if (_myThread.cancelled) {
            return;
        }
        [NSThread sleepForTimeInterval:1.0f];
        NSLog(@"%ld  当前线程%@",i,[NSThread currentThread]);
    }
    
}

- (void)communication:(UIButton *)sender {
    [NSThread detachNewThreadSelector:@selector(communicationTask) toTarget:self withObject:nil];
}

- (void)communicationTask {
    NSLog(@"当前线程%@", [NSThread currentThread]);
    [NSThread sleepForTimeInterval:3];
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:[UIColor redColor] waitUntilDone:YES];
}

- (void)cancel:(UIButton *)sender {
    [_myThread cancel];
}

- (void)updateUI:(UIColor *)color {
    self.view.backgroundColor = color;
    NSLog(@"我变红了%@",[NSThread currentThread]);

}

- (void)gotoPiaoVC {
    NSThreadViewController *thread = [[NSThreadViewController alloc] init];
    [self.navigationController pushViewController:thread animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
