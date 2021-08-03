//
//  Lock_NSLock.m
//  Blog
//
//  Created by Mirinda on 17/2/12.
//  Copyright © 2017年 Mirinda. All rights reserved.
//

#import "Lock_NSLock.h"

@implementation Lock_NSLock

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


/* NSLock 最基本方法是基于NSLocking协议的：- (void)lock 和 - (void)unlock。
 锁的最基本用途就是实现数据同步，解决因为多个线程操作统一数据时引起的数据错误。但是使用锁就会堵塞线程，造成效率降低。但是我们也可以通过阻塞线程这一特性，实现多线程内，指定代码块的执行顺序，比如线程a依赖于线程b中的一个数据c，那好就可以完全通过加锁实现。*/
-(void)useNSLock
{
    //初始化锁
    NSLock* lock = [[NSLock alloc] init];
    
    //线程1
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [lock lock];
        NSLog(@"线程1，已经加锁。");
        sleep(2);
        NSLog(@"线程1，执行锁内内容。");
        [lock unlock];
        NSLog(@"线程1，已经解锁。");
        
    });

    
    //线程2
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [lock lock];
        NSLog(@"线程2，已经加锁。");
        NSLog(@"线程2，执行锁内内容。");
        [lock unlock];
        NSLog(@"线程2，已经解锁。");
        
    });
}

//lockBeforeDate: 方法
//- (BOOL)lockBeforeDate:(NSDate *)limit
//在指定的时间以前得到锁。YES:在指定时间之前获得了锁；NO：在指定时间之前没有获得锁。
//该线程将被阻塞，直到获得了锁，或者指定时间过期。
//
//tryLock 方法
//- (BOOL)tryLock
//视图得到一个锁。YES：成功得到锁；NO：没有得到锁。
//
//setName: 方法
//- (void)setName:(NSString *)newName
//为锁指定一个Name
//
//name 方法
//- (NSString *)name
//返回锁指定的Name
// tryLock 和 Lock的区别：
//如果线程在加锁失败的情况下仍然需要继续执行 这时候就可以用tryLock。
//如果线程只有在加锁后再能继续执行，那就用Lock 没必要一直轮询tryLock
@end
