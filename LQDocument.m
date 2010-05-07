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
	LQTableHeaderCell *cell = [[LQTableHeaderCell alloc] init];
	[cell setTitle:@"Question Title"];
	[[tableView.tableColumns objectAtIndex:0] setHeaderCell:[cell autorelease]];

	cell = [[LQTableHeaderCell alloc] init];
	[cell setTitle:@"Difficulty"];
	[[tableView.tableColumns objectAtIndex:1] setHeaderCell:[cell autorelease]];
	
	
	NSAssert(takeQuizToolbarItem != nil, @"");
	NSMenu *takeQuizToolbarMenu = [[NSMenu alloc] init];
	[takeQuizToolbarMenu addItem:[[NSMenuItem alloc] initWithTitle:@"Quiz on hardest questions" action:@selector(hardTest:) keyEquivalent:@""]];
	[takeQuizToolbarMenu addItem:[[NSMenuItem alloc] initWithTitle:@"Quiz on medium questions" action:@selector(medTest:) keyEquivalent:@""]];
	[takeQuizToolbarMenu addItem:[[NSMenuItem alloc] initWithTitle:@"Quiz on easy questions" action:@selector(easyTest:) keyEquivalent:@""]];

	[takeQuizToolbarItem setMenu:takeQuizToolbarMenu];
	[[mainWindow toolbar] insertItemWithItemIdentifier:@"LQGroup" atIndex:0];
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
- (void) hardTest:(id)sender
{
	[mainWindow makeFirstResponder:nil];	//This is needed so that if the user was editing a field, it will take effect
	[quizzer giveQuiz:[[controller arrangedObjects] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"rating==3"]]];
}
- (void) medTest:(id)sender
{
	[mainWindow makeFirstResponder:nil];	//This is needed so that if the user was editing a field, it will take effect
	[quizzer giveQuiz:[[controller arrangedObjects] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"rating==2"]]];
}
- (void) easyTest:(id)sender
{
	[mainWindow makeFirstResponder:nil];	//This is needed so that if the user was editing a field, it will take effect
	[quizzer giveQuiz:[[controller arrangedObjects] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"rating==1"]]];
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
		
		[item setImage:[NSImage imageNamed: @"startQuiz"]];
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
