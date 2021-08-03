//
//  Link.h
//  Blog
//
//  Created by Mirinda on 2019/7/1.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Link : NSObject
- (void)linkInto;
@end

typedef struct node {
    int value;
    struct node* next;
}linkNode;

NS_ASSUME_NONNULL_END
