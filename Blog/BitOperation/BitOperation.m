//
//  BitOperation.m
//  Blog
//
//  Created by Mirinda on 2019/6/24.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import "BitOperation.h"
#include <math.h>

@implementation BitOperation
- (void)bitInto {
    //-------------------------------------------
//    unsigned int  a = 101;
//    if (isOddNumber(a)) printf("%ud 是奇数",a);
//    else printf("%u 是偶数",a);
//
//    a = 196;
//    if (isOddNumber(a)) printf("%ud 是奇数",a);
//    else printf("%u 是偶数",a);
    //-------------------------------------------
    
    //-------------------------------------------
    
//    int a = 10, b = 100;
//    swap(&a, &b);
//    bitSwap(&a, &b);
//    NSLog(@"a = %d, b = %d",a,b);
    
    //-------------------------------------------
    //-------------------------------------------
//    bitOddOreven(11);
//    bitOddOreven(0b01100000000000001111111111111110);
//    numberOfOneInBit(0b1110001110000000);
//    printfBinaryFormat(0x55555555);
//    printfBinaryFormat(0x33333333);
//    findZerosCOuntInHead(0b00000000000000000000000000001000);
    NSLog(@"-119999的绝对值是:%d",getAbs(-119999));
    NSLog(@"13996的绝对值是:%d",getAbs(13996));
//    changeHL16Bit(1314520);
    //-------------------------------------------
    
}

//判断奇偶数(利用与运算:真真为真,其他为假)
bool isOddNumber (unsigned int number) {
    return 1 & number ? true : false;
}

//把一个二进制的书最末位变成1(利用或预算:假假为假,其他为真)()
int lastBitChangeToOne(int bitNumber) {
    return 1 | bitNumber; //0b00000001 | bitNumber
    //如果把最末尾变成0:  -> ( 1 | bitNumber) -1
    
}

//把一个二级制的数某一位取反(利用异或,0^a 不变 1^a 取反:在相同为假,不同为真)
int reservaABit(int number, int bitPosition) {
    return number ^ (1 << bitPosition);
    //异或的一特性 a^b^b = a (用一个数连续两次异或A A不变)
}

//定义两个符号#和@（我怎么找不到那个圈里有个叉的字符），这两个符号互为逆运算，也就是说(x # y) @ y = x。现在依次执行下面三条命令x <- x # y,  y <- x @ y,  x <- x @ y  执行了第一句后x变成了x # y。那么第二句实质就是y <- x # y @ y，由于#和@互为逆运算，那么此时的y变成了原来的x。第三句中x实际上被赋值为(x # y) @ x，如果#运算具有交换律，那么赋值后x就变成最初的y了。这三句话的结果是，x和y的位置互换了

static void swap(int* a,int* b) {
    *a = *a + *b;
    *b = *a - *b;
    *a = *a - *b;
}

static void bitSwap(int* a,int* b) {
    *a = *a ^ *b;
    *b = *a ^ *b;
    *a = *a ^ *b;
}

//not 运算 取反
void getNegation(){
    int a = ~0xFFFFF;
    int b = ~0x00000;
    printf("a = %x, b = %x",a,b);
}

//左移右移
void shlAndshr() {
    int a = 32;
    a = a<<1; //相当与乘以2
    a = a>>1; //相当与除以2
}

//检查一个数的二进制有1的个数是奇数个还是偶数个
//num ^= num >> (int)pow(2,i); 得到的结果是一个新的二进制数，其中右起第i位上的数表示原数中第i和i+1位上有奇数个1还是偶数个1。比如，最右边那个0表示原数末两位有偶数个1，右起第3位上的1就表示原数的这个位置和前一个位置中有奇数个1。对这个数进行第二次异或的结果如下结果里的每个1表示原数的该位置及其前面三个位置中共有奇数个1，每个0就表示原数对应的四个位置上共偶数个1。一直做到第五次异或结束后，得到的二进制数的最末位就表示整个32位数里有多少个1

void bitOddOreven (long number) {
    long num = number;
    for (int i = 0; i < 5; i++) {
        num ^= num >> (int)pow(2,i);
    }
    
    if (num & 1) printf("number:%ld的二进制数有奇数个1\n",number);
    else printf("number:%ld的二进制数有偶数个1\n",number);
}

// 整个程序是一个分治的思想。第一次我们把每相邻的两位加起来，得到每两位里1的个数，比如前两位10就表示原数的前两位有2个1。第二次我们继续两两相加，10+01=11，00+10=10，得到的结果是00110010，它表示原数前4位有3个1，末4位有2个1。最后一次我们把0011和0010加起来，得到的就是整个二进制中1的个数。程序中巧妙地使用取位和右移，比如第二行中$33333333的二进制为00110011001100….，用它和x做and运算就相当于以2为单位间隔取数。shr的作用就是让加法运算的相同数位对齐
void numberOfOneInBit(int number) {
    number = (number&0x55555555)+((number>>1) &0x55555555);
    number = (number&0x33333333)+((number>>2) &0x33333333);
    number = (number&0x0F0F0F0F)+((number>>4) &0x0F0F0F0F);
    number = (number&0x00FF00FF)+((number>>8) &0x00FF00FF);
    number = (number&0x0000FFFF)+((number>>16) &0x0000FFFF);
    printf("number中1的个数为:%d",number);
}

//二分查找法 找出一个数的二进制格式 开头有多少个0
int findZerosCOuntInHead(unsigned x)
{
    int n = 1;
    if (x == 0) return(32);
    
    if ((x >> 16) == 0) {
        n = n +16; x = x <<16;}
    if ((x >> 24) == 0) {
        n = n + 8; x = x << 8;}
    if ((x >> 28) == 0) {
        n = n + 4; x = x << 4;}
    if ((x >> 30) == 0) {
        n = n + 2; x = x << 2;}

    n = n - (x >> 31); //n 初始化为1的原因, 若过x最后是10...0的话就减去初始化时的1, 如果是01....0;这是初始化时的1正好是填补了最前面的0,这样就不用写 if(x>>31){}的情况
    return n;
}



//假设x为32位整数，则x xor (not (x shr 31) + 1) + x shr 31的结果是x的绝对值
//x shr 31是二进制的最高位，它用来表示x的符号。如果它为0（x为正），则not (x shr 31) + 1等于$00000000，异或任何数结果都不变；如果最高位为1（x为负），则not (x shr 31) + 1等于$FFFFFFFF，x异或它相当于所有数位取反，异或完后再加一。
//    __typeof__(x)  __a = (x); 把__a的k类型定义成x的类型
//    printf("__a = %d",__a);

int getAbs(int x) {
//    printfBinaryFormat(x);
//    printfBinaryFormat(x>>31);
//    printfBinaryFormat(~(x>>31));
//    printfBinaryFormat(~(x>>31)+1);
//    printfBinaryFormat(x^(~(x>>31) + 1));
//    printfBinaryFormat((x^(~(x>>31) + 1)) + (x>>31));
    
//    return (x^(~(x>>31) + 1)) + (x>>31);  //这个是上面的解释不正确  负数右移动 左边填补1 不是0
    return (x ^ (x >> 31)) - (x >> 31);
    
}

//交换一个int型的高16位和低16位,输出这个数
void changeHL16Bit(int x) {
    printf("%d交换高低16位后所得数为:%d",x,(x>>16)|(x<<16));
}


//工具函数
void printfBinaryFormat(int number) {
    int a[33] = {0};
    for (int i = 0; i < 32; i++) {
        if(1&(number>>i)) a[i] = 1;
        else a[i] = 0;
    }
    printf("0B: ");
    for (int i = 31; i>=0; i--) {
        printf("%d",a[i]);
    }
    
    printf("\n");
}
@end
