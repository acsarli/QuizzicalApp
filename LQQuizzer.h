//
//  LQQuizzer.h
//  LittleQuizzer
//
//  Created by Adrian Sarli on 3/28/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LQArrayController.h"

@interface LQQuizzer : NSObject {
	IBOutlet NSMutableArray *flashCardsArray;
	IBOutlet NSTextView *questionAnswerField;
	IBOutlet NSButtonCell *answerNext;		//The answer/next button; Changed by buttonPushed:
	IBOutlet NSButton *backButton;		//The answer/next button; Changed by buttonPushed:
	IBOutlet NSWindow *window;			//The window
	NSInteger currentQuestionIndex;			//The index into arrayController
	BOOL showingQuestion;					//This is true if the question is currently displayed, false if the answer is being displayed
	BOOL isFinished;						//This is true if the quiz is finished and the final screen is showing
}

- (void) giveQuiz:(id)sender;			//This is the method that kicks it all off.
- (void) buttonPushed:(id)sender;		//This is called when the "Next" or "Answer" button is pushed
- (void) backButtonPushed:(id)sender;	//This is called when the "Back" button is pushed.
- (void) windowClosed:(id)sender;		//This is called if the quiz window is unexpectedly closed.

//Internal methods
- (void) displayQuestion;
- (void) displayAnswer;
- (void) displayFinish;
- (void) exitQuiz;

- (void) displayQuestionWithNumber: (NSInteger)questionNumber;
- (void) displayAnswerWithNumber: (NSInteger)answerNumber;

- (void) resetState;

@property (nonatomic,retain) NSMutableArray *flashCardsArray;
@property (nonatomic,assign) NSTextView *questionAnswerField;
@property (nonatomic,assign) NSButtonCell *answerNext;
@property (nonatomic,assign) NSButton *backButton;
@property (nonatomic,assign) NSWindow *window;


@end
