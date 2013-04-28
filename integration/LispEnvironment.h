//
//  LispEnvironment.h
//  objclisp
//
//  Created by Anil Mamede on 4/27/13.
//  Copyright (c) 2013 Anil Mamede. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LispEnvironment : NSObject

- (void)boot;
- (void)shutdown;
- (void)swank;

+ (LispEnvironment *)sharedInstance;

@end
