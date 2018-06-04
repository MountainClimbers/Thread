//
//  ViewController.m
//  demo-GCD
//
//  Created by 雷神 on 2018/6/4.
//  Copyright © 2018年 雷神. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [btn setTitle:@"等待" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(wait:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)wait:(UIButton *)sender {
    dispatch_queue_t myQueue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
    for (NSInteger n = 0; n < 2; n++) {
        dispatch_async(myQueue, ^{
            for (NSInteger i = 0; i < 500000000; i++) {
                if (i == 0) {
                    NSLog(@"前面任务%ld -> 开始",(long)n);
                }
                
                if (i == 499999999) {
                    NSLog(@"前面任务%ld -> 完成",(long)n);

                }
            }
        });
    }
    
    dispatch_barrier_async(myQueue, ^{
        NSLog(@"dispatch-barrier");
    });
    
    for (NSInteger n = 0; n < 2; n++) {
        
        for (NSInteger i = 0; i < 500000000; i++) {

            dispatch_async(myQueue, ^{
                if (i == 0) {
                    NSLog(@"后面任务%ld -> 开始",(long)n);
                }
                
                if (i == 499999999) {
                    NSLog(@"后面任务%ld -> 完成",(long)n);
                    
                }
            });
            
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
