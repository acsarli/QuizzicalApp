//
//  LQArrayController.m
//  LittleQuizzer
//
//  Created by Adrian Sarli on 1/20/10.
//  Copyright 2010 SimpleUpdates.com, Inc.. All rights reserved.
//

#import "LQArrayController.h"


@implementation LQArrayController
-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder	//This is my hook for sorting
{
	[self setSortDescriptors:[NSArray arrayWithObjects:[[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES] autorelease], nil]];
	return self;
}
-(id)newObject
{
	id newObject = [super newObject];
	[newObject setValue:[NSString stringWithFormat:@"Question %d", ([[self arrangedObjects] count] +1)] forKey:@"title"];
	return newObject;
}
@end
