//
//  GCDInto.h
//  Blog
//
//  Created by Mirinda on 2019/6/14.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCDInto : NSObject
- (void)GCDEntrance;
@end

NS_ASSUME_NONNULL_END

//GCD一些概念:
/*
 dispatch是一个简单强大的表达并发的抽象模型:
 在dispatch的内部，dispatch提供一系列提交的block先进先出的队列。
 block被提交到一系列由系统管理的线程池中，系统不保证这个Block会在哪一个线程执行。
 多个队列提交Block的时候，系统会自动创建新的线程来并发执行这些Block，当线程执行完毕时，会被系统自动释放。
 dispatch会按照先进先出的顺序每次调用一个Block去执行
 不同的队列Queue之间不受影响，也就是说不同队列之间是并发执行Block
 dispatch_queue（调度队列）相对于提交的Block块来说是轻量级的
 系统管理了一个线程池来处理调度队列和执行提交到队列的Block
 调度队列有自己的执行线程，并且队列之间的交互是高度异步的
 调度队列是通过dispatch_retain()和dispatch_release()来执行引用计数的
 提交的Blocks会对Queue做一次引用直到执行完毕，当Queue的所有引用都被释放的时候，队列就会被系统销毁
 */
