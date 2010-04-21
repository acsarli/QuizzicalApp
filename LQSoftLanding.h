//
//  LQSoftLanding.h
//  LittleQuizzer
//
//  Created by Adrian Sarli on 4/15/10.
//  Copyright 2010 SimpleUpdates LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LQSoftLanding : NSWindowController {
	IBOutlet NSArrayController *arrayController;
	IBOutlet NSTableView *tableView;
}
- (IBAction)createNewDocument:(id)sender;
- (IBAction)openExistingDocument:(id)sender;
- (IBAction)takeTour:(id)sender;
- (IBAction)recentDocumentClicked:(id)sender;
@end
