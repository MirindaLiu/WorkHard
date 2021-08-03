//
//  RedBlackTree.m
//  Blog
//
//  Created by Mirinda on 2019/7/18.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import "RedBlackTree.h"
static RBTree *root = NULL;
@implementation RedBlackTree
- (void)RBTInto {
  
}

static void insertNode(int number, RBTree *node) {
  if (!root) {//1.没有根节点时
    root = getNode(number);
    root->color = 1;
    return;
  }
  
  if(node->value > number) {
    if(node->leftChild) {//继续寻找节点
      insertNode(number, node->leftChild);
    }else {//插入节点
      insertRBTreeNode(number, node, node->leftChild);
    }
    
  }else if (node->value < number){
    if(node->rightChild) {//继续寻找节点
      insertNode(number, node->leftChild);
    }else {//插入节点
      insertRBTreeNode(number, node, node->rightChild);
    }
  }else {
     node->value = number;//2.值相同的处理,此处简单,如果数据多的,需要替换数据
  }
  
}
//红黑树节点插入部分
void insertRBTreeNode(int number, RBTree *node, RBTree *child) {
  if (1 == node->color) {//3.父节点为黑色节点,直接插入.设置为红色
    insertRedNode(number,node,child);
  }else if(0 == node->color) {//4.如果父节点为红色节点
    insertRedNode(number,node,child);
    fixRBTreeAfterInsert(child);
  }else {
    printf("节点数据错了,value为%d的节点颜色异常",node->value);
  }
}


void fixRBTreeAfterInsert(RBTree *insertedNode) {
  
  RBTree *parent = insertedNode->parent;
  RBTree *pp = insertedNode->parent->parent;
  RBTree *PB = getBrother(parent);
  if (PB && 0 == PB->color) {//4.1如果叔叔节点存在并且是红色
      pp->color = 0;
      PB->color = 1;
      parent->color = 1;
    
    if(!pp->parent) {//当pp节点为root节点,把root节点颜色变为黑色,树的黑色深度+1 退出.
      pp->color = 1;
      return;
    }
    
    if (0 == pp->parent->color) {//如果pp的父节点还是红色那就 pp为c节点继续迭代
      fixRBTreeAfterInsert(pp);
    }
    return;
    
  }else if(!PB || 1 == PB->color) {//4.2 叔叔节点为黑色节点或者不存的情况
    if (isLeftChild(parent) && isLeftChild(insertedNode)) {//4.2.1 父节点和插入几点同为左节点 ,pp右旋
      parent->parent = pp->parent;
      parent->color = 1;
      if (isLeftChild(pp)) pp->parent->leftChild = parent;
      else pp->parent->rightChild = parent;
      parent->rightChild = pp;
      pp->parent = parent;
      pp->color = 0;
    }else if(isLeftChild(parent) && isRightChild(insertedNode)) {//4.2.2 父节点为左节点,插入节点为右节点,父节点左旋后pp节点右旋
      insertedNode->parent = pp->parent;
      if (isLeftChild(pp)) pp->parent->leftChild = insertedNode;
      else pp->parent->rightChild = insertedNode;
      insertedNode->color = 1;
      insertedNode->leftChild = parent;
      parent->parent = insertedNode;
      insertedNode->rightChild = pp;
      pp->parent = insertedNode;
      pp->color = 0;
    }else if(isRightChild(parent) && isLeftChild(insertedNode)) {//4.2.3 父节点为右节点,插入节点为左节点 父节点右旋,pp节点左旋,
      insertedNode->parent = pp->parent;
      if (isLeftChild(pp)) pp->parent->leftChild = insertedNode;
      else pp->parent->rightChild = insertedNode;
      insertedNode->color = 1;
      insertedNode->rightChild = parent;
      parent->parent = insertedNode;
      insertedNode->leftChild = pp;
      pp->parent = insertedNode;
      pp->color = 0;
    }else {//4.2.4 父节点为右节点,pp节点左旋
      parent->parent = pp->parent;
      if (isLeftChild(pp)) pp->parent->leftChild = parent;
      else pp->parent->rightChild = parent;
      parent->color = 1;
      parent->leftChild = pp;
      pp->parent = parent;
      pp->color = 0;
    }
  }
}


void insertRedNode(int number, RBTree *node, RBTree *child) {
  child = getNode(number);
  child->value = number;
  child->color = 0;
  child->parent = node;
}




static void deleteNode(int number, RBTree* node) {
  if(!node) return;

  if (number < node->value) {
    deleteNode(number, node->leftChild);
  }else if (number > node->value) {
    deleteNode(number, node->rightChild);
  }else {
    delete(node);
  }
}

static void delete(RBTree* node) {
  //查找最终要删除的叶子节点
  RBTree* rpNode = findReplaceNodeOfLeafNode(node);
  if (0 == rpNode->color) {//1.如果要删除的替代叶子节点的颜色为红色,直接删除
    free(rpNode);
    rpNode = NULL;
  }else if (1 == rpNode->color) {//根据红黑树性质任何一个节点的到叶子节点的黑节点数相同,推出叶子节点和其兄弟节点的颜色肯定相同
    if (0 == rpNode->parent->color) {//把父节点的颜色变为黑色,兄弟节点的颜色变为红色,删除替换节点
      rpNode->parent->color = 1;
      if (isLeftChild(rpNode)) rpNode->parent->rightChild->color = 0;
      else rpNode->parent->leftChild->color = 0;
      free(rpNode);
      rpNode = NULL;
    }else if (1 == rpNode->parent->color) {//把兄弟节点的颜色变为红色,删除替代节点,以父节点为起点开始fix红黑树
      RBTree *brother = getBrother(rpNode);
      RBTree *parent = rpNode->parent;
      
      if(!brother) return;
      if(1 == brother->color){
        if (isLeftChild(rpNode)) rpNode->parent->rightChild->color = 0;
        else rpNode->parent->leftChild->color = 0;
        free(rpNode);
        rpNode = NULL;
        fixRBTreeAfterDeleteOperate(rpNode->parent);
      }else if(0 == brother->color) {
        free(rpNode);
        rpNode = NULL;
        if (isLeftChild(brother)) {//父节点右旋,b节点改为黑色,b的右子节点改为红色.
          brother->parent = parent->parent;
          if(isLeftChild(parent)) parent->parent->leftChild = brother;
          else parent->parent->rightChild = brother;
          brother->color = 1;
        
          
          if (brother->rightChild) {
            brother->rightChild->parent = parent;
            parent->leftChild = brother->rightChild->parent;
            parent->leftChild->color = 0;
          }
          
          parent->parent = brother;
          brother->rightChild = parent;
          
        }else { //父节点左旋,b节点改为黑色,b的左子节点改为红色.
          brother->parent = parent->parent;
          if(isLeftChild(parent)) parent->parent->leftChild = brother;
          else parent->parent->rightChild = brother;
          brother->color = 1;
          
          
          if (brother->leftChild) {
            brother->leftChild->parent = parent;
            parent->rightChild = brother->leftChild->parent;
            parent->rightChild->color = 0;
          }
          
          parent->parent = brother;
          brother->leftChild = parent;
        }
      }
      
      
    }else {
       printf("节点数据错了,value为%d的节点颜色异常",rpNode->parent->value);
    }
  }else {
    printf("节点数据错了,value为%d的节点颜色异常",rpNode->value);
  }
  
  
}

RBTree* findReplaceNodeOfLeafNode(RBTree* node) {
  RBTree * replaceNode = NULL;
  if(node->rightChild) {
    replaceNode = findNodeSuccessorOfLeafNode(node->rightChild);
    node->value = replaceNode->value;
    return findReplaceNodeOfLeafNode(replaceNode);
  }else if(node->leftChild) {
    replaceNode = findNodePredecessorOfLeafNode(node);
    node->value = replaceNode->value;
    return findReplaceNodeOfLeafNode(replaceNode);
  }else {
    return node;
  }
}

void fixRBTreeAfterDeleteOperate(RBTree* node) {
  //2.1 替换节点为父节点的左子节点时
  if(isLeftChild(node)){
    RBTree *parent = node->parent;
    RBTree *brother = parent->rightChild;
    if(0 == brother->color) {//2.1.1 替代节点的兄弟节点为红色节点,将兄弟节点变为黑色,父节点变为红色,将父节点左旋,进行2.1.2.3处理
      parent->color = 0;
      brother->color = 1;
      //父节点左旋操作
      if(isLeftChild(parent)) parent->parent->leftChild = brother;
      else parent->parent->rightChild = brother;
      brother->parent = parent->parent;
      
      if (brother->leftChild) {
        brother->leftChild->parent = parent;
        parent->rightChild = brother->leftChild;
      }
      
      parent->parent = brother;
      brother->leftChild = parent;
      fixRBTreeAfterDeleteOperate(node);
    }else if(1 == brother->color){//2.1.2 替代节点的兄弟节点为黑色
      RBTree *bc = brother->rightChild;
      RBTree *blc = brother->leftChild;
      if (0 == bc->color) {//2.1.2.1 替代节点的兄弟节点的右节点为红色:bc变为黑色,parent变为黑色 brother变为parent的颜色,然后parent左旋
        bc->color = 1; //bc变为黑色
        brother->color = parent->color; //brother变为parent的颜色
        parent->color = 1; //parent变为黑色

        //然后parent左旋,brother的左孩子只能为nil或者红色,因为根据d每个节点到叶子节点的黑节点个数相同的法则
        if (isLeftChild(parent)) parent->parent->leftChild = brother;
        else parent->parent->rightChild = brother;
        brother->parent = parent->parent;

        parent->rightChild = brother->leftChild;
        if (brother->leftChild) brother->leftChild->parent = parent;

        brother->leftChild = parent;
        parent->parent = brother;
        return;
      }else if(0 == blc->color) {//2.1.2.2 brother与blc 互换颜色 brother 右旋 转成2.1.2.1的情况
        //互换颜色
        blc->color = 1;
        brother->color = 0;
        
        //brother 右旋
        blc->parent = brother->parent;
        brother->parent->rightChild = blc;
        
        if (blc->rightChild) {
          blc->rightChild->parent = brother;
          brother->leftChild = blc->rightChild;
        }
        
        brother->parent = blc;
        blc->rightChild = brother;
        
        fixRBTreeAfterDeleteOperate(node);
      }else if(1 == bc->color && 1 == blc->color) {
        if(NULL == node->parent) return;
        
        brother->color = 0;
        fixRBTreeAfterDeleteOperate(parent);
      }
      else {
        printf("节点数据错了,value为%d or %d的节点颜色异常",blc->value,bc->value);
      }
    }else {
      printf("节点数据错了,value为%d的节点颜色异常",brother->value);
    }
  }else {//2.2 替换节点为父节点的右子节点时
    RBTree *parent = node->parent;
    RBTree *brother = parent->leftChild;
    if (0 == brother->color) { //2.2.1 parent和brother互换颜色  parent右旋
      //互换颜色
      parent->color = 0;
      brother->color = 1;
      
      //parent右旋
      brother->parent = parent->parent;
      if (isLeftChild(parent)) parent->parent->leftChild = brother;
      else parent->parent->rightChild = brother;
    
      if (brother->rightChild) {
        brother->rightChild->parent = parent;
        parent->leftChild = brother->rightChild;
      }
      
      parent->parent = brother;
      brother->rightChild = parent;
      
      //递归操作
      fixRBTreeAfterDeleteOperate(node);
    }else if (1 == brother->color) { //2.2.2 兄弟节点的颜色是黑色
      RBTree *blc = brother->leftChild;
      RBTree *bc = brother->rightChild;
      if (0  == blc->color) {//2.2.2.1 兄弟节点的做节点是红色,p节点变黑色,b节点变为p的颜色,blc变黑色,p右旋
        //换颜色
        brother->color = parent->color;
        parent->color = 1;
        blc->color = 1;
        
        //p节点右旋
        brother->parent = parent->parent;
        if (isLeftChild(parent)) parent->parent->leftChild = brother;
        else parent->parent->rightChild = brother;
        
        if (brother->rightChild) {
          brother->rightChild->parent = parent;
          parent->leftChild =  brother->rightChild;
        }
        
        parent->parent = brother;
        brother->rightChild = parent;
        return;
        
      }else if (0 == bc->color) {//2.2.2.2 兄弟节点的右节点为红色节点, 右节点和兄弟节点互换颜色,兄弟节点左旋.
        //互换颜色
        brother->color = 0;
        bc->color = 1;
        
        //兄弟节点左旋
        bc->parent = parent;
        parent->leftChild = bc;
        
        if (bc->leftChild) {
          bc->leftChild->parent = parent;
          parent->rightChild = bc->leftChild;
        }
        
        parent->parent = bc;
        bc->leftChild = parent;
        fixRBTreeAfterDeleteOperate(node);

      }else if (1 == blc->color && 1 == bc->color) {
        brother->color = 0;
        fixRBTreeAfterDeleteOperate(parent);
      }
      else {
        printf("节点数据错了,value为%d or %d的节点颜色异常",blc->value,bc->value);
      }
    }else {
      printf("节点数据错了,value为%d的节点颜色异常",brother->value);
    }
  }
}


RBTree* findNodePredecessorOfLeafNode(RBTree* node) {//在叶子节点找前驱节点 此处的Node 为节点的左孩子节点
  if (!node) return NULL;
  if (node->rightChild) {
    return findNodePredecessorOfLeafNode(node->rightChild);
  }
  return node;
}

RBTree* findNodeSuccessorOfLeafNode(RBTree* node) {//在叶子节点上找后继节点
  if(node) return NULL;
  if (node->leftChild) {
    return findNodeSuccessorOfLeafNode(node->leftChild);
  }
  return node;
}

RBTree* findSuccessorNode(RBTree* node) {
  RBTree *find = findNodeSuccessorOfLeafNode(node->rightChild);
  if (find) return find;
  
  RBTree *flag = node->parent;
  while (flag && flag == flag->parent->rightChild) {
    flag = flag->parent;
  }
  
  return flag;
}

bool isLeftChild(RBTree *node) {
  if(!node) return false;
  if(!node->parent) return false;
  return node == node->parent->leftChild;
}

bool isRightChild(RBTree *node) {
  if(!node) return false;
  if(!node->parent) return false;
  return node == node->parent->rightChild;
}

RBTree* getBrother(RBTree* node) {
  if (!node->parent) return NULL;
  return node == node->parent->leftChild ?  node->parent->rightChild : node->parent->leftChild;
}


RBTree* getNode(int number) {
  RBTree *node = malloc(sizeof(RBTree));
  node->value = number;
  node->color = -1;
  node->leftChild = NULL;
  node->rightChild = NULL;
  node->parent = NULL;
  return node;
}
@end
