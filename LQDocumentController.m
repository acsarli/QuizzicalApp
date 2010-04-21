//
//  LQDocumentController.m
//  Quizzical
//
//  Created by Adrian Sarli on 4/21/10.
//  Copyright 2010 Adrian Sarli. All rights reserved.
//

#import "LQDocumentController.h"
#import "MyDocument.h"

@implementation LQDocumentController

- (id) openUntitledDocumentAndDisplay:(BOOL)displayDocument error:(NSError **)outError
{
	MyDocument *doc = (MyDocument *)[super openUntitledDocumentAndDisplay:displayDocument error:outError];
	[doc.controller add:self];
	return doc;
}
@end
