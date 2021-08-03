//
//  Heap.m
//  Blog
//
//  Created by Mirinda on 2019/8/6.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import "Heap.h"
static int top[16]={0};
@implementation Heap
- (void)HeapInto {
  int arr[32] = {-1,9,15,1,7,23,96,2,50,20,6,79,19,26,99,101,22,93,21,31,34,91,95,0,0,0,0,0,0,0,0,0};
//  createHeap(arr, 22, true);
////  heapSort(arr, 22);
////  insertHeap(arr, 22, 130);
//  deleteHeapHead(arr,22);
  
//  for (int i = 1; i< 23; i++) {
//    searchTopK(7, arr[i]);
//  }
  
    for (int i = 1; i< 23; i++) {
      printf("%d\n", middleValue(arr[i]));
    }
  int k = top[1];
}


//建堆
void createHeap(int *arr, int length, bool bigHeap) {
  for (int i = length/2; i > 0; i--) {
    heapify(arr, i, length, bigHeap);
  }
}

void heapify(int *arr, int pending, int length, bool bigHeap) {
  int flag = pending;
  while(true) {
    if (bigHeap) {
      if (2*pending <= length && arr[pending] < arr[2*pending]) flag = 2*pending;
      if (2*pending+1 <= length && arr[flag] < arr[2*pending+1]) flag = 2*pending+1;
    }else {
      if (2*pending <= length && arr[pending] > arr[2*pending]) flag = 2*pending;
      if (2*pending+1 <= length && arr[flag] > arr[2*pending+1]) flag = 2*pending+1;    }
    
    if (flag == pending)  break;
    swap(arr, flag, pending);
    pending = flag;
  }
}

//堆排序
static void heapSort(int *arr, int len) {
  createHeap(arr, len, true);
  int k = len;
  
  while(k>1) {
    swap(arr, 1, k);
    k--;
    heapify(arr, 1, k,true);
  }
}

//堆插入
void insertHeap(int *arr,int len, int insertNumber, bool isbig) {
  if (len > 31) return;
  arr[len+1] = insertNumber;
  int flag = len+1;
  if (isbig) {
    while (flag/2 > 0 && arr[flag/2] < arr[flag]) {
      swap(arr, flag, flag/2);
      flag = flag/2;
    }
  } else {
    while (flag/2 > 0 && arr[flag/2] > arr[flag]) {
      swap(arr, flag, flag/2);
      flag = flag/2;
    }
  }
  
}

//删除堆顶
void deleteHeapHead(int *arr,int len,bool isbig) {
  arr[1] = arr[len];
  arr[len] = 0;
  len--;
  heapify(arr, 1, len,isbig);
}

static void swap(int *arr, int a, int b) {
  int temp = arr[a];
  arr[a]= arr[b];
  arr[b] = temp;
}


//top k
void searchTopK(int k, int input) {
  static int flag = 1;
  if(flag<k) {
    top[flag] = input;
    flag++;
    return;
  }
  
  if (flag == k) {
    top[flag] = input;
    createHeap(top, 7, false);
    flag++;
    return;
  }

  if (input < top[1]) return;
  top[1] = input;
  heapify(top, 1, 7, false);
}


//middle value
int middleValue(int input) {
  static int bigLen = 0;
  static int smallLen = 0;
  static bool isbig = true;
  static int big[32] = {-1};
  static int small[32] = {-1};
  
  if (isbig) {
    insertHeap(big, bigLen, input, true);
    bigLen++;
    insertHeap(small, smallLen, big[1], false);
    smallLen++;
    deleteHeapHead(big, bigLen, true);
    bigLen--;
    isbig = false;
  }else {
    insertHeap(small, smallLen, input, false);
    smallLen++;
    insertHeap(big, bigLen, small[1], true);
    bigLen++;
    deleteHeapHead(small, smallLen, false);
    smallLen--;
    isbig = true;
  }
  
  if (smallLen > bigLen)  return small[1];
  else return  big[1];
  
}

@end
