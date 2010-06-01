//
//  MyDocument.m
//  LittleQuizzer
//
//  Created by Adrian Sarli on 12/21/09.
//  Copyright SimpleUpdates.com, Inc. 2009 . All rights reserved.
//

#import "LQDocument.h"
#import "LQTableHeaderCell.h"
#import "KBPopUpToolbarItem.h"

@implementation LQDocument
@synthesize quizzer;
@synthesize controller;
@synthesize mainWindow;
@synthesize takeQuizToolbarItem;

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
	//Set up our custom header cells
	
	LQTableHeaderCell *cell = [[LQTableHeaderCell alloc] init];
	//Keep the same title as before
	[cell setTitle:[[[tableView.tableColumns objectAtIndex:0] headerCell] title]];
	[[tableView.tableColumns objectAtIndex:0] setHeaderCell:[cell autorelease]];

	cell = [[LQTableHeaderCell alloc] init];
	//Keep the same title as before
	[cell setTitle:[[[tableView.tableColumns objectAtIndex:1] headerCell] title]];
	[[tableView.tableColumns objectAtIndex:1] setHeaderCell:[cell autorelease]];
	
	//Set up the popup toolbar item
	NSAssert(takeQuizToolbarItem != nil, @"");
	NSMenu *takeQuizToolbarMenu = [[NSMenu alloc] init];
	[takeQuizToolbarMenu addItem:[[NSMenuItem alloc] initWithTitle:@"Quiz on hardest questions" action:@selector(hardTest:) keyEquivalent:@""]];
	[takeQuizToolbarMenu addItem:[[NSMenuItem alloc] initWithTitle:@"Quiz on medium questions" action:@selector(medTest:) keyEquivalent:@""]];
	[takeQuizToolbarMenu addItem:[[NSMenuItem alloc] initWithTitle:@"Quiz on easy questions" action:@selector(easyTest:) keyEquivalent:@""]];

	[takeQuizToolbarItem setMenu:takeQuizToolbarMenu];
	
	//Insert it
	[[mainWindow toolbar] insertItemWithItemIdentifier:@"LQGroup" atIndex:0];
}

- (void)windowControllerDidLoadNib:(NSWindowController *)windowController 
{
    [super windowControllerDidLoadNib:windowController];
    // user interface preparation code
}

- (void) beginQuiz:(id)sender
{
	[self takeTestWithDifficulty:0];
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
- (void) hardTest:(id)sender
{
	[self takeTestWithDifficulty:3];
}
- (void) medTest:(id)sender
{
	[self takeTestWithDifficulty:2];
}
- (void) easyTest:(id)sender
{
	[self takeTestWithDifficulty:1];
}

//This is a catch-all for tests; Difficulty of 0 is all questions
- (void) takeTestWithDifficulty:(int)difficulty
{
	[mainWindow makeFirstResponder:nil];	//This is needed so that if the user was editing a field, it will take effect
	if(difficulty == 0)
	{
		[quizzer giveQuiz:[controller arrangedObjects]];
		return;
	}
	[quizzer giveQuiz:[[controller arrangedObjects] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"rating==%d", difficulty]]];
}

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag
{
	if([itemIdentifier isEqualToString:@"LQGroup"])
	{
		KBPopUpToolbarItem *item = [[KBPopUpToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
		NSMenu *takeQuizToolbarMenu = [[NSMenu alloc] init];
		[takeQuizToolbarMenu addItem:[[NSMenuItem alloc] initWithTitle:@"Quiz on hardest questions" action:@selector(hardTest:) keyEquivalent:@""]];
		[takeQuizToolbarMenu addItem:[[NSMenuItem alloc] initWithTitle:@"Quiz on medium questions" action:@selector(medTest:) keyEquivalent:@""]];
		[takeQuizToolbarMenu addItem:[[NSMenuItem alloc] initWithTitle:@"Quiz on easy questions" action:@selector(easyTest:) keyEquivalent:@""]];
		
		[item setMenu:takeQuizToolbarMenu];
		
		[item setImage:[NSImage imageNamed: @"Play_Toolbar"]];
		[item setLabel:@"Take Quiz"];
		[item setTarget:self];
		[item setAction:@selector(beginQuiz:)];
		
		return item;
	}
	return [[NSToolbarItem alloc] init];
}
-(BOOL) respondsToSelector:(SEL)aSelector
{
	/*if([NSStringFromSelector(aSelector) isEqualToString:@"beginQuiz:"] && [[controller arrangedObjects] count] == 0)
	{
		return NO;
	}*/
	if ([NSStringFromSelector(aSelector) isEqualToString:@"hardTest:"] && [[[controller arrangedObjects] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"rating==3"]] count] == 0)
	{
		return NO;
	}
	if ([NSStringFromSelector(aSelector) isEqualToString:@"medTest:"] && [[[controller arrangedObjects] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"rating==2"]] count] == 0)
	{
		return NO;
	}
	if ([NSStringFromSelector(aSelector) isEqualToString:@"easyTest:"] && [[[controller arrangedObjects] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"rating==1"]] count] == 0)
	{
		return NO;
	}
	return [super respondsToSelector:aSelector];
}
@end
