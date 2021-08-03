//
//  ObjToLocal.m
//  Blog
//
//  Created by Mirinda on 17/4/26.
//  Copyright © 2017年 Mirinda. All rights reserved.
//

#import "ObjToLocal.h"

@implementation ObjToLocal

-(void)encodeArr
{
    NSMutableArray* arr = [NSMutableArray array];
    AdSummary* su = [[AdSummary alloc]init];
    su.AdInfoFile = @"123456789011111.ct";
    su.AdVideoFile = @"1234567890111111.mp4";
    su.alreadyPlayedTimes = 3;
    su.playTimes = 0;
    su.timeOut = 1329439284999;
    [arr addObject:su];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *savePath = [cachePath stringByAppendingPathComponent:@"config.ct"];
//    if ([fileManager fileExistsAtPath:savePath])
//    {
//        if ([fileManager removeItemAtPath:savePath error:nil])
//        {
//            NSLog(@"file  delete!");
//        }
//    }
    [NSKeyedArchiver archiveRootObject:arr toFile:savePath];
}


-(void)decodeArr
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *savePath = [cachePath stringByAppendingPathComponent:@"config.ct"];
    NSArray* arr = [NSKeyedUnarchiver unarchiveObjectWithFile:savePath];
    NSLog(@"data = %@",arr[0]);
}

@end



@implementation AdSummary

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.AdInfoFile = [aDecoder decodeObjectForKey:@"AdInfoFile"];
        self.AdVideoFile = [aDecoder decodeObjectForKey:@"AdVideoFile"];
        self.alreadyPlayedTimes = [aDecoder decodeIntegerForKey:@"alreadyPlayedTimes"];
        self.playTimes = [aDecoder decodeIntegerForKey:@"playTimes"];
        self.timeOut = [aDecoder decodeInt64ForKey:@"timeOut"];
        return self;
    }
    return nil;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.AdInfoFile forKey:@"AdInfoFile"];
    [aCoder encodeObject:self.AdVideoFile forKey:@"AdVideoFile"];
    [aCoder encodeInteger:self.alreadyPlayedTimes forKey:@"alreadyPlayedTimes"];
    [aCoder encodeInteger:self.playTimes forKey:@"playTimes"];
    [aCoder encodeInt64:self.timeOut forKey:@"timeOut"];
}
@end
