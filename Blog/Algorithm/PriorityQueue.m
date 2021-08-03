//
//  PriorityQueue.m
//  Blog
//
//  Created by Mirinda on 2018/11/30.
//  Copyright © 2018 Mirinda. All rights reserved.
//

//思路可借鉴: http://www.cnblogs.com/CarpenterLee/p/5488070.html
#import "PriorityQueue.h"

@interface  PriorityQueue ()
@property(nonatomic, strong) NSMutableArray *PQ;
@end

@implementation PriorityQueue
static NSMutableArray * PQ;

//为了方便使用OC实现

//初始化函数
- (instancetype)init {
    if (self = [super init]) {
        self.PQ = [NSMutableArray array];
        return self;
    }
    return nil;
}

//offer函数 插入一个元素
- (void)offer:(NSNumber *)number {
    if(!self.PQ) {
        self.PQ = [NSMutableArray array];
    }
    [self.PQ addObject:number];
    [self siftUP];
    
}

//更新 是去添加成员后,仍然是优先队列
- (void)siftUP {
    if (self.PQ.count <= 1) {
        return;
    }
    int pos = self.PQ.count -1;
    while(pos>0){
        if(NSOrderedAscending == [self.PQ[pos] compare: self.PQ[(pos-1)/2]]) {
            [self.PQ exchangeObjectAtIndex:pos withObjectAtIndex:(pos-1)/2];
            pos = (pos-1)/2;
            continue;
        }
        break;
    }
}

//peek 取最小值 即最优先的
- (NSNumber *)peek {
    if (self.PQ.count < 1) {
        NSLog(@"队列无内容");
        return nil;
    }

    return self.PQ[0];
}

//删除栈顶
- (void)poll {
    if (self.PQ.count < 1) {
        NSLog(@"队列无内容");
        return;
    }
    //删除栈顶,让数组最后一个对象变成栈顶
    [self.PQ exchangeObjectAtIndex:0 withObjectAtIndex:self.PQ.count-1];
    [self.PQ removeLastObject];
    [self siftDown:0];
    
}

//使数组恢复到优先队列
- (void)siftDown:(int)pos {
    if (self.PQ.count < 1) {
        NSLog(@"队列无内容");
        return;
    }
    
    int currntPos = pos;
    int RPos = 2*pos+2;
    while(RPos < self.PQ.count) {
        if (NSOrderedAscending == [self.PQ[currntPos] compare: self.PQ[RPos]]) {
            break;
        }
        [self.PQ exchangeObjectAtIndex:currntPos withObjectAtIndex:RPos];
        currntPos = RPos;
        RPos = 2*RPos+2;
    }
    
}

//remove Obj
- (void) remove:(NSNumber *)num {
    int index = [self.PQ indexOfObject:num];
    if (index == NSNotFound) {
        NSLog(@"栈中没有要找的对象");
        return;
    }
    int lastIndex = self.PQ.count-1;
    if (index == lastIndex) {
        [self.PQ removeLastObject];
        return;
    }
    
    //交换位置,再删除要删除的对象
    [self.PQ exchangeObjectAtIndex:index withObjectAtIndex:lastIndex];
    [self.PQ removeLastObject];
    
    //使队列再次成为优先队列
    [self siftDown:index];
}

@end
