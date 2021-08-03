//
//  FristLook.m
//  Blog
//
//  Created by Mirinda on 2019/5/31.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import "FirstLook.h"

@implementation FirstLook
- (void)excuteMethod {
    //波兰式 and 逆波兰式
//    char* str = "5+(6-4/2)*3";
//    char poland[32] = {0};
//    printf("%s的波兰式:%s\n",str,changeToPoland(str, poland));
//    printf("%s的波兰式计算结果:%d\n",str,polandCounting(poland));
//    printf("%s的逆波兰式:%s\n",str,oppositePoland(str, poland));
//    printf("%s的逆波兰式计算结果:%d\n",str,oppositePolandCounting(poland));
    //波兰式 and 逆波兰式 end
    //lcs,med
    char *str1 = "ABDACBA";
    char *str2 = "BADCAB";
//    lcs(str1,str2);
//    NSLog(@"med = %ld", med(str1, str2));
    //lcs end
}


#pragma mark -----------------poland & npoland -----------------------
//中缀转波兰式&逆波兰式:
//      类别                        中缀转前缀                                          中缀转后缀
//       栈                          操作符栈                                           操作符栈
//      扫描顺序                      从右到左                                           从左到右
//    遇到操作数                      直接归入                                           直接归入
//    遇到右括号                      直接入栈                              将栈中操作符依次弹栈，归入，直至遇到左括号，
//                                                                        将左括号弹栈，处理完毕
//    遇到左括号       将栈中操作符依次弹栈，归入，直至遇到右括号，
//                      将右括号弹栈，处理完毕                                         直接入栈

//  遇到其他操作符    检测栈顶操作符优先级与当前操作符优先级关系，如果栈顶大于当前，     检测栈顶与当前优先级关系，如果栈顶大于等于当前则出栈，归入
//                 则出栈,归入，直至栈顶小于等于当前，并将当前操作符入栈             ，直至栈顶小于当前，并将当前操作符入栈
//操作符栈中的优先级    从栈底到栈顶操作优先级：非递减。即：栈顶可以大于或等于下面的     从栈底到栈顶优先级：递增。即：栈顶必须大于下面的
//是否翻转                            翻转                                               无需翻转

//波兰式&逆波兰式的计算
//        类别                         前缀表达式计算                               后缀表达式计算
//      扫描顺序                         从右到左                                     从左到右
//        栈                            操作数栈                                     操作数栈
//     遇到操作数时                         压栈                                        压栈
//     遇到操作符时                         出栈                                        出栈
//      出栈的顺序                    先弹出操作数a，后弹出b                          先弹出操作数b，后弹出a
//        结果                       操作数栈中唯一元素的值                           操作数栈中唯一元素的值


//波兰式表达式(前缀表达式)//5 + ( 6 – 4 / 2 ) * 3 -> + 5 * - 6 / 4 2 3
/************************************************************************************
 中缀表达式转换前缀表达式的操作过程为：
（1）首先设定一个操作符栈，从右到左顺序扫描整个中缀表达式：
 a.如果是操作数，则直接归入前缀表达式；
 b.如果是括号：如果是右括号:)，则直接将其入栈；如果是左括号，则将栈中的操作符依次弹栈，归入前缀表达式，直至遇到右括号，将右括号弹栈，处理结束；
 c.如果是其他操作符，则检测栈顶操作符的优先级与当前操作符的优先级关系，如果栈顶操作符优先级大于当前操作符的优先级，则弹栈，并归入前缀表达式，
   直至栈顶操作符优先级小于等于当前操作符优先级，这时将当前操作符压栈。
（2）当扫描完毕整个中缀表达式后，检测操作符栈是否为空，如果不为空，则依次将栈中操作符弹栈，归入前缀表达式。
（3）最后，将前缀表达式翻转，得到中缀表达式对应的前缀表达式。
 ***********************************************************************************/
char* changeToPoland(const char* str, char* poland) {
    //计算长度
    size_t length = strlen(str);
    memset(poland,0,strlen(poland));
    int  flag = 0;
    //创建操作符栈
    NSStack *stack = [[NSStack alloc]init];
    //从右往左扫描中序表达式
    for (size_t i = length-1; i>=0; i--) {
        if ('\0' == str[i]) {
            break;
        }
        switch (str[i]) {
            case ')':
                [stack push:str[i]];
                break;
            case '(':
                while(')' != [stack top]) {
                    poland[flag] =  [stack pop];
                    flag++;
                }
                [stack pop];
                break;
            default:
                if (0 == getPriority(str[i])) {//数字字符处理
                    poland[flag] = str[i];
                    flag++;
                }
                else if(1 == getPriority(str[i])){//+-号处理
                    while( 1 < getPriority([stack top])) {
                        poland[flag] =  [stack pop];
                        flag++;
                    }
                    [stack push:str[i]];
                }
                else {// "*/" 符号处理
                    [stack push:str[i]];
                }
                break;
        }
    }
    while (0 < stack.length){
        poland[flag] =  [stack pop];
        flag++;
    }
    stringRevasal(poland);
    return poland;
}

//poland 表达式计算
int polandCounting(const char* poland) {
    NSStack *stack = [[NSStack alloc]initWithCArray:poland];
    NSStack *tempStack = [[NSStack alloc]init];
    for (int i = stack.length-1 ; i >= 0 ; i--) {
        if (0 == getPriority([stack top])) {
            [tempStack push:[stack pop]];
        }
        else{
            int a= 0 , b = 0 ;
            switch ([stack top]) {
                case '+':
                    [stack pop];
                    a = [tempStack pop] - '0';
                    b = [tempStack pop] - '0';
                    [tempStack push:(char)(a+b+'0')];
                    break;
                case '-':
                    [stack pop];
                    a = [tempStack pop] - '0';
                    b = [tempStack pop] - '0';
                    [tempStack push:(char)(a-b+'0')];
                    break;
                case '*':
                    [stack pop];
                    a = [tempStack pop] - '0';
                    b = [tempStack pop] - '0';
                    [tempStack push:(char)(a*b+'0')];
                    break;
                case '/':
                    [stack pop];
                    a = [tempStack pop] - '0';
                    b = [tempStack pop] - '0';
                    [tempStack push:(char)(a/b+'0')];
                    break;
                default:
                    break;
            }
        }
    }
    return [tempStack pop]-'0';
}

//逆波兰表达式:5 + ( 6 – 4 / 2 ) * 3 -> 5 6 4 2 / - 3 * +
/******************************************************************************************
中缀表达式转换后缀表达式的操作过程为：
（1）自左向右顺序扫描整个中缀表达式；
  a.如果当前元素为操作数，则将该元素直接存入到后缀表达式中；
  b.如果当前元素为“(”，则将其直接入栈；如果为“)”，则将栈中的操作符弹栈，并将弹栈的操作符存入到后缀表达式中，
    直至遇到“(”，将“(”从栈中弹出，并不将其存入到后缀表达式中；
  c.如果是其他操作符，如果其优先级高于栈顶操作符的优先级，则将其入栈，如果是小于或低于站定操作符优先级，
    则依次弹出栈顶操作符并存入后缀表达式中，直至遇到一个栈顶优先级小于当前元素优先级时或者栈顶元素为“(”为止，
    保持当前栈顶元素不变，并将当前元素入栈；
（2）当扫描完毕整个中缀表达式后，检测操作符栈是否为空，如果不为空，则依次将栈中操作符弹栈，归入后缀表达式。
********************************************************************************************/
char* oppositePoland(const char* str, char* oppositePL) {
    //计算表达式长度
    size_t length = strlen(str);
    memset(oppositePL,0,strlen(oppositePL));
    NSStack *stack = [[NSStack alloc]init];
    int flag = 0;
    
    for (int i = 0; i<length; i++) {
        if (0 == str[i]) {
            break;
        }
        
        switch (str[i]) {
            case '(':
                [stack push:str[i]];
                break;
            case ')':
                while('(' != [stack top]) {
                    if(0 == stack.length){
                        break;
                    }
                    oppositePL[flag] = [stack pop];
                    flag++;
                }
                [stack pop];
                break;
            default:
                if(0 == getPriority(str[i])) {
                    oppositePL[flag] = str[i];
                    flag++;
                } else if(1 == getPriority(str[i])) {
                    while(1 <= getPriority([stack top])) {
                        oppositePL[flag] = [stack pop];
                        flag++;
                    }
                    [stack push:str[i]];
                } else  {
                    while(2 <= getPriority([stack top])) {
                        oppositePL[flag] = [stack pop];
                        flag++;
                    }
                    [stack push:str[i]];
                }
                break;
        }
    }
    
    while (0 < stack.length) {
        oppositePL[flag] = [stack pop];
        flag++;
    }
    
    return oppositePL;
}

int oppositePolandCounting(const char* opspoland) {
    size_t length = strlen(opspoland);
    char* opl =(char*) malloc(sizeof(char)*32);
    memset(opl, 0, 32);
    memcpy(opl, opspoland, length);
    stringRevasal(opl);
    NSStack *stack = [[NSStack alloc]initWithCArray:opl];
    NSStack *temStack = [[NSStack alloc]init];
    int a= 0, b=0;
    for (int i = stack.length-1 ; i >= 0 ; i--) {
        if (0 == getPriority([stack top])) {
            if ('\0' != [stack top]) {
                [temStack push:[stack pop]];
            }
            
        }
        switch ([stack top]) {
            case '+':
                [stack pop];
                a= [temStack pop]- '0';
                b= [temStack pop]- '0';
                [temStack push:(b+a+'0')];
                break;
            case '-':
                [stack pop];
                a= [temStack pop]- '0';
                b= [temStack pop]- '0';
                [temStack push:(b-a+'0')];
                break;
            case '*':
                [stack pop];
                a= [temStack pop]- '0';
                b= [temStack pop]- '0';
                [temStack push:(b*a+'0')];
                break;
            case '/':
                [stack pop];
                a= [temStack pop]- '0';
                b= [temStack pop]- '0';
                [temStack push:(b/a+'0')];
                break;
                
            default:
                break;
        }
    }
    
    return [temStack pop]-'0';
}

//字符串翻转
void stringRevasal(char* str) {
    size_t to =  strlen(str);
    int from = 0;
    to--;
    char temp;
    while(from < to){
        temp = str[to];
        str[to] = str[from];
        str[from] = temp;
        from++;
        to--;
    }
}

// 获取字符优先级
int getPriority(char c) {
    int priority = 0;
    switch (c) {
        case '+':
        case '-':
            priority = 1;
            break;
        case '*':
        case '/':
            priority = 2;
            break;
        default:
            break;
    }
    return priority;
}


#pragma mark ------------------------LCS------------------------------
//lcs和med 在处理上的却别,lcs[j][i],当时 A[i] = B[j] 的时候 lcs[j][i] 为 lcs[j-1][i-1]+1 否则 lcs[j][i] =  MAX(lcs[j-1][i], lcs[j][i-1]);  而med 则是 当 A[i] = B[j]  med = min(med[j-1][i], med[j][i-1],med[j-1][i-1]+0) 否则 A[i] != B[j] 则 med = min(med[j-1][i], med[j][i-1],med[j-1][i-1]+1)

//这里注意 如果sourceA做横轴,sourceB做竖轴 那么lcs[B][A] 注意AB顺序
void lcs(const char *sourceA, const char *sourceB ){
    int lcs[10][10] = {0};
    long length1 = strlen(sourceA);
    long length2 = strlen(sourceB);
    
    //形成lcs矩阵 char *str1 = "ABDACBA";
    //           char *str2 = "BADCAB";
    for (long i = 0; i< length1; i++) {
        for (long j = 0; j < length2; j++) {
            if (sourceA[i] == sourceB[j]) {
                lcs[j+1][i+1] = lcs[j][i]+1;
            }else {
                lcs[j+1][i+1] = MAX(lcs[j+1][i], lcs[j][i+1]);
            }
        }
        //打印供测试用
//        for (long i = 0; i <= length2; i++) {
//            for (long j = 0 ;j<=length1 ; j++) {
//                printf("%d ",lcs[i][j]);
//            }
//            printf("\n");
//        }
//         printf("\n"); printf("\n"); printf("\n");
        
    }
    //测试打出矩阵
//    for (long i = 0; i <= length2; i++) {
//        for (long j = 0 ;j<=length1 ; j++) {
//            printf("%d ",lcs[i][j]);
//        }
//        printf("\n");
//    }
    //找出lcs
    while (length1 >0 && length2 >0) {
        if (lcs[length2][length1] > lcs[length2-1][length1] && lcs[length2][length1] > lcs[length2][length1-1]) {
            printf("%c",sourceA[length1-1]); //这里注意是length -1
            length1--;
            length2--;
        }else {
            if (lcs[length2][length1-1] >= lcs[length2-1][length1]) {
                length1--;
            }else {
                length2--;
            }
            
        }
    }
}


#pragma mark ----------------------编辑距离-----------------------------
long med(const char *sourceA, const char *sourceB) {
    long med[10][10] = {0};
    long length1 = strlen(sourceA);
    long length2 = strlen(sourceB);
    if (sourceA == sourceB) {
        return 0;
    }
    
    if (0 == length1) {
        return length2;
    }
    
    if (0 == length2) {
        return length1;
    }
    
    for (long i = 0; i<length1; i++) {
        med[0][i+1] = i+1;
        for (long j = 0; j <length2; j++) {
            med[j+1][0] = j+1;
            int flag = 0;
            if (sourceA[i] == sourceB[j]) flag = 0;
            else flag = 1;
            med[j+1][i+1] =MIN(MIN(med[j+1][i]+1, med[j][i+1]+1), med[j][i]+flag) ;
        }
    }
    
//    //测试打出矩阵
//    for (long i = 0; i <= length2; i++) {
//        for (long j = 0 ;j<=length1 ; j++) {
//            printf("%ld ",med[i][j]);
//        }
//        printf("\n");
//    }
    
    return med[length2][length1];
}


@end



#pragma -NSStack 辅助类
//辅助类NSStack
@implementation NSStack
- (instancetype)init {
    if (self = [super init]) {
        self.flag = -1;
        self.length = 0;
        self.stack = (char*)malloc(sizeof(char)*100);
        return self;
    }
    return nil;
}

- (instancetype)initWithCArray:(char*)arr {
    if (self = [super init]) {
        self.flag = -1;
        self.length = 0;
        self.stack = (char*)malloc(sizeof(char)*100);
        size_t len = strlen(arr);
        for (size_t i = 0; i<len; i++) {
            [self push:arr[i]];
        }
        return self;
    }
    return nil;
}

- (char)pop {
    if (0 <= self.flag) {
        char a = self.stack[self.flag];
        self.stack[self.flag] = '\0';
        self.flag--;
        self.length--;
        return a;
    }
    return '\0';
}

- (char)top {
    if (0 <= self.flag) {
        return self.stack[self.flag];
    }
    return '\0';
}

- (void)push:(char)c {
    
    if (99 == self.flag) {
        return;
    }
    self.flag++;
    self.stack[self.flag] = c;
    self.length++;
}

- (void)dealloc
{
    if (NULL != self.stack) {
        free(self.stack);
        self.stack = NULL;
    }
}

@end
