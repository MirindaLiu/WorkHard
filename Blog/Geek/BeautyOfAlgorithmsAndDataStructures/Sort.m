//
//  Sort.m
//  Blog
//
//  Created by Mirinda on 2019/7/2.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import "Sort.h"

@implementation Sort
- (void)sortInto {
    int array[10] = {6,9,2,7,5,8,1,3,0,4};
    int array1[20] = {6,9,2,7,5,8,1,3,0,4,6,2,2,3,6,9,3,6,9,3};
//    bubbleSort(array, 10);
//    insertSort(array, 10);
//    selectSort(array, 10);
//    mergeSort(array, 0, 9);
//    quicklySort(array,0,9);
    countingSort(array1, 20);
    printfArr(array1, 20);
}

void printfArr(int *arr, int length) {
    for (int i = 0; i<length; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

//冒泡排序 (优化了的冒泡,如果循环一轮没有值交换,说明已经是有序数组)
//最优时间复杂度O(n),最差时间复杂度O(n^2),平均时间复杂度O(n^2),原地排序算法,稳定排序算法.
void bubbleSort(int *arr, int length) {
    for (int i = 0 ; i< length; i++) {
        bool flag = false;
        for (int j = 0 ; j< length-i-1; j++) {
            if(arr[j] > arr[j+1]) {
                int temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
                flag = true;
            }
        }
        if (!flag) {
            break;
        }
    }
}

//插入排序
//最优时间复杂度O(n),最差时间复杂度O(n^2),平均时间复杂度O(n^2),原地排序算法,稳定排序算法.
static void  insertSort(int *arr, int length){
    for (int i = 1; i <length; i++) {
        int j = i-1;
        int value = arr[i];
        while(j >= 0){
            if(arr[j]>value){
                arr[j+1] = arr[j];
            }else {
                break;
            }
            j--;
        }
        arr[j+1] = value;
    }
}

// 选择排序
//最优时间复杂度O(n^2),最差时间复杂度O(n^2),平均时间复杂度O(n^2),原地排序算法,稳定排序算法.
static void selectSort(int *arr, int length) {
    for (int i = 0; i<length; i++) {
        for (int j = i+1; j<length; j++) {
            if (arr[i] >arr[j]) {
                arr[i] = arr[i]^arr[j];
                arr[j] = arr[i]^arr[j];
                arr[i] = arr[i]^arr[j];
            }
        }
    }
}


//归并排序(分治思想,递归实现)
//最优时间复杂度O(nlogn),最差时间复杂度O(nlogn),平均时间复杂度O(nlogn),非原地排序算法,稳定排序算法.
void mergeSort(int *arr, int start, int end) {
    if(start>=end) return;
    
    mergeSort(arr, start, (start+end)/2);
    mergeSort(arr, (start+end)/2+1, end);
    merge(arr,start,(start+end)/2,(start+end)/2+1,end);
}

void merge(int *arr, int start1, int end1, int start2,int end2) {
    int arr1[10] = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    int i = 0;
    int s1 = start1;
    int s2 = start2;
    while ((s1 <= end1) || (s2 <= end2) ) {
        if (s1 > end1) {
            arr1[i] = arr[s2];
            s2++;
            i++;
            continue;
        }
        if (s2 > end2) {
            arr1[i] = arr[s1];
            s1++;
            i++;
            continue;
        }
        
        if (arr[s1] > arr[s2] ) {
            arr1[i] = arr[s2];
            s2++;
        }else {
            arr1[i] = arr[s1];
            s1++;
        }
        i++;
    }
    
    int s = start1;
    for (int j = 0; j <= end2 - start1; j++) {
        arr[s] = arr1[j];
        s++;
    }
}


//快排(分治思想,递归实现)
//最优时间复杂度O(nlogn),最差时间复杂度O(n^2),平均时间复杂度O(nlogn),原地排序算法,非稳定排序算法.
void quicklySort(int *arr, int start, int end) {
    if (start>=end ) return;
    int pivot = getPivot(arr, start, end);
    
    int i = start;
    for (int j = start; j< end ; j++) {
        if (arr[j]<= pivot) {
            swap(&arr[i],&arr[j]);
            i++;
        }
    }
    swap(&arr[i],&arr[end]);
    quicklySort(arr, start, i-1);
    quicklySort(arr, i+1, end);
}

int getPivot(int *arr, int start, int end){
    int middle = start+((end-start)>>1);
    if((arr[start]-arr[middle])*(arr[middle]-arr[end]) >= 0){
        swap(&arr[middle],&arr[end]);
    }else if((arr[middle]-arr[start])*(arr[start]-arr[end]) >= 0){
        swap(&arr[start],&arr[end]);
    }
    return arr[end];
}

static void swap(int *a, int *b) {
    int temp  = *a;
    *a = *b;
    *b = temp;
}

//计数排序O(n) 适用于特殊数据,例如:{6,9,2,7,5,8,1,3,0,4,6,2,2,3,6,9,3,6,9,3}
void countingSort(int *arr,int length) {
    int array[10] = {0};
    
    for (int i=0 ; i<length; i++) {
        array[arr[i]] += 1;
    }
    
    int j=0;
    for (int i=0 ; i<length; i++) {
        if(0 == array[j]) j++;
        arr[i] = j;
        array[j]--;
    }
}
@end
