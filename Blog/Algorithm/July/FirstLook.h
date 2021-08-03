//
//  FristLook.h
//  Blog
//
//  Created by Mirinda on 2019/5/31.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstLook : NSObject
- (void)excuteMethod;
@end

@interface NSStack : NSObject
@property(nonatomic,assign)int flag;
@property(nonatomic,assign)int length;
@property(nonatomic,assign)char *stack;
- (instancetype)init;
- (instancetype)initWithCArray:(char*)arr;
- (void)push:(char)c;
- (char)pop;
- (char)top;
@end
NS_ASSUME_NONNULL_END
