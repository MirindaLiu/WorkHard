//
//  Lock_OSSpinLock.m
//  Blog
//
//  Created by Mirinda on 17/3/23.
//  Copyright © 2017年 Mirinda. All rights reserved.
//

#import "Lock_OSSpinLock.h"
#import <libkern/OSAtomic.h>
@implementation Lock_OSSpinLock

//OSSpinLock 自旋锁，自旋锁不会引起调用者睡眠，如果自旋锁已经被别的执行单元保持，调用者就一直循环在那里看是否该自旋锁的保持者已经释放了锁，"自旋"一词就是因此而得名，由于自旋锁使用者一般保持锁时间非常短，因此选择自旋而不是睡眠是非常必要的，自旋锁的效率远高于互斥锁。一个执行单元要想访问被自旋锁保护的共享资源，必须先得到锁，在访问完共享资源后，必须释放锁。如果在获取自旋锁时，没有任何执行单元保持该锁，那么将立即得到锁；如果在获取自旋锁时锁已经有保持者，那么获取锁操作将自旋在那里，直到该自旋锁的保持者释放了锁。
//OS_SPINLOCK_INIT： 默认值为 0,在 locked 状态时就会大于 0，unlocked状态下为 0
//OSSpinLockLock(&oslock)：上锁，参数为 OSSpinLock 地址
//OSSpinLockUnlock(&oslock)：解锁，参数为 OSSpinLock 地址
//OSSpinLockTry(&oslock)：尝试加锁，可以加锁则立即加锁并返回 YES,反之返回 NO

static OSSpinLock lcok = OS_SPINLOCK_INIT;
-(void)useOSSpinLock
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        OSSpinLockLock(&lcok);
        NSLog(@"线程1加锁");
        sleep(1);
        OSSpinLockUnlock(&lcok);
        NSLog(@"线程1解锁");
        
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        OSSpinLockLock(&lcok);
        NSLog(@"线程2加锁");
        sleep(1);
        OSSpinLockUnlock(&lcok);
        NSLog(@"线程2解锁");
        
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        OSSpinLockLock(&lcok);
        NSLog(@"线程3加锁");
        sleep(1);
        OSSpinLockUnlock(&lcok);
        NSLog(@"线程3解锁");
    });


}
@end
