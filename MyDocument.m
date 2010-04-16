//
//  MyDocument.m
//  LittleQuizzer
//
//  Created by Adrian Sarli on 12/21/09.
//  Copyright SimpleUpdates.com, Inc. 2009 . All rights reserved.
//

#import "MyDocument.h"

@implementation MyDocument
@synthesize quizzer;
@synthesize controller;

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

- (void)windowControllerDidLoadNib:(NSWindowController *)windowController 
{
    [super windowControllerDidLoadNib:windowController];
    // user interface preparation code
}

- (void) beginQuiz:(id)sender
{
	[quizzer giveQuiz:[controller arrangedObjects]];
}

@end
