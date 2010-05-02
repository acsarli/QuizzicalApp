//
//  MyDocument.h
//  LittleQuizzer
//
//  Created by Adrian Sarli on 12/21/09.
//  Copyright SimpleUpdates.com, Inc. 2009 . All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LQQuizzer.h"

@interface LQDocument : NSPersistentDocument {
	IBOutlet LQQuizzer *quizzer;
	IBOutlet NSArrayController *controller;
	IBOutlet NSWindow *mainWindow;
	IBOutlet NSTableView *tableView;
}
- (void) beginQuiz:(id)sender;
@property (nonatomic, retain) LQQuizzer *quizzer;
@property (nonatomic, retain) NSArrayController *controller;
@property (nonatomic, retain) NSWindow *mainWindow;


@end
