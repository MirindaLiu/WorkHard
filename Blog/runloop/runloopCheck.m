//
//  runloopCheck.m
//  Blog
//
//  Created by Mirinda on 2018/5/27.
//  Copyright © 2018年 Mirinda. All rights reserved.
//


#import "runloopCheck.h"
#import <Foundation/NSPort.h>
#import "runloopQueue.h"

static NSPort * mPort;
@interface runloopCheck() <NSPortDelegate>
@property (nonatomic, strong)NSThread *backThread;
@end
@implementation runloopCheck

- (void)threadRun:(id) __unused obj
{
    @autoreleasepool {
        mPort = [NSPort port];
        [mPort setDelegate:self];
        NSLog(@"threadRun ------");
        [[NSThread currentThread] setName:@"backThread"];
        NSRunLoop *loop = [NSRunLoop currentRunLoop];
        [loop addPort:mPort forMode:NSDefaultRunLoopMode];
//        [self observerHandle];
        NSLog(@"threadRun ======");
        NSTimer  *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(doSomeThingInThread) userInfo:nil repeats:YES];
        [loop addTimer:timer forMode:NSDefaultRunLoopMode];
        [loop run];
    }
}

- (void) threadRunTask {
//    
}
- (NSThread *)createBackThread
{
    static  dispatch_once_t threadOnce;
    dispatch_once(&threadOnce, ^{
        self.backThread = [[NSThread alloc]initWithTarget:self selector:@selector(threadRun:) object:nil];
        [self.backThread start];
    });
    return self.backThread;
}

- (void)doSomeThingInThread {
    [self performSelector:@selector(doSomeThing) onThread:self.backThread withObject:nil waitUntilDone:NO];
}

- (void)doSomeThing {
    if ([runloopQueue isHaveTask]) {
        [runloopQueue excuteTask];
    }
}
- (void)handlePortMessage:(NSPortMessage *)message
{
    NSLog(@"NSPortMessage = %@", message);
}




- (void)observerHandle
{
    CFRunLoopObserverRef observe = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        if (activity == kCFRunLoopExit) {
            NSLog(@"即将退出runloop%lu",activity);
        }
        else if (activity == kCFRunLoopBeforeWaiting)
        {
            NSLog(@"即将进入休眠%lu",activity);
            
        }
        else if (activity == kCFRunLoopAfterWaiting)
        {
            NSLog(@"刚从休眠中唤醒%lu",activity);
            
        }else if (activity == kCFRunLoopBeforeSources)
        {
            NSLog(@"即将处理 Source%lu",activity);
            
        }else if (activity == kCFRunLoopBeforeTimers)
        {
            NSLog(@"即将处理 Timer%lu",activity);
            
        }
        else if (activity == kCFRunLoopEntry)
        {
            NSLog(@"即将进入Loop%lu",activity);
            
        }
    });

    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observe, kCFRunLoopDefaultMode);

    /*
     CF的内存管理（Core Foundation）
     1.凡是带有Create、Copy、Retain等字眼的函数，创建出来的对象，都需要在最后做一次release
     * 比如CFRunLoopObserverCreate
     2.release函数：CFRelease(对象);
     */
    CFRelease(observe);
}
@end
