//
//  runloopQueue.m
//  Blog
//
//  Created by Mirinda on 2018/8/15.
//  Copyright © 2018年 Mirinda. All rights reserved.
//

#import "runloopQueue.h"
#import "runloopCheck.h"
static NSMutableArray *stackArr = nil;
static runloopCheck *loop;

@interface runloopQueue()
@end
@implementation runloopQueue

+ (void)setTaskToQueue:(queBlock)block{
    runloopQueue *que = [[runloopQueue alloc]init];
    que.qBlock = block;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loop = [[runloopCheck alloc]init];
        [loop createBackThread];
        stackArr = [NSMutableArray array];
    });
    [stackArr addObject:que];
}


+ (BOOL)isHaveTask {
    if (nil != stackArr &&  stackArr.count>0) {
        return YES;
    }
    return NO;
}


+(void)excuteTask {
    if (nil != stackArr &&  stackArr.count>0) {
        runloopQueue *que = [stackArr firstObject];
        que.qBlock();
        [stackArr removeObjectAtIndex:0];
    }
}
@end
