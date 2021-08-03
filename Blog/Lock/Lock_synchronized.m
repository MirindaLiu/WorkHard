//
//  Lock_synchronized.m
//  Blog
//
//  Created by Mirinda on 17/3/27.
//  Copyright © 2017年 Mirinda. All rights reserved.
//

#import "Lock_synchronized.h"

@implementation Lock_synchronized

-(void)usesynchronized
{
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (self) {
            sleep(2);
            NSLog(@"线程1");
        }
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized (self) {
            NSLog(@"线程2");
        }
    });
}
@end
