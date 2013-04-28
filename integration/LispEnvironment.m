//
//  LispEnvironment.m
//  objclisp
//
//  Created by Anil Mamede on 4/27/13.
//  Copyright (c) 2013 Anil Mamede. All rights reserved.
//

#import <ecl/ecl.h>
#import "LispEnvironment.h"

@interface LispEnvironment()

- (bool)running;
- (cl_object)makePathnameForResource:(NSString *)resource ofType:(NSString *)type withBundle:(NSBundle *)bundle;

@end

@implementation LispEnvironment

+ (LispEnvironment *)sharedInstance
{
	return [[LispEnvironment alloc] init];
}

- (bool)running
{
	return ecl_get_option(ECL_OPT_BOOTED);
}

- (void)boot
{
	
	NSLog(@"Booting ECL Lisp environment");
	char *args[] = {};
	cl_boot(0, args);
}

- (void)shutdown
{
	NSLog(@"Shutdown ECL Lisp environment");
	cl_shutdown();
}

- (void)swank
{
	cl_object path = [self makePathnameForResource:@"lisp/swank/swank-objc" ofType:@"lisp" withBundle:[NSBundle mainBundle]];
	cl_load(1, path);
	cl_object fun = cl_eval(c_string_to_object("#'(lambda () (objclisp:start-swank))"));
	cl_funcall(1, fun);
}

- (cl_object)makePathnameForResource:(NSString *)resource ofType:(NSString *)type withBundle:(NSBundle *)bundle
{
	cl_object DIRECTORY = ecl_make_keyword("DIRECTORY");
	cl_object TYPE = ecl_make_keyword("TYPE");
	cl_object NAME = ecl_make_keyword("NAME");
	
	cl_object directoryComponent = ecl_make_simple_base_string((char *)[[bundle resourcePath] cStringUsingEncoding:NSUTF8StringEncoding], [[bundle resourcePath] lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
	cl_object typeComponent = ecl_make_simple_base_string((char *)[type cStringUsingEncoding:NSUTF8StringEncoding], [type lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
	cl_object nameComponent = ecl_make_simple_base_string((char *)[resource cStringUsingEncoding:NSUTF8StringEncoding], [resource lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
	
	return cl_make_pathname(6, DIRECTORY, directoryComponent, TYPE, typeComponent, NAME, nameComponent);
}

@end
