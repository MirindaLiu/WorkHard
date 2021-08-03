//
//  stack.m
//  Blog
//
//  Created by Mirinda on 2019/7/2.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import "stack.h"
static char forward[10] = {0};
static char back[10] = {0};
static int forwardFlag = -1;
static int backFlag = -1;

@implementation stack
- (void)stackInto {
    
    //模拟浏览器打开网页,前进后退等功能.
    openPage('a');
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    openPage('b');
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    openPage('c');
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    backPage();
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    backPage();
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    backPage();
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    backPage();
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    forwardPage();
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    openPage('d');
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    openPage('e');
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    backPage();
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    backPage();
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    backPage();
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    backPage();
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    forwardPage();
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    forwardPage();
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    forwardPage();
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    forwardPage();
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    forwardPage();
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    forwardPage();
    printf("forward = %s\n",forward);
    printf("back = %s\n",back);
    
    // 栈实现poland 和逆poland
}

void openPage(char p) {
    forwardFlag++;
    forward[forwardFlag] = p;
    memset(back, 0, 10);
    backFlag = -1;
}

bool forwardPage(){
    if (0 > backFlag) {
        return false;
    }
    
    forwardFlag++;
    forward[forwardFlag] = back[backFlag];
    back[backFlag] = 0;
    backFlag--;
    return true;
}

bool backPage() {
    if(0 >= forwardFlag) {
        return false;
    }
    
    backFlag++;
    back[backFlag] = forward[forwardFlag];
    forward[forwardFlag] = 0;
    forwardFlag--;
    return true;
}
@end
