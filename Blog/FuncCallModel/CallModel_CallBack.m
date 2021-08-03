//
//  CallModel_CallBack.m
//  Blog
//
//  Created by Mirinda on 17/2/16.
//  Copyright © 2017年 Mirinda. All rights reserved.
//

#import "CallModel_CallBack.h"

@implementation CallModel_CallBack

-(void)callStart
{
    xiaoli* li =[[xiaoli alloc]init];
    li.inter = [[xiangwang alloc]init];
    [li liCall];
}
@end


@implementation xiangwang

-(void)callBack
{
    NSLog(@"hello xiaoli");
}

@end


@implementation xiaoli

-(void)liCall
{
    NSLog(@"Li call wang");
    [self.inter callBack];
}

@end
