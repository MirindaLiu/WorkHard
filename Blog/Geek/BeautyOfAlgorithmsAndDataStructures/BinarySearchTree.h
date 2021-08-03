//
//  BinarySearchTree.h
//  Blog
//
//  Created by Mirinda on 2019/7/15.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct treeNode {
  int value;
  struct treeNode *parent;
  struct treeNode *leftChild;
  struct treeNode *rightChild;
}BSTNode;



@interface BinarySearchTree : NSObject

- (void)BSTInto;
@end

NS_ASSUME_NONNULL_END
