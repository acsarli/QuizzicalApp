//
//  MyDocument.h
//  LittleQuizzer
//
//  Created by Adrian Sarli on 12/21/09.
//  Copyright SimpleUpdates.com, Inc. 2009 . All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LQQuizzer.h"

@interface MyDocument : NSPersistentDocument {
	IBOutlet LQQuizzer *quizzer;
	IBOutlet NSArrayController *controller;
	IBOutlet NSWindow *window;
}
- (void) beginQuiz:(id)sender;
@property (nonatomic, retain) LQQuizzer *quizzer;
@property (nonatomic, retain) NSArrayController *controller;


@end
