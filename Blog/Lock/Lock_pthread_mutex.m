//
//  Lock_pthread_mutex.m
//  Blog
//
//  Created by Mirinda on 17/3/27.
//  Copyright © 2017年 Mirinda. All rights reserved.
//

#import "Lock_pthread_mutex.h"
#import <pthread.h>

@implementation Lock_pthread_mutex


-(void)usePthread_mutex
{
    static pthread_mutex_t pLock;
    pthread_mutex_init(&pLock, NULL);
    //1.线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程1 准备上锁");
        pthread_mutex_lock(&pLock);
        sleep(3);
        NSLog(@"线程1");
        pthread_mutex_unlock(&pLock);
    });
    
    //1.线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程2 准备上锁");
        pthread_mutex_lock(&pLock);
        NSLog(@"线程2");
        pthread_mutex_unlock(&pLock);
    });
}

@end
