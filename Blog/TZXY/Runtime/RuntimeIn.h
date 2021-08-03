//
//  RuntimeIn.h
//  Blog
//
//  Created by Mirinda on 2019/5/23.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimeIn : NSObject

@property(nonatomic, strong,readonly) NSString *test;

- (void)runtimeIn;
//+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end

NS_ASSUME_NONNULL_END
