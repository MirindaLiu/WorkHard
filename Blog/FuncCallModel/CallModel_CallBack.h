//
//  CallModel_CallBack.h
//  Blog
//
//  Created by Mirinda on 17/2/16.
//  Copyright © 2017年 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CallModel_CallBack : NSObject

-(void)callStart;
@end



@protocol ClickInterface <NSObject>

@required
-(void)callBack;


@end


@interface xiangwang : NSObject<ClickInterface>

@end

@interface xiaoli : NSObject
@property(nonatomic,strong) id<ClickInterface> inter;
-(void)liCall;
@end
