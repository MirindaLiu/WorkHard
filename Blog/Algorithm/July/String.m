//
//  String.m
//  Blog
//
//  Created by Mirinda on 2019/6/19.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import "String.h"

@implementation String
- (void)stringInto {
    char str[] = "ABCDEFG";
//    stringTranslation(str, 2, 7);
    char str1[] = "1234";
    fullPermutation(str1,0,3);
}

//1.字符串翻转 实现如下功能:abcdefg -->cdefgab 需要事件复杂度O(n).空间负责度O(1)
//思路:先ab翻转ab->ba  再cdefg翻转gfedc 形成bagfedc,再翻转->acdefgab

void stringTranslation(char* str, int position,int length) {
    position = position % length;
    stringReversal(str,0, position - 1);
    stringReversal(str,position, length-1);
    stringReversal(str,0, length - 1);
    printf("str = %s",str);
}

void stringReversal(char* str, int from, int to) {
    if (from >= to) {
        return;
    }
    
    while(from < to) {
        char temp = str[from];
        str[from] = str[to];
        str[to] = temp;
        from++;
        to--;
    }
}


//全排列
void fullPermutation(char* str, int from, int to) {
    long length = strlen(str);
    if(!length) return;
    if(from == to) {
        printf("%s\n",str);
    }
    
    for (int i = from; i < length; i++) {
        swap(str, from, i);
        fullPermutation(str, from+1, to);
        swap(str, from, i);
    }
}

void swap(char* str, int from, int to)  {
    if(!strlen(str)) return;
    char temp = str[from];
    str[from] = str[to];
    str[to] = temp;
}

//KMP

//manacher

//BM
@end
