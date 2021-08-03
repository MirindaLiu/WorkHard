//
//  RPerson.h
//  Blog
//
//  Created by Mirinda on 2019/5/23.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RPerson : NSObject
- (void)walk;
- (void)eat;
+ (void)sleep;
- (void)runMessage:(NSString*)str;
@end

NS_ASSUME_NONNULL_END
