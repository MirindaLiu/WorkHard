//
//  Lock_NSRecursiveLock.m
//  Blog
//
//  Created by Mirinda on 17/3/22.
//  Copyright © 2017年 Mirinda. All rights reserved.
//

#import "Lock_NSRecursiveLock.h"

@implementation Lock_NSRecursiveLock




//NSRecursiveLock 是递归锁，由于在同一线程内多次加锁会造成死锁问题，所以如果在递归中加锁，或者在循环中多次加锁 就要考虑使用递归锁
//NSRecursiveLock 为递归锁，也是遵守了<NSLocking>协议 所以拥有两个最基本方法：- (void)lock 和 - (void)unlock 另外还有如下方法：
//以下是方法列表
//@interface NSRecursiveLock : NSObject <NSLocking> {
//@private
//    void *_priv;
//}
//
//- (BOOL)tryLock;
//- (BOOL)lockBeforeDate:(NSDate *)limit;
//
//@property (nullable, copy) NSString *name NS_AVAILABLE(10_5, 2_0);
//
//@end

-(void)useNSRecursiveLock
{
   //循环中加锁
    NSRecursiveLock* RLock = [[NSRecursiveLock alloc]init];
    for(int i = 0; i<10; i++)
    {
        [RLock lock];
        NSLog(@"这是第%d次加锁",i+1);
        [RLock unlock];
    }
}

@end
