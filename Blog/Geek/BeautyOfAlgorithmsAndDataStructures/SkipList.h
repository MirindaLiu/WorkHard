//
//  jumpList.h
//  Blog
//
//  Created by Mirinda on 2019/7/5.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct SLNode {
  int value;
  struct SLNode *next;
  struct SLNode *down;
}skipListNode;

typedef struct indexNode {
  struct SLNode *head;
  struct SLNode *currentNode;//currentNode 是上一级down时指向的本级的节点,
  struct SLNode *downLevelNode;//downLevelNode是本级要down到下一级时的本级的节点
}skipListIndex;


@interface SkipList : NSObject

- (void)skipListInto;
@end

NS_ASSUME_NONNULL_END
