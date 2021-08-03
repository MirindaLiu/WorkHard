//
//  BinarySearch.m
//  Blog
//
//  Created by Mirinda on 2019/7/4.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import "BinarySearch.h"

@implementation BinarySearch

- (void)BSearchInto {
    int arr[15] = {1,2,7,9,12,16,16,16,16,16,16,19,22,23,30};
//    int value = binarySearch(arr, 10, 10);
//    int value = binarySearchRecursionImplementation(arr,0,10,26);
//    int value = binarySearchFirstInSearchkeys(arr,15,1);
//    int value = binarySearchFirstInSearchkeys2(arr,15,1);
//    int value = binarySearchLastKeyInSearchkeys(arr,15,9);
    int value =  binarySearchFrontOrbackPositionOfKeys(arr,15,10,false);
    printf("key = %d\n",value);
}

static int binarySearch(int *array, int length, int key) {
    int low = 0;
    int high = length-1;
    while (low <= high) {
        int middle = low+(high-low)/2;
        if(array[middle] == key) return middle;
        else if(array[middle] > key) high = middle-1;
        else low = middle + 1;
    }
    return -1;
}

int binarySearchRecursionImplementation(int *array, int start, int end, int key) {
    if(start > end) return -1;
    int middle = start+(end-start)/2;
    if(array[middle] == key) return middle;
    else if(array[middle] > key) end = middle-1;
    else start = middle + 1;
    return binarySearchRecursionImplementation(array,start,end,key);
}


int binarySearchFirstInSearchkeys(int *array, int length, int key) {//思路就是最后定位到firstKey前一个数时low == high, 然后low=low+1; 然后取low 正好是firstKey
    int low = 0;
    int high = length-1;
    while (low<=high) {
        int middle = low+((high-low)>>1);
        if (array[middle] >= key) {
            high = middle -1;
        }else {
            low = middle + 1;
        }
    }
    
    if(low < length && array[low] == key) return low;
    else return -1;
}

//方法二  (查找要找的key中的第一个key的位置比如:1,2,3,6,6,6,9 找6 返回 3)
int binarySearchFirstInSearchkeys2(int *array, int length, int key) {
    int low = 0;
    int high = length-1;
    while(low <= high) {
        int mid = low+((high-low)>>1);
        if (array[mid] > key) {
            high = mid -1;
        } else if(array[mid] < key) {
            low = low + 1;
        }else {
            if(0 == mid || (array[mid-1] != key)) return mid;
            else high = mid - 1;
        }
    }
    return -1;
    
}

int binarySearchLastKeyInSearchkeys(int *array, int length, int key) {
    int low = 0;
    int high = length-1;
    while (low<=high) {
        int mid = low+((high-low)>>1);
        if (array[mid] > key) {
            high = mid - 1;
        }else if(array[mid] < key) {
            low = mid + 1;
        }else {
            if (mid == length -1 || array[mid+1] != key) return mid;
            else low = mid + 1;
        }
    }
    
    return -1;
}

int binarySearchFrontOrbackPositionOfKeys(int *array, int length, int key, bool isFront) {
    int low = 0;
    int high = length-1;
    while (low<=high) {
        int mid = low+((high-low)>>1);
        if (array[mid] > key) {
            high = mid - 1;
        }else if(array[mid] < key) {
            low = mid + 1;
        }else {
            if (isFront){
                if(mid > 0 && array[mid-1] != key) return mid-1;
                else high = high - 1;
            }else {
                if (mid < length -1 && array[mid+1] != key) return mid+1;
                else low = mid + 1;
            }
        }
    }
    
    return -1;
}


@end
