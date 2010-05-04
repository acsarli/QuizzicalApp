//
//  LQTextView.h
//  Quizzical
//
//  Created by Adrian Sarli on 5/4/10.
//  Copyright 2010 Adrian Sarli. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@interface LQTextView : NSTextView {

}
#pragma mark Picture methods
- (void)pictureTakerDidEnd:(IKPictureTaker *)pictureTaker returnCode:(NSInteger)returnCode contextInfo:(void  *)contextInfo;
- (IBAction) importImage:(id)sender;

@end
