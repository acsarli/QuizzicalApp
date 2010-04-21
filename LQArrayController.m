//
//  LQArrayController.m
//  LittleQuizzer
//
//  Created by Adrian Sarli on 1/20/10.
//  Copyright 2010 SimpleUpdates.com, Inc.. All rights reserved.
//

#import "LQArrayController.h"


@implementation LQArrayController
-(id) initWithContent:(id)content
{
	NSArray *newArray = [(NSArray *)content sortedArrayUsingSelector:@selector(compare:)];
	self = [super initWithContent:newArray];
	return self;
}
-(id) init
{
	self = [super init];
	return self;
}
-(id)newObject
{
	id newObject = [super newObject];
	[newObject setValue:[NSString stringWithFormat:@"Question %d", ([[self arrangedObjects] count] +1)] forKey:@"title"];
	return newObject;
}
@end
