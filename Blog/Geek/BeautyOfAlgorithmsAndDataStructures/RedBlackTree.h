//
//  RedBlackTree.h
//  Blog
//
//  Created by Mirinda on 2019/7/18.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef struct RBTreeNode {
  int color; //red 0 black 1
  int value;
  struct RBTreeNode *leftChild;
  struct RBTreeNode *rightChild;
  struct RBTreeNode *parent;
}RBTree;
@interface RedBlackTree : NSObject

- (void)RBTInto;
@end

NS_ASSUME_NONNULL_END
