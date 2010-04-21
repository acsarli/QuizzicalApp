//
//  LQSoftLanding.m
//  LittleQuizzer
//
//  Created by Adrian Sarli on 4/15/10.
//  Copyright 2010 Adrian Sarli All rights reserved.
//

#import "LQSoftLanding.h"


@implementation LQSoftLanding
-(NSString *) windowNibName
{
	return @"SoftLanding";
}
-(void) awakeFromNib
{
	NSArray *recentURLs = [[NSDocumentController sharedDocumentController] recentDocumentURLs];
	NSMutableArray *newArray = [[NSMutableArray alloc] init];
	for(NSString *currentURL in recentURLs)
	{
		NSArray *URLcomponents = [currentURL pathComponents];
		[newArray addObject:[URLcomponents objectAtIndex:[URLcomponents count]-1]];
	}
	NSLog(@"awakingFromNib");
	[arrayController setContent:newArray];
	[newArray release];
	
	[tableView setTarget:self];
	[tableView setDoubleAction:@selector(recentDocumentClicked:)];
}
- (IBAction)createNewDocument:(id)sender
{
	NSError * error = nil;
	[[NSDocumentController sharedDocumentController] openUntitledDocumentAndDisplay:YES error:&error];
	if (error != nil) {
		[[NSAlert alertWithError:error] runModal];
	}
	[self close];
}
- (IBAction)openExistingDocument:(id)sender
{
	[[NSDocumentController sharedDocumentController] openDocument:sender];
	[self close];
}
- (IBAction)recentDocumentClicked:(id)sender
{
	NSDocumentController *controller = [NSDocumentController sharedDocumentController];
	NSArray *recentURLs = [controller recentDocumentURLs];
	
	NSError *err = nil;
	[controller openDocumentWithContentsOfURL:[recentURLs objectAtIndex:[arrayController selectionIndex]]  display:YES error:&err];
	if (err != nil) {
		[self presentError:err];
	}
	[self close];
}
@end
