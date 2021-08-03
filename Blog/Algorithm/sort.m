//
//  sort.m
//  Blog
//
//  Created by Mirinda on 17/3/31.
//  Copyright © 2017年 Mirinda. All rights reserved.
//

#import "sort.h"

@implementation sort

//一、插入排序

//1、插入排序—直接插入排序(Straight Insertion Sort)
//插入排序 排序思想就是从第1个元素开始与前面的元素排序，每次递增一个元素，一直保持递增时，之前的所有元素排列是有序的。保持有序的方式是，加入现在是第n(B元素)个元素(n>0),拿n元素与n-1一个元素比较大小，如果第n个元素大于第n-1个元素，保持不变，再去把第n+1个元素进行排序；如果第n个元素小于第n-1个元素，那就把第n个元素和第n-1个元素换位，然后拿n-1 与 n-2 比较，直到B元素找到比其小的元素，或者到了第0个元素。
//步骤：
//1、第n（n>0）个元素与第n-1个元素比较大小 ,Vn>Vn-1时执行2a；Vn<Vn-1执行2b
//2a、取第n+1个元素继续执行第1步，n为最后一个元素时执行3，
//2b、执行第二步，交换n-1和n的位置，n编程现在的n-1执行第1步，如果n-1为第0个元素，执行第2a步，
//3、 排序完成


-(NSArray*)insertSort:(NSArray*)arr
{
    NSMutableArray* muarr = [NSMutableArray array];
    for (int i = 0; i<arr.count; i++)
    {
        [muarr addObject:arr[i]];
       
        for (int k= i; k>0; k--)
        {
            NSComparisonResult ret = [(NSNumber*)muarr[k] compare:(NSNumber*)muarr[k-1]];
            if (NSOrderedAscending == ret)
            {
                [muarr exchangeObjectAtIndex:k withObjectAtIndex:k-1];
            }
            else
            {
                break;
            }
        }
    }
    
    return muarr;
}



//2、插入排序—希尔排序（Shell‘s Sort）
//思想：就是通过间隔(s)把数组分成若干组，每组进行插入排序，然后改变间隔(s)的大小 然后再分成若干组，然后再排序， 知道间隔等于数组的长度，然后对整个数组进行插入排序
-(void)insertSort:(NSMutableArray *)arr  space:(NSInteger)s
{
    for (NSInteger i=s; i<arr.count; i++)
    {
        for(NSInteger k=i; k>=s; k=k-s)
        {
            NSComparisonResult ret = [(NSNumber*)arr[k] compare:(NSNumber*)arr[k-s]];
            if (NSOrderedAscending == ret)
            {
                [arr exchangeObjectAtIndex:k withObjectAtIndex:k-s];
            }
            else
            {
                break;
            }
        }
    }
    
}

-(void)shellInsertSort:(NSMutableArray *)arr
{
    NSInteger dk = arr.count/2;
    while (dk>=1)
    {
        [self insertSort:arr space:dk];
        dk = dk/2;
    }
}


//二、选择排序

//1、简单选择排序
//思想：每对数组进行一次遍历，找出一个最小的元素，然后把剩下的元素遍历，直到剩下一个元素为止
-(void)selectSort:(NSMutableArray*)arr
{
    for (NSInteger i = 0; i<arr.count; i++)
    {
        for (NSInteger k = i+1; k<arr.count; k++)
        {
            NSComparisonResult ret = [(NSNumber*)arr[k] compare:(NSNumber*)arr[i]];
            if (NSOrderedAscending == ret)
            {
                [arr exchangeObjectAtIndex:i withObjectAtIndex:k];
            }
        }
    }
}


//2、两头选择排序
////思想：每对数组进行一次遍历，找出一个最小的元素和一个最小元素，然后把剩下的元素遍历，直到最后一个元素
-(void)twoEndsSelectSort:(NSMutableArray*)arr
{
    for (NSInteger i = 0; i<arr.count/2; i++)
    {
        for (NSInteger k = i+1; k<arr.count-i-1; k++)
        {
            NSComparisonResult ret = [(NSNumber*)arr[k] compare:(NSNumber*)arr[i]];
            if (NSOrderedAscending == ret)
            {
                [arr exchangeObjectAtIndex:i withObjectAtIndex:k];
            }
            
            NSComparisonResult retB = [(NSNumber*)arr[arr.count -i-1] compare:(NSNumber*)arr[k]];
            if (NSOrderedAscending == retB)
            {
                [arr exchangeObjectAtIndex:arr.count -i-1 withObjectAtIndex:k];
            }
        }
    }
}

//2、选择排序-堆排序
//思路：1、建堆 2、堆a[0...n]  把a0和an交换位置 3、n=n-1 4、从步骤1继续开始 直到n-1=0

-(void)heapAdjust:(NSMutableArray*)arr cursor:(NSInteger) cursor length:(NSInteger)len
{
    NSInteger child = 2*cursor+1; //左孩子
    
    while(child<len)
    {
        if (child+1<len && arr[child]<arr[child+1])
        {
            child++;
        }
        
        if (arr[cursor]<arr[child])
        {
            [arr exchangeObjectAtIndex:cursor withObjectAtIndex:child];
            cursor = child;
            child = 2*child+1;
        }
        else
        {
            break;
        }
    }
}


-(void)bulidHeap:(NSMutableArray*)arr length:(NSInteger)len
{
    for (NSInteger i = (arr.count-1)/2; i>=0; i--)
    {
        [self heapAdjust:arr cursor:i length:len];
    }
}

-(void)heapSort:(NSMutableArray*)arr
{
    [self bulidHeap:arr length:arr.count];
    
    for (NSUInteger i = arr.count-1; i>0; i--)
    {
        [arr exchangeObjectAtIndex:i withObjectAtIndex:0];
        [self heapAdjust:arr cursor:0 length:i];
    }
}



//三、交换排序
//1、冒泡排序 思想： 就是每一轮循环，都对比相邻两个数值，把大数往下沉，小数往上浮
-(void)bubbleSort:(NSMutableArray*)arr
{
    for (int i = 0; i < arr.count; i++)
    {
        for (int k = 0; k<arr.count-i-1 ; k++)
        {
            if ([arr[k] integerValue]>[arr[k+1] integerValue])
            {
                [arr exchangeObjectAtIndex:k withObjectAtIndex:k+1];
            }
        }
    }
}

//冒泡改进，在加一个标志位，如果一趟循环没有 元素交换就终止循环 避免不必要的循环
-(void)bubbleSortFlag:(NSMutableArray*)arr
{
    BOOL flag;
    for (int i = 0; i < arr.count; i++)
    {
        flag = NO;
        for (int k = 0; k<arr.count-i-1 ; k++)
        {
            if ([arr[k] integerValue]>[arr[k+1] integerValue])
            {
                [arr exchangeObjectAtIndex:k withObjectAtIndex:k+1];
                flag = YES;
            }
        }
        if (!flag)
        {
            break;
        }
    }
}


//双向冒泡
-(void)bubbleSortTwo:(NSMutableArray *)arr
{
    int low = 0;
    int high = (int)arr.count - 1;
    
    while (low < high)
    {
        for (int k = low; k<high; k++)
        {
            if ([arr[k] integerValue] > [arr[k+1] integerValue])
            {
                [arr exchangeObjectAtIndex:k withObjectAtIndex:k+1];
            }
        }
        high--;
        
        for (int k = high; k>low; k--)
        {
            if ([arr[k] integerValue] < [arr[k-1] integerValue])
            {
                [arr exchangeObjectAtIndex:k withObjectAtIndex:k-1];
            }
        }
        low++;
    }
}


//快速排序，思想：选择一个基准数a(一般数组第一个或者最后一个)，然后把所有元素与他比较，把 比a打的全部放到a的右边，把比a小的放到a的左边，然后再把a的左边和右边进行上面的动作，直到排序完成

-(int)baseChange:(NSMutableArray*) arr low:(int)low high:(int)high
{
    NSInteger flag = [arr[low] integerValue];
    while(low<high)
    {
        while (low<high && flag <= [arr[high] integerValue])
        {
            high--;
        }
        [arr exchangeObjectAtIndex:high withObjectAtIndex:low];
        
        while (low<high && flag >= [arr[low] integerValue])
        {
            low++;
        }
        [arr exchangeObjectAtIndex:high withObjectAtIndex:low];
    }
    
    return low;
    
}
-(void)quicklySort:(NSMutableArray*)arr low:(int)low high:(int)high
{
    if (low < high)
    {
        int flag = [self baseChange:arr low:low high:high];
        [self quicklySort:arr low:low high:flag-1];
        [self quicklySort:arr low:flag+1 high:high];
    }
}

// 归并排序
//思想，将数组 分成若干相等的段（最后一个可能比其他的短）然后相邻两个进行合并并保持有序，然后每段长度变成原来的二倍 然后再相邻两端合并，并保持有序，直到段长度大于等于数组长度 为止

-(void)merge:(NSMutableArray*)sourceArr flagArr:(NSMutableArray*)flagArr startPoint:(int)start middlePoint:(int)middle endPoint:(int)end
{
    int i = 0;
    int j = 0;
    int k = 0;
    for (i = start,j = middle+1,k = start ; i<=middle && j<=end; k++)
    {
        if ([sourceArr[i] integerValue] > [sourceArr[j] integerValue])
        {
            [flagArr addObject:sourceArr[j]];
            j++;
        }
        else
        {
            [flagArr addObject:sourceArr[i]];
            i++;
        }
    }
    
    while (i<=middle && i<=end)
    {
        [flagArr addObject:sourceArr[i]];
        i++;
    }
    
    while (j<=end)
    {
        [flagArr addObject:sourceArr[j]];
        j++;
    }
}

-(NSMutableArray*)mergeSort:(NSMutableArray*)sourceArr
{
    int len = 1;
    int m = 0;
    while (len < sourceArr.count)
    {
        m = len;
        len  = 2 * m;
        int s = 0;
        NSMutableArray* arr = [NSMutableArray array];
        while (s+len < sourceArr.count)
        {
            [self merge:sourceArr flagArr:arr startPoint:s middlePoint:s+m-1 endPoint:s+len-1];
            s=s+len;
        }
        
        if (s < sourceArr.count)
        {
            [self merge:sourceArr flagArr:arr startPoint:s middlePoint:s+m-1 endPoint:(int)(sourceArr.count) -1];
        }
        NSLog(@"%@",arr);
        sourceArr = [NSMutableArray arrayWithArray:arr];
    }
    return sourceArr;
}
@end
