//
//  LQQuizzer.m
//  LittleQuizzer
//
//  Created by Adrian Sarli on 3/28/10.
//  Copyright 2010 Adrian Sarli All rights reserved.
//

#import "LQQuizzer.h"


@implementation LQQuizzer

@synthesize flashCardsArray;
@synthesize questionAnswerField;
@synthesize answerNext;
@synthesize backButton;
@synthesize window;
- (id) init
{
	if(self = [super init])
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowClosed:) name:@"NSWindowWillCloseNotification" object:nil];
	return self;
}

	 
- (void) giveQuiz:(id)sender
{
	//Before getting to work, reset our current state, so we only have 1 window at a time
	[self resetState];
	
	//First, check to make sure there is more than 0 questions, else display error
	if([flashCardsArray count] == 0)	//ERROR
	{
		NSAlert *alert = [[NSAlert alloc] init];
		[alert setMessageText:@"Your question set has no questions... Please add some before trying to take the quiz."];
		//[alert setAlertStyle:NSCriticalAlertStyle];
		[alert runModal];
		[alert release];
		return;
	}
	
	//Now, load the nib
	if(![NSBundle loadNibNamed:@"Quiz" owner:self])
		return;		//It failed, we're outta here!
	
	//Now, set up the index
	currentQuestionIndex = 0;
	
	//Now, display the next question
	[self displayQuestion];
	[answerNext setTitle:@"Show Answer"];
}
	
- (IBAction) buttonPushed:(id)sender			//This is called when the "Next" or "Answer" button is pushed
{
	//If they click this button, they won't be on the first screen
	[backButton setHidden:NO];
	if (showingQuestion == YES && currentQuestionIndex < [flashCardsArray count])  //Then show the answer
	{
		[self displayAnswer];
	}
	else if(currentQuestionIndex < ([flashCardsArray count] - 1))	//The -1 is because when we add one otherwise, we will be at count--too high!
	{
		currentQuestionIndex++;
		[self displayQuestion];
	}
	else if(isFinished == YES)
		[self exitQuiz];
	else 
	{
		showingQuestion = YES;		//We must pretend it's a question for back to work right
		currentQuestionIndex++;
		[self displayFinish];
	}
}

- (void) backButtonPushed:(id)sender;	//This is called when the "Back" button is pushed.
{
	//Things to watch out for:
	//Re-hide the button if this is question #0
	//Show the button in the buttonPushed method
	
	//We mustn't be at the end, as we are going back
	isFinished = NO;
	
	//Now, go back; But first we have to know whether this is a Q or A
	if (showingQuestion == YES) {
		//Go back to last answer
		currentQuestionIndex--;
		[self displayAnswer];
	}
	else {
		//Go back to the question
		[self displayQuestion];
	}
	
	//Check to see if now we're at the beginning
	if ( currentQuestionIndex == 0 && showingQuestion == YES)
	{
		[backButton setHidden:YES];
		return;
	}
}

- (IBAction) windowClosed:(id)sender					//This is called if the quiz window is unexpectedly closed.
{
	self.window = nil;
	[self resetState];
}
#pragma mark Internal methods

- (void) displayQuestion
{
	[self displayQuestionWithNumber:currentQuestionIndex];
	[answerNext setTitle:@"Show Answer"];
}

- (void) displayAnswer
{
	[self displayAnswerWithNumber:currentQuestionIndex];
	if(currentQuestionIndex == ([flashCardsArray count] - 1))		//We are on next-to-last
	{
		[answerNext setTitle:@"Finish"];
	}
	else
	{
		[answerNext setTitle:@"Next Question"];
	}
}
- (void) displayFinish
{
	isFinished = YES;
	[questionAnswerField setString:@"The End\nThis is the end of your quiz. Click Close to exit."];
	[answerNext setTitle:@"Close"];
}
- (void) exitQuiz
{
	[window close];	//This should call windowClosed:
}
- (void) displayQuestionWithNumber: (NSInteger)questionNumber
{
	NSData *data = [[flashCardsArray objectAtIndex:currentQuestionIndex] valueForKey:@"questionField"];
	[questionAnswerField setString:@""];
	[questionAnswerField replaceCharactersInRange:NSMakeRange(0, questionAnswerField.string.length) withRTF:data];
	showingQuestion = YES;
}

- (void) displayAnswerWithNumber: (NSInteger)answerNumber
{
	NSData *data = [[flashCardsArray objectAtIndex:currentQuestionIndex] valueForKey:@"answerField"];
	[questionAnswerField setString:@""];
	[questionAnswerField replaceCharactersInRange:NSMakeRange(0, questionAnswerField.string.length) withRTF:data];
	showingQuestion = NO;
}

- (void) resetState
{
	if(window != nil)
		[window close];
	currentQuestionIndex = 0;
	self.flashCardsArray = nil;
	self.window = nil;
	self.answerNext = nil;
	self.backButton = nil;
	self.questionAnswerField = nil;
	showingQuestion = NO;
	isFinished = NO;
}

- (void) dealloc
{
	[super dealloc];
	[self resetState];
}

@end
