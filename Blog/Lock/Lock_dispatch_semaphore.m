//
//  Lock_dispatch_semaphore.m
//  Blog
//
//  Created by Mirinda on 17/3/23.
//  Copyright © 2017年 Mirinda. All rights reserved.
//

#import "Lock_dispatch_semaphore.h"

@implementation Lock_dispatch_semaphore

-(void)useDispatch_semaphore
{
    //dispatch_semaphore_create(1)： 传入值必须 >=0, 若传入为 0 则阻塞线程并等待timeout,时间到后会执行其后的语句
    //dispatch_semaphore_wait(signal, overTime)：可以理解为 lock,会使得 signal 值 减1
    //dispatch_semaphore_signal(signal)：可以理解为 unlock,会使得 signal 值 加1
    
    dispatch_semaphore_t signal = dispatch_semaphore_create(1); //传入值必须 >=0, 若传入为0则阻塞线程并等待timeout,时间到后会执行其后的语句
    //dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 3.0f * NSEC_PER_SEC);
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1处于等待");
        dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER); //signal 值 减1
        NSLog(@"线程1执行");
        dispatch_semaphore_signal(signal); //signal 值 加1
        NSLog(@"线程1发送信号");
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2处于等待");
        dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
        NSLog(@"线程2执行");
        dispatch_semaphore_signal(signal);
        NSLog(@"线程2发送信号");
    });
}
@end
