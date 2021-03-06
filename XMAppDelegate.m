//
//  CodexFab LicenseExample
//
// XMAppDelegate.m
//
// App delegate: substitute with your own AppDelegate or main NSDocument class.
// The important thing is to register for the XMDidChangeRegistrationNotification notification.
//
//  Licensed under CC Attribution License 3.0 <http://creativecommons.org/licenses/by/3.0/>
//
// Based on CocoaFob by Gleb Dolgich
// <http://github.com/gbd/cocoafob/tree/master>
//
//  Created by Alex Clarke on 10/06/09.
//  Copyright 2009 MachineCodex Software Australia. All rights reserved.
// <http://www.machinecodex.com>


#import "XMAppDelegate.h"
#import "XMArgumentKeys.h"
#import "PFMoveApplication.h"
#import "LQSoftLanding.h"

@interface XMAppDelegate (Private)

- (void)registerForNotifications;

@end


@implementation XMAppDelegate

- (id) init
{
	self = [super init];
	if (self != nil) {
		//[self checkDeadDate];
		[self registerForNotifications];
		[self launchCheck];
		PFMoveToApplicationsFolderIfNecessary();
		if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HideSoftLanding"] != YES) {
			[self showSoftLanding:self];
		}
	}
	
	return self;
}

- (BOOL) isTrialExpired
{
	if([[NSUserDefaults standardUserDefaults] integerForKey:@"date"] == 0) //First launch
	{
		[[NSUserDefaults standardUserDefaults] setInteger:([[NSDate date] timeIntervalSince1970]+2592000) forKey:@"date"];	//30 days
	}
	NSLog(@"%d < %d", [[NSUserDefaults standardUserDefaults] integerForKey:@"date"], [[NSDate date] timeIntervalSince1970]);

	if(abs([[NSUserDefaults standardUserDefaults] integerForKey:@"date"]) < abs([[NSDate date] timeIntervalSince1970])) //Expired
	{
		return YES;
	}
	else {
		return NO;
	}
}

- (void)checkDeadDate
{
	if([[NSDate date] timeIntervalSince1970] > 1275350400)
	{
		NSAlert *alert = [NSAlert alertWithMessageText:@"Quizzical Beta 1 has expired. Please download the latest version." defaultButton:@"Quit" alternateButton:nil otherButton:nil informativeTextWithFormat:nil];
		[[NSApplication sharedApplication] terminate:self];
	}
}

#pragma mark -
#pragma mark Notification

- (void)registerForNotifications {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registrationChanged:) name:XMDidChangeRegistrationNotification object:nil];	
}

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification
{
	// Offer to the move the Application if necessary.
	// Note that if the user chooses to move the application,
	// this call will never return. Therefore you can suppress
	// any first run UI by putting it after this call.
	
}
- (IBAction) showSoftLanding:(id)sender
{
	[[[LQSoftLanding alloc] initWithWindowNibName:@"SoftLanding"] showWindow:self];
}
@end
