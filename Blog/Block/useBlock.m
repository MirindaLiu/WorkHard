//
//  useBlock.m
//  Blog
//
//  Created by Mirinda on 2018/4/16.
//  Copyright © 2018年 Mirinda. All rights reserved.
//

#import "useBlock.h"


@implementation useBlock
- (useEat)eat
{
    useEat blockEat = ^(int a){
        NSLog(@"This is eat, a = %d",a);
        return self;
    };
    return [blockEat copy];
}

- (useEat)look
{
    useEat blockLook = ^(int a){
        NSLog(@"This is look, a = %d",a);
        return self;
    };
    return [blockLook copy];
}
@end
