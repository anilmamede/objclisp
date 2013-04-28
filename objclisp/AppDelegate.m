//
//  AppDelegate.m
//  objclisp
//
//  Created by Anil Mamede on 4/25/13.
//  Copyright (c) 2013 Anil Mamede. All rights reserved.
//

#import "LispEnvironment.h"
#import "AppDelegate.h"

@interface AppDelegate()

@property (strong) LispEnvironment *env;

@end

@implementation AppDelegate

- (void)dealloc
{
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[self setEnv:[LispEnvironment sharedInstance]];
	[[self env] boot];
	[[self env] swank];
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
	[[self env] shutdown];
}

@end
