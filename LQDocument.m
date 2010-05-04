//
//  MyDocument.m
//  LittleQuizzer
//
//  Created by Adrian Sarli on 12/21/09.
//  Copyright SimpleUpdates.com, Inc. 2009 . All rights reserved.
//

#import "LQDocument.h"
#import "AHTableHeaderCell.h"


@implementation LQDocument
@synthesize quizzer;
@synthesize controller;
@synthesize mainWindow;
@synthesize questionView;
@synthesize answerView;

- (id)init 
{
    self = [super init];
    if (self != nil) {
        // initialization code
    }
    return self;
}

- (NSString *)windowNibName 
{
    return @"MyDocument";
}

-(void) awakeFromNib
{
	AHTableHeaderCell *cell = [[AHTableHeaderCell alloc] init];
	[cell setTitle:@"Question Title"];
	[[tableView.tableColumns objectAtIndex:0] setHeaderCell:[cell autorelease]];
	
	cell = [[AHTableHeaderCell alloc] init];
	[cell setTitle:@"Difficulty"];
	[[tableView.tableColumns objectAtIndex:1] setHeaderCell:[cell autorelease]];
}
- (void)windowControllerDidLoadNib:(NSWindowController *)windowController 
{
    [super windowControllerDidLoadNib:windowController];
    // user interface preparation code
}

- (void) beginQuiz:(id)sender
{
	//[window setIsVisible:NO];
	[mainWindow makeFirstResponder:nil];	//This is needed so that if the user was editing a field, it will take effect
	[quizzer giveQuiz:[controller arrangedObjects]];
}
#pragma mark IBActions
- (void) addQuestion:(id)sender
{
	[controller add:sender];
}
- (void) removeQuestion:(id)sender
{
	[controller remove:sender];
}




@end
