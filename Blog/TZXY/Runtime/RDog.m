//
//  RDog.m
//  Blog
//
//  Created by Mirinda on 2019/5/23.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import "RDog.h"

@implementation RDog
- (void)walk {
    NSLog(@"run :%s", __func__);
    //    NSLog(@"run- :%@", NSStringFromSelector(_cmd));
}

- (void)eat {
    NSLog(@"run :%s", __func__);
    //    NSLog(@"run- :%@", NSStringFromSelector(_cmd));
}

+ (void)sleep {
    NSLog(@"run :%s", __func__);
}

- (void)drink:(NSString *)something {
    NSLog(@"run :%s", __func__);
}
@end
