//
//  ViewController.m
//  demo
//
//  Created by mac on 15/8/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ViewController.h"
#import ""

@interface ViewController () <FGLNetworkingOperationDelegate>

@property (strong, nonatomic)     NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.name = @"task";
    queue.maxConcurrentOperationCount = 1;
    
    FGLNetworkingOperation *task1 = [[FGLNetworkingOperation alloc] initWithURLString:@"http://www.baidu.com"];
    task1.delegate = self;
    
    FGLNetworkingOperation *task2 = [[FGLNetworkingOperation alloc] initWithURLString:@"http://www.ucai.cn"];
    task2.delegate = self;
    
    FGLNetworkingOperation *task3 = [[FGLNetworkingOperation alloc] initWithURLString:@"http://www.bing.com"];
    task3.delegate = self;
    
    [queue addOperation:task3];
    [queue addOperation:task2];
    [queue addOperation:task1];
    
}

- (void)networkingOperationDidStart:(FGLNetworkingOperation *)operation
{
    NSLog(@"networkingOperationDidStart");
}

- (void)networkingOperationDidFinish:(FGLNetworkingOperation *)operation
{
    NSLog(@"networkingOperationDidFinish");
    NSLog(@"url:%@", operation.response.URL.absoluteString);
    NSLog(@"data:%@", operation.responseString);
    NSLog(@"error:%@", operation.error.localizedDescription);
}

@end
