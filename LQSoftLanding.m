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
@end
