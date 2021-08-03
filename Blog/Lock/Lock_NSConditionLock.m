//
//  Lock_NSConditionLock.m
//  Blog
//
//  Created by Mirinda on 17/3/21.
//  Copyright © 2017年 Mirinda. All rights reserved.
//

#import "Lock_NSConditionLock.h"

@implementation Lock_NSConditionLock

//NSConditionLock 为条件锁，也是遵守了<NSLocking>协议 所以拥有两个最基本方法：- (void)lock 和 - (void)unlock 另外还有如下方法：

//- (instancetype)initWithCondition:(NSInteger)condition NS_DESIGNATED_INITIALIZER;
//@property (readonly)NSInteger condition; //这属性非常重要，外部传入的condition与之相同才会获取到lock对象，反之阻塞当前线程，直到condition相同
//- (void)lockWhenCondition:(NSInteger)condition; //condition与内部相同才会获取锁对象并立即返回，否则阻塞线程直到condition相同
//- (BOOL)tryLock;//尝试获取锁对象，获取成功需要配对unlock
//- (BOOL)tryLockWhenCondition:(NSInteger)condition; //同上
//- (void)unlockWithCondition:(NSInteger)condition; //解锁，并且设置lock.condition = condition
//- (BOOL)lockBeforeDate:(NSDate *)limit;
//- (BOOL)lockWhenCondition:(NSInteger)condition beforeDate:(NSDate *)limit;
//
//@property (nullable,copy) NSString *name NS_AVAILABLE(10_5,2_0);


-(void)useNSConditionLock
{
    //这里用法跟NSLock 一致
//    NSLog(@"这里用法跟NSLock一致");
//    NSConditionLock* CLock = [[NSConditionLock alloc] init];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [CLock lock];
//        sleep(1);
//        NSLog(@"线程1");
//        [CLock unlock];
//    });
//    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [CLock lock];
//        NSLog(@"线程2");
//        [CLock unlock];
//    });
    
    NSLog(@"这里条件锁用法，让线程按照条件执行");
    NSConditionLock* Lock = [[NSConditionLock alloc]initWithCondition:0];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [Lock lockWhenCondition:0];
        sleep(1);
        NSLog(@"线程1");
        [Lock unlockWithCondition:2];
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [Lock lockWhenCondition:3];
        NSLog(@"线程2");
        [Lock unlock];
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [Lock lockWhenCondition:2];
        sleep(3);
        NSLog(@"线程3");
        [Lock unlockWithCondition:3];
    });
    //从上面的结果我们可以发现，NSConditionLock 还可以实现任务之间的依赖。
}

@end
