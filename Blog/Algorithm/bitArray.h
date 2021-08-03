//
//  bitArray.h
//  AppstoreCtl
//
//  Created by Mirinda on 2018/7/6.
//  Copyright © 2018年 Mirinda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bitArray : NSObject
- (char *)getBitArr:(long long int)length;
- (BOOL)setNumberToBitArr:(int )number;
- (BOOL)findNumberInBitArr:(int )number;
- (BOOL)removeNumberInArr:(int)number;
@end
