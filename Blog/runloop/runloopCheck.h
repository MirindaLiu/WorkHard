//
//  runloopCheck.h
//  Blog
//
//  Created by Mirinda on 2018/5/27.
//  Copyright © 2018年 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface runloopCheck : NSObject
- (NSThread *)createBackThread;
- (void)doSomeThingInThread;
@end
