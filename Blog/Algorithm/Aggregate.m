//
//  Aggregate.m
//  Blog
//
//  Created by Mirinda on 2018/6/25.
//  Copyright © 2018年 Mirinda. All rights reserved.
//

#import "Aggregate.h"
#import "sort.h"

@implementation Aggregate
// 入口函数
- (void)excuteMethod {
    int a[10] = {2,29,100,-9,19,7,13,-11,3,10};
    int re = getMaxSumOfSubcequence(a,10);
    NSLog(@"max = %d",re);
    NSLog(@"max-force = %d",getMaxOfSubcequenceForce(a, 10));
    NSLog(@"max-force-optisize = %d", getMaxOfSubcequenceForceOptimize(a, 10));
    NSLog(@"max-dac = %d",getMaxOfSubcequenceDAC(a, 0, 9));
    re = getSumClosestToZero(a, 10);
    NSLog(@"ClosestToZero = %d",re);
//    如"BCADBCAB" "BAACBCACD"
    char s1[] = {'B','C','A','D','B','C','A','B'};
    char s2[] = {'B','A','A','C','B','C','A','C','D'};
    int lcsLook[8][9] = {10};
    int len = getLCSLenght(s1, s2, 8, 9, lcsLook);
    NSLog(@"LCSLenght = %d", len);
    for (int i = 0; i<9; i++) {
        for (int j = 0; j<8; j++) {
            printf("%d ",lcsLook[j][i]);
        }
        printf("\n");
    }
    lookLCS(s1, 8, 9, lcsLook);
    int ed = getEditDistance(s1, s2, 8, 9);
    NSLog(@"EditDistance = %d",ed);
}


// 最大连续子序列的和 O(n),动态规划方式
// 方法:1(动态规划) ,数组A[n],假如前n项和s[i],那么s[i+1] 就是前i+1项的和,所以s[i+1] = s[i]+ A[i+1];  2,sum = s[i],如果sum > 0的话,那么后面的就累加 那么让sum = s[i]+ A[i+1], 如何 sum < 0 那么sum 就从头开始累计和 sum = A[i+1], 依次类推   时间复杂度:O(n)
int getMaxSumOfSubcequence (int *numbers, int length) {
    int retsult = 0;
    int sum = 0;
    int i = 0;
    while(i < length){
        if (sum > 0){
            sum += numbers[i];
        }else{
            sum = numbers[i];
        }
        
        if (sum > retsult) {
            retsult = sum;
        }
        i++;
    }
    return retsult;
}

//方法:(暴力法)就是列举出所有的子序列,取出最大的 例子:1 3 9 6 7 10 -30 20, i 指针从1开始往后挪, j指针从i的位置往后挪,k指针从i的位置挪到j,通过这样把所有的子串罗列出来, 比如  i = 0, j = 3   sum = 1+3+9 j不断往后挪 最后到20的位置,1+3+9+...+20  时间复杂度:O(n^3)
int getMaxOfSubcequenceForce (int *numbers, int length) {
    int sum = numbers[0];
    for (int i = 0 ; i<length; i++) {
        for (int j = i; j<length; j++) {
            int subSum = 0;
            for (int k = i; k<=j; k++) {
                subSum = subSum+numbers[k];
            }
            if (subSum >sum) {
                sum = subSum;
            }
        }
    }
    return sum;
}

//方法3:(暴力法优化) 这方法就是 在加到最后一个字符的过程中,每个加一个数都是一个子字符串,所以每加一个就比较一下.而方法二则是 加完一完整的字符再比较时间复杂度:O(n^2)
int getMaxOfSubcequenceForceOptimize(int *numbers, int length){
    int sum = numbers[0];
    for (int i = 0; i< length; i++) {
        int subSum = 0;
        for (int j = i; j<length; j++) {
            subSum = subSum + numbers[j];
            if (sum < subSum) {
                sum = subSum;
            }
        }
    }
    return sum;
}

//方法4:(分治法)
int getMaxOfSubcequenceDAC(int *numbers, int form, int to){
    if (form == to) {
        return numbers[form];
    }
    int middle = (form+to)/2;
    int l = getMaxOfSubcequenceDAC(numbers, form, middle);//zu
    int r = getMaxOfSubcequenceDAC(numbers, middle+1, to);
    
    int lm = numbers[middle];
    int now = lm;
    for (int i = middle-1; i>=form; i--) {
        now = now + numbers[i];
        lm = now<lm?:now;
    }
    int rm = numbers[middle+1];
    now = rm;
    for (int j = middle+2 ; j<=to; j++) {
        now = now + numbers[j];
        rm = now<rm?:now;
    }
    int a =  MAX(l, r);
    return MAX(a, (lm+rm));
}

//求最接近0的连续子序列
//方法: 1,申请同待计算数组 同样长度的 数组空间,存储下,对应存储下前n项的和,例如: 待计算数组为 A[n], 存储数组s[n] 那么s[0]存储A[0], s[1]存储A[0]+A[1], s[2]存储A[0]+A[1]+A[2] 依次类推 s[n-1]存储A[0]+A[1]+A[2]+...+A[n-1]; 2,s[n]数组进行排序 3, 对s[n]数组内,任意相邻两项进项相减,找出绝对值最小的数为sum1 4,找出s[n] 中绝对值最小的数 记为sum2  5, 最接近0的子序列和 为: min(sum1,sum2)
int getSumClosestToZero(int *numbers, int length) {
    int sum[10] = {0};
    int sums = 0;
    int i = 0;
    while (i < length) {
        sums += numbers[i];
        sum[i] = sums;
        i++;
    }
    NSMutableArray *array = [NSMutableArray array];
    sort *s = [[sort alloc]init];
    [s heapSort:[Aggregate arrToNSArr:sum length:10 nsArr:array]];
    int sumArr[10] = {0};
    [Aggregate NSArrToArr:array length:10 arr:sumArr];
    NSLog(@"array = %@",array);
    int k = 1;
    int sub1 = sumArr[1] - sumArr[0];
    while (k < 10-1) {
        sub1 = abs(sub1) < abs(sumArr[k+1] - sumArr[k]) ? sub1 : sumArr[k+1] - sumArr[k];
        k++;
    }
    
    int sub2 = sumArr[0];
    int n = 1;
    while (n < 10) {
        sub2 = abs(sub2) < sumArr[i] ? sub2:sumArr[i];
        n++;
    }
    return abs(sub1) < abs(sub2) ? sub1 :sub2;
}

+ (NSMutableArray *)arrToNSArr:(int *)arr  length:(int)len nsArr:(NSMutableArray *)array {
    int i = 0;
    while(i < len){
        array[i] = [NSNumber numberWithInt:arr[i]];
        i++;
    }
    
    return array;
}

+ (void)NSArrToArr:(NSArray* )arr length:(int)len arr:(int *)array{
    int i = 0;
    while(i<len) {
        array[i] = [arr[i] intValue];
        i++;
    }
}


//最大子序列 LCS, 求最大的子序列的长度  如"BCADBCAB" "BAACBCACD"   得到最大子序列是B A BCA  ->BABCA  长度为5
int getLCSLenght(char* s1, char* s2, int len1, int len2 , int look[][9]) {
    char lcs[9][10] = {0};
    
    for (int i = 1; i<=len1; i++) {
        for (int j = 1; j<=len2; j++) {
            if(s1[i-1] == s2[j-1]) {
                lcs[i][j] = lcs[i-1][j-1]+1;
                look[i-1][j-1] = 0;
            }else {
                if(lcs[i-1][j] >lcs[i][j-1]) {
                    lcs[i][j] = lcs[i-1][j];
                    look[i-1][j-1] = 1;
                }else {
                    lcs[i][j] = lcs[i][j-1];
                    look[i-1][j-1] = -1;
                }
            }
        }
    }
    
    return lcs[8][9];
}


void lookLCS(char* s1, int len1, int len2, int look[][9]) {
    if (0 == len1 || 0 == len2 ) {
        return;
    }
    
    if (0 == look[len1-1][len2-1]) {
        lookLCS(s1,len1-1,len2-1,look);
        NSLog(@"%c-- ",s1[len1-1]);
    }else if (1 == look[len1-1][len2-1]) {
        lookLCS(s1,len1-1,len2,look);
    }else if (-1 == look[len1-1][len2-1]) {
        lookLCS(s1,len1,len2-1,look);
    }
    
}

//下面的算法不正确,忘记处理第一行和第一列了 导致计算错误 请看firstLook的方法
int getEditDistance(char* s1, char* s2, int len1, int len2) {
    char ed[9][10] = {0};
    for (int i=1; i<=len1; i++){
        for (int j = 1; j<=len2; j++) {
            if (s1[i-1] == s2[j-1]) {
                ed[i][j] = ed[i-1][j-1];
            }else{
                ed[i][j] = MIN(ed[i-1][j-1], MIN(ed[i-1][j], ed[i][j-1]))+1;
            }
        }
    }
    //测试打出矩阵
    for (long i = 0; i <= len2; i++) {
        for (long j = 0 ;j<=len1 ; j++) {
            printf("%d ",ed[i][j]);
        }
        printf("\n");
    }
    return ed[8][9];
}
@end
