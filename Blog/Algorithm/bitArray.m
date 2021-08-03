//
//  bitArray.m
//  AppstoreCtl
//
//  Created by Mirinda on 2018/7/6.
//  Copyright © 2018年 Mirinda. All rights reserved.
//

#import "bitArray.h"

@interface bitArray()
@property (nonatomic, assign)char* bitArr;
@property (nonatomic, assign)long long int len;
@end


@implementation bitArray

- (char *)getBitArr:(long long int)length {
    self.len = length/8+1;
    self.bitArr = (char *)malloc(self.len);
    if (NULL != self.bitArr) {
        memset(self.bitArr, 0, self.len);
        
    }
    return self.bitArr;
}


- (BOOL)setNumberToBitArr:(int )number {
    if (self.len < number/8 - 1) {
        return NO;
    }
    int flag = number%8;
    self.bitArr[number/8] |= 1 << (8-flag);
    return YES;
}

- (BOOL)findNumberInBitArr:(int )number {
    if (self.len < number/8 - 1) {
        return NO;
    }
    
    int flag = number%8;
    self.bitArr[number/8] &= 1 << (8-flag);
    
    if (1 == self.bitArr[number/8] >> (8-flag)) {
        NSLog(@"find number");
    }else{
        NSLog(@"not find");
        return NO;
    }
    return YES;
}

- (BOOL)removeNumberInArr:(int)number {
    if (self.len < number/8 - 1) {
        return NO;
    }
    
    int flag = number%8;
    self.bitArr[number/8] ^= 1 << (8-flag);
    self.bitArr[number/8] >>= (8-flag);
    return YES;
}
@end


//#define BITSPERWORD 32
//#define SHIFT 5
//#define MASK 0x1F//2^5-1
//#define N 10000000
//int a[1 + N/BITSPERWORD];
//
////将第i位置1
//void set( int i)
//{
//    a[ i >> SHIFT] = ( a[ i >> SHIFT] | (1 << (i & MASK)));
//}
//
////将第i位清0
//void clr( int i)
//{
//    a[ i >> SHIFT] = ( a[ i >> SHIFT] & ~(1 << (i & MASK)));
//}
//
////判断对应位
//int test( int i)
//{
//    return a[ i >> SHIFT] & ( 1 << (i & MASK));
//}

//①m/(2^n) = m>>n;
//
//②m%(2^n) = ( m & 2^(n)-1 );
//
//③将int型变量a的第k位置1: a = ( a | (1 << k) );
//
//④将int型变量a的第k位清0: a = ( a & ~(1 <<k) ).

