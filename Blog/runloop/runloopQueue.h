//
//  runloopQueue.h
//  Blog
//
//  Created by Mirinda on 2018/8/15.
//  Copyright © 2018年 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef  void (^queBlock)(void);
@interface runloopQueue : NSObject
@property (nonatomic, copy)queBlock qBlock;
+ (void)setTaskToQueue:(queBlock)block;
+ (BOOL)isHaveTask;
+(void)excuteTask;
@end
