//
//  BinarySearchTree.m
//  Blog
//
//  Created by Mirinda on 2019/7/15.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import "BinarySearchTree.h"
static BSTNode *root = NULL;
@implementation BinarySearchTree
- (void)BSTInto {
  insertBST(30,root);
  insertBST(60,root);
  insertBST(20,root);
  insertBST(70,root);
  insertBST(10,root);
  insertBST(90,root);
  insertBST(7,root);
  insertBST(9,root);
  insertBST(56,root);
  insertBST(1,root);
  insertBST(5,root);
  insertBST(17,root);
  insertBST(79,root);
  insertBST(93,root);
//  inOrderWalk(root);
//  printf("\n");
//  perOrderWalk(root);
//  printf("\n");
//  postOrderWalk(root);
//  if (searchKey(16, root)) printf("找到了\n");
//  else printf("没到了\n");
//  printf("min = %d\n",searchMinKey(root));
//  printf("max = %d\n",searchMaxKey(root));
  deleteNode(9, root);
//  printf("%d的后继值为:%d\n",93,searchSuccessor(93, root));
//  printf("%d的后继值为:%d\n",56,searchSuccessor(56, root));
//  printf("%d的前驱值为:%d\n",1,searchPredecessor(1, root));
  printf("%d的前驱值为:%d\n",90,searchPredecessor(90, root));
}

//插入操作
void insertBST(int number,BSTNode *node) {
  if (!root) {
    root = getTreeNode();
    root->value = number;
    return;
  }
  if (node->value > number) {
    BSTNode* left = node->leftChild;
    if (left) {
      insertBST(number,left);
    }else {
      BSTNode *insertNode = getTreeNode();
      insertNode->parent = node;
      node->leftChild = insertNode;
      insertNode->value = number;
      return;
    }
  }else {
    BSTNode* right = node->rightChild;
    if (right) {
        insertBST(number,right);
    }else {
      BSTNode *insertNode = getTreeNode();
      insertNode->parent = node;
      node->rightChild = insertNode;
      insertNode->value = number;
      return;
    }
  }
}

//中序遍历
void inOrderWalk(BSTNode *node) {
  if (!node) return;
  inOrderWalk(node->leftChild);
  printf("%d ",node->value);
  inOrderWalk(node->rightChild);
}

//前序遍历
void perOrderWalk(BSTNode *node) {
  if (!node) return;
  printf("%d ",node->value);
  perOrderWalk(node->leftChild);
  perOrderWalk(node->rightChild);
}

//后续遍历
void postOrderWalk(BSTNode *node) {
  if (!node) return;
  postOrderWalk(node->leftChild);
  postOrderWalk(node->rightChild);
  printf("%d ", node->value);
}

//查找
BSTNode* searchKey(int number, BSTNode *node) {
  if(!node) return NULL;
  if(number == node->value) return node;
  if (number < node->value) node = node->leftChild;
  else node = node->rightChild;
  return searchKey(number, node);
}

//查找最小关键字
int searchMinKey(BSTNode *node) {
  if (!node->leftChild) {
    return node->value;
  }
  return searchMinKey(node->leftChild);
}

int searchMaxKey(BSTNode *node) {
  if (!node->rightChild) {
    return node->value;
  }
  return searchMaxKey(node->rightChild);
}




int searchSuccessor(int number, BSTNode *root) {
  if (!root) return -1;
  //先找到 number 所在的节点
  BSTNode *node = searchKey(number, root);
  if (!node) return -1;
  
  //超找number的后继结点
  if (node->rightChild) {
    return searchMinKey(node->rightChild);
  }
  
  BSTNode *flag = node->parent;
  while (flag && node == flag->rightChild) {
    node = flag;
    flag = flag->parent;
  }
  
  if (NULL == flag) {
    return -1;
  }
  
  return flag->value;

}



int searchPredecessor(int key, BSTNode *root) {
  if (!root) return -1;
  BSTNode *node = searchKey(key, root);
  if(node->leftChild) return searchMaxKey(node->leftChild);
  BSTNode *flag = node->parent;
  
  while (flag && node == flag->leftChild) {
    node = flag;
    flag = flag->parent;
  }
  
  if (!flag) {
    return -1;
  }
  
  return flag->value;
}




//删除节点
static void deleteNode(int key, BSTNode *root) {
  //找到节点
  BSTNode *node = searchKey(key, root);
  BSTNode * p = node->parent;
  if (!p) {
    free(node);
    root = NULL;
    return;
  }
  
  
  if (!node->leftChild && !node->rightChild) {
    if (node == p->leftChild) p->leftChild = NULL;
    else p->rightChild = NULL;
    free(node);
    node = NULL;
    return;
  }
  
  BSTNode *flag = node->rightChild;
  if (!flag) {
    p->leftChild = node->leftChild;
    free(node);
    node = NULL;
    return;
  }
  
  flag = node->leftChild;
  if (!flag) {
    p->rightChild = node->rightChild;
    free(node);
    node = NULL;
    return;
  }
  
  while (flag->rightChild) {
    flag = flag->rightChild;
  }
  if (node == p->leftChild) p->leftChild = flag;
  else p->rightChild = flag;
  flag->leftChild = node->leftChild;
  flag->rightChild = node->rightChild;
  
  free(node);
  node = NULL;
  
}


//获取节点
BSTNode* getTreeNode() {
  BSTNode *node = (BSTNode*)malloc(sizeof(BSTNode));
  node->value = 0;
  node->parent = NULL;
  node->leftChild = NULL;
  node->rightChild = NULL;
  return node;
}

@end
