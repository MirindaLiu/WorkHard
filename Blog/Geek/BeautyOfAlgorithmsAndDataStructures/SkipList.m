//
//  jumpList.m
//  Blog
//
//  Created by Mirinda on 2019/7/5.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import "SkipList.h"
#define interval   2
static int skipLevel = 0;
static skipListIndex* skipIndex[16] = {NULL};
@implementation SkipList
- (void)skipListInto {
//    insertNode(10);
//    insertNode(20);
//    insertNode(30);
//    insertNode(11);
//    insertNode(9);
//    insertNode(6);
//    insertNode(17);
//    insertNode(22);
//    insertNode(5);
//    insertNode(16);
//    insertNode(3);
//    insertNode(23);
//    insertNode(21);
//    insertNode(1);
//    insertNode(31);
//    insertNode(19);
//    insertNode(15);
//    insertNode(26);
//    insertNode(13);
//    insertNode(7);
  insertNode(10);
  insertNode(20);
  insertNode(30);
  insertNode(11);
  insertNode(9);
  insertNode(15);
  insertNode(22);
  insertNode(3);
  insertNode(1);
  insertNode(31);
  insertNode(16);
  insertNode(23);
  insertNode(17);
  insertNode(6);
  insertNode(5);
  insertNode(26);
  insertNode(36);
  insertNode(100);
}

void insertNode(int number) {
  if (0 == skipLevel) {
    skipIndex[0] = getIndex();
    skipIndex[0]->head = getNode();
    skipIndex[0]->head->value = number;
    skipLevel++;
    return;
  }
  
  //插入到头节点
  if (skipIndex[skipLevel-1]->head->value > number) {
    insertNodeFirstPosition(number);
    fixSkipListAfterInsert();
    return;
  }
  
  insertNodeNormal(number);
  fixSkipListAfterInsert();
  
}

void insertNodeNormal(int number) {
  bool findNode = false;
  skipListNode *prev = skipIndex[skipLevel-1]->head;
  skipIndex[skipLevel-1]->currentNode = prev;
  skipListNode *flag = prev;
  int index = skipLevel-1;
  while (1) {
    //上一级已经找到节点
    if (findNode) {
      if (0 == index ) {
        break;
      }
      skipIndex[index]->downLevelNode = prev;
      prev = prev->down;
      index--;
      skipIndex[index]->currentNode = prev;
      continue;
    }
    
    //只有一级link
    if (0 == skipLevel-1) {
      skipIndex[skipLevel-1]->currentNode = skipIndex[skipLevel-1]->head;
      break;
    }
    
    //level级找到节点
    if (flag && flag->value>number) {
      //      skipIndex[index]->currentNode = prev;
      findNode = true;
      continue;
    }
    
    //level级没找到节点,但是已经是level级link最后一个节点
    if (!flag) {
      skipIndex[index]->downLevelNode = prev;
      prev = prev->down;
      flag = prev->next;
      index--;
      skipIndex[index]->currentNode = prev;
      
      if (0 == index) {
        break;
      }
      continue;
    }
    
    //level级没找到节点，但是还没到link的尾部
    prev = flag;
    flag = flag->next;
  }
  
  skipListNode *position = prev;
  while (position && position->value < number) {
    prev = position;
    position = position->next;
  }
  
  skipListNode *node = getNode();
  node->value = number;
  node->next = prev->next;
  prev->next = node;
}


void insertNodeFirstPosition (int number) {
  int i = skipLevel-1;
  for (i = skipLevel-1; i > 0; i--) {
    skipIndex[i]->head->value = number;
    skipIndex[i]->currentNode = skipIndex[i]->head;
    skipIndex[i]->downLevelNode = skipIndex[i]->head;
  }
  skipListNode* node = getNode();
  node->value = number;
  node->next = skipIndex[i]->head;
  skipIndex[i]->head = node;
  skipIndex[i]->currentNode = skipIndex[i]->head;
  
  if (skipIndex[i+1]) {
    skipIndex[i+1]->head->down = node;
  }
} 

void fixSkipListAfterInsert() {
  for (int i = 0; i < skipLevel; i++) {
    unsigned int max = 0xFFFFFFFF;
    if(skipIndex[i+1] && skipIndex[i+1]->downLevelNode->next)//注意这里是 downLevelNode 不是 currentNode
      max = skipIndex[i+1]->downLevelNode->next->value;
    
    int j = 0;
    skipListNode *current = skipIndex[i]->currentNode;
    skipListNode *prev = current;
    while (current && current->value < max) {
      j++;
      current = current->next;
    }
    
    if (j<4) {
      clearCurrentNode();
      return;
    }
    
    if (NULL == skipIndex[i+1]) {
      skipIndex[i+1] = getIndex();
      skipIndex[i+1]->head = getNode();
      skipIndex[i+1]->head->value = prev->value;
      skipIndex[i+1]->head->down = prev;
      skipIndex[i+1]->currentNode = skipIndex[i+1]->head;
      skipIndex[i+1]->downLevelNode = skipIndex[i+1]->head;
      skipLevel++;
    }
    
    skipListNode *node = getNode();
    node->next = skipIndex[i+1]->downLevelNode->next;//注意这里是 downLevelNode 不是 currentNode
    skipIndex[i+1]->downLevelNode->next = node;
    node->value = prev->next->next->value;
    node->down = prev->next->next;
  }
  clearCurrentNode();
  
}


static skipListNode* getNode() {
  skipListNode *node = malloc(sizeof(skipListNode));
  node->value = 0;
  node->next = NULL;
  node->down = NULL;
  return node;
}

static skipListIndex* getIndex() {
  skipListIndex *index = malloc(sizeof(skipListIndex));
  index->head = NULL;
  index->currentNode = NULL;
  index->downLevelNode = NULL;
  return index;
}

static void clearCurrentNode() {
  int i = 0;
  while(i<16 && NULL != skipIndex[i]) {
    skipIndex[i]->currentNode = NULL;
    skipIndex[i]->downLevelNode = NULL;
    i++;
  }
}

@end
