//
//  ObjToLocal.h
//  Blog
//
//  Created by Mirinda on 17/4/26.
//  Copyright © 2017年 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjToLocal : NSObject

-(void)encodeArr;

-(void)decodeArr;

@end


#import <Foundation/Foundation.h>

@interface AdSummary : NSObject<NSCoding>
@property(nonatomic,strong)NSString* AdInfoFile;
@property(nonatomic,strong)NSString* AdVideoFile;
@property(nonatomic,assign)NSInteger alreadyPlayedTimes;
@property(nonatomic,assign)NSInteger playTimes;
@property(nonatomic,assign)long long timeOut;
@end
