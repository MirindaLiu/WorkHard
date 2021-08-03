//
//  sort.h
//  Blog
//
//  Created by Mirinda on 17/3/31.
//  Copyright © 2017年 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sort : NSObject

-(NSArray*)insertSort:(NSArray*)arr;

-(void)shellInsertSort:(NSMutableArray *)arr;
-(void)selectSort:(NSMutableArray*)arr;
-(void)twoEndsSelectSort:(NSMutableArray*)arr;
-(void)heapSort:(NSMutableArray*)arr;
-(void)bubbleSort:(NSMutableArray*)arr;
-(void)bubbleSortTwo:(NSMutableArray *)arr;
-(void)quicklySort:(NSMutableArray*)arr low:(int)low high:(int)high;
-(NSMutableArray*)mergeSort:(NSMutableArray*)sourceArr;
@end
