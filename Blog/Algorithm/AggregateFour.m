//
//  AggregateFour.m
//  Blog
//
//  Created by Mirinda on 2018/9/12.
//  Copyright © 2018年 Mirinda. All rights reserved.
//

#import "AggregateFour.h"

@implementation AggregateFour
+ (void)excuteMethod {
    NSLog(@"gcd(99,121) = %d",gcd(99,121));
    int a[10] = {1,2,3,4,5,6,7,8,9,10};
    int b[12] = {9,12,3,30,51,6,19,8,91,100,16,99};
    NSLog(@"key = %d",binarySearch(6,a,10));
//    selectSort(b, 12);
//    insertSort(b, 12);
    shellSort(b, 12);
    printArray(b,12);
}

void printArray (int *arr, int length) {
    for (int i = 0; i < length; i++) {
        printf("%d ",arr[i]);
    }
}

//求最大公约数 欧几里得算法 原理 加入有两个数a和b  他们侧公约数是u 那么可以得出结论 a = bt + r  也就是 a%b = r,  因为公约数为u 所以有 a = xu ,b= yu 所有有等式 xu = yu + r, 所以 r = (x-y)u 所以 u约为r 的最大公约数, 所以产生如下的递归函数, 当a小于b 是 第一层递归 会变成 gcd(b,a); 因为当a小于b 时  a%b = a
int gcd(int a, int b){
    if(0==b){
        return a;
    }
    int r = a % b;
    return gcd(b, r);
}

//二分查找
int binarySearch(int key, int* a, int length) {
    int low = 0;
    int high = length-1;
    while (low<=high) {
        int middle = (high+low)/2;
        if (key > a[middle]) low = middle+1;
        else if (key < a[middle]) high = middle -1;
        else return middle;
    }
    return -1;
}

#pragma -mark sort
//选择排序, 每次都是找最小的
void selectSort(int* a, int length) {
    for(int i = 0; i<length; i++) {
        for (int j = i+1; j<length; j++) {
            if(a[i] > a[j]) {
                int tmp = a[i];
                a[i] = a[j];
                a[j] = tmp;
            }
        }
    }
}

//插入排序
void insertSort(int *a, int length) {
    for (int i = 1; i < length; i++) {
        int tmp = a[i];
        for (int j = i-1; j>=0; j--) {
            if (tmp < a[j]) {
                a[j+1] = a[j];
                a[j] = tmp;
            }else {
                break;
            }
            
        }
    }
}

//希尔排序 插入排序的优化
void shellSort(int *a, int length) {
    int d = length/3;
    while(d >=1){
        for (int i = d; i<length; i++) {
            for (int j = i; j-d>=0; j=j-d) {
                if (a[j] < a[j-d]) {
                    int tmp =a[j];
                    a[j] = a[j-d];
                    a[j-d] = tmp;
                }else {
                    break;
                }
            }
        }
        d = d/3;
    }
}
@end
