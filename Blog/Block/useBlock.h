//
//  useBlock.h
//  Blog
//
//  Created by Mirinda on 2018/4/16.
//  Copyright © 2018年 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>
@class useBlock;
typedef useBlock* (^useEat)(int);
@interface useBlock : NSObject
- (useEat)eat;
- (useEat)look;
@end
