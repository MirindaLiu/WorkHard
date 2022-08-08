//
//  ASMLook.m
//  Blog
//
//  Created by Mirinda on 2021/8/16.
//  Copyright © 2021 Mirinda. All rights reserved.
//

#import "ASMLook.h"

@implementation ASMLook
- (void)lookAsmThroughC {
    lookC();
}

void lookC() {
    int a = 10;
    int b = 20;
    int c = a+b;
    int j = ret();
    c = c+j;
}

int ret(){
    int k = 30;
    return k;
}


//Blog`lookC:
//    0x10431d59c <+0>:  sub    sp, sp, #0x10             ; =0x10
//    0x10431d5a0 <+4>:  mov    w8, #0xa
//    0x10431d5a4 <+8>:  str    w8, [sp, #0xc]
//    0x10431d5a8 <+12>: mov    w8, #0x14
//    0x10431d5ac <+16>: str    w8, [sp, #0x8]
//    0x10431d5b0 <+20>: ldr    w8, [sp, #0xc]
//    0x10431d5b4 <+24>: ldr    w9, [sp, #0x8]
//    0x10431d5b8 <+28>: add    w8, w8, w9
//    0x10431d5bc <+32>: str    w8, [sp, #0x4]
//->  0x10431d5c0 <+36>: ldr    w8, [sp, #0x4]
//    0x10431d5c4 <+40>: add    w8, w8, #0x1              ; =0x1
//    0x10431d5c8 <+44>: str    w8, [sp, #0x4]
//    0x10431d5cc <+48>: add    sp, sp, #0x10             ; =0x10
//    0x10431d5d0 <+52>: ret
@end
