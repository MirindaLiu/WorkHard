//
//  queue.m
//  Blog
//
//  Created by Mirinda on 2019/7/2.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import "queue.h"
static char q[10] = {0};
static int head = 0;
static int tail = 0;
static int length = 10;
@implementation queue

- (void)queueInto {
    
//    for (int i = 0; i < 7; i++) {
//        enQueue(i+'0');
//        printf("queue = %s\n",q);
//    }
//
//    for (int i = 0; i < 5; i++) {
//        deQueue();
//        printf("queue = %s\n",q);
//    }
//
//    for (int i = 0; i < 10; i++) {
//        bool b = enQueue(i+'0');
//        if (!b) {
//            printf("队列已满!\n");
//        }
//        printf("queue = %s\n",q);
//    }
//
//    for (int i = 0; i < 5; i++) {
//        deQueue();
//        printf("queue = %s\n",q);
//    }
//
//    for (int i = 0; i < 10; i++) {
//        bool b = enQueue(i+'0');
//        if (!b) {
//            printf("队列已满!\n");
//        }
//        printf("queue = %s\n",q);
//    }
    
    initQueue();
    for (int i = 0; i < 7; i++) {
        circulationQueueEn(i+'0');
        printf("queue = %s\n",q);
    }
    
    for (int i = 0; i < 5; i++) {
        circulationQueueDe();
        printf("queue = %s\n",q);
    }
    
    for (int i = 0; i < 10; i++) {
        bool b = circulationQueueEn(i+'0');
        if (!b) {
            printf("队列已满!\n");
        }
        printf("queue = %s\n",q);
    }
    
    for (int i = 0; i < 15; i++) {
        int a = circulationQueueDe();
        if (0 == a) {
            printf("队列已空!\n");
        }
        printf("queue = %s\n",q);
    }
    
    for (int i = 0; i < 10; i++) {
        bool b = circulationQueueEn(i+'0');
        if (!b) {
            printf("队列已满!\n");
        }
        printf("queue = %s\n",q);
    }
}


void initQueue() {
    memset(q,0,length);
    head = 0;
    tail = 0;
}

//入队
bool enQueue(char event) {
    if(0 == head && length-1 == tail) return false;
    if(length-1 == tail) {
        for (int i = 0; i < tail-head; i++) {
            q[i] = q[head+i];
        }
        tail = tail - head;
        head = 0;
    }
    
    q[tail] = event;
    tail++;
    return true;
}

// 出队
char  deQueue() {
    if (head == tail) {
        return -1;
    }
    
    int temp = 0;
    temp = q[head];
    head++;
    return temp;
}


//循环队列
bool circulationQueueEn(char event) {
    int tailtemp = (tail+1)%length;
    if (tailtemp == head) return false;
    q[tail] = event;
    tail = tailtemp;
    return true;
}

char circulationQueueDe() {
    if (head == tail) return 0;
    char temp = q[head];
    head = (head+1)%length;
    return temp;
}

@end
