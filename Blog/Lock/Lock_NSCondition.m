//
//  Lock_NSCondition.m
//  Blog
//
//  Created by Mirinda on 17/3/21.
//  Copyright © 2017年 Mirinda. All rights reserved.
//

#import "Lock_NSCondition.h"

@implementation Lock_NSCondition

//NSCondition 也是遵守了<NSLocking>协议 所以拥有两个最基本方法：- (void)lock 和 - (void)unlock 另外还有自己的四个方法
//- (void)wait;进入等待状态
//- (BOOL)waitUntilDate:(NSDate *)limit;让一个线程等待一定的时间
//- (void)signal;唤醒一个等待的线程 唤醒线程是无序的 无法指定
//- (void)broadcast;唤醒所有等待的线程 唤醒线程是无序的 无法指定

-(void)useNSCondition
{
    //基本方法使用，跟NSLock一致，
//    下面先看看 - (BOOL)waitUntilDate:(NSDate *)limit 方法 这个方法让先让线程处于等待一致到指定时间
    NSCondition* condition = [[NSCondition alloc] init];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"线程加锁");
        [condition lock];
        [condition waitUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];//等待到从现在起后两秒的时间
        [condition unlock];
        NSLog(@"线程解锁");
        
    });
    
    //现在介绍其他三个方法  wait 方法 要配合signal 或者broadcast 使用,不然线程就一直处于等待状态
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        [condition lock];
        NSLog(@"线程1等待");
        [condition wait];
        [condition unlock];
        NSLog(@"线程1出锁");
        
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [condition lock];
        NSLog(@"线程2等待");
        [condition wait];
        [condition unlock];
        NSLog(@"线程2出锁");
        
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [condition lock];
        NSLog(@"线程3等待");
        [condition wait];
        [condition unlock];
        NSLog(@"线程3出锁");
    });

    sleep(5);//设置等待时间让加锁操作都玩成
    [condition signal];
    [condition broadcast];
}


@end
