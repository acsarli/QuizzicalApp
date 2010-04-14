//
//  CodexFab
//
// XMAppDelegate+Licensing.m
//
//  App delegate extension for licensing methods.
//  Pay attention to the TODO: comments below.
//
//  Licensed under CC Attribution License 3.0 <http://creativecommons.org/licenses/by/3.0/>
//
// Designed to work with CocoaFob by Gleb Dolgich
// <http://github.com/gbd/cocoafob/tree/master>
//
//  Created by Alex Clarke on 10/06/09.
//  Copyright 2009 MachineCodex Software Australia. All rights reserved.


#import "XMAppDelegate.h"
#import "XMLicensingWindowController.h"
#import "XMArgumentKeys.h"
#import "CFobLicVerifier.h"


@implementation XMAppDelegate (Licensing)


- (XMLicensingWindowController *)sharedLicensingWindowController {
	
	return [XMLicensingWindowController sharedLicensingWindowController];
}

- (IBAction)showLicensingWindow:(id)sender {
		
	[[[self sharedLicensingWindowController] window] makeKeyAndOrderFront:self];
}

- (void) launchCheck {
	
	if ([self verifyLicense]) {
		
		NSLog(@"Application is registered.");
		[self sharedLicensingWindowController].isLicensed= YES;
	}
	else {
		
		NSLog(@"Application not registered.");
		[self sharedLicensingWindowController].isLicensed= NO;
		[self showLicensingWindow:self];
	}
}

- (BOOL) verifyLicense {
		
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	NSString * regCode = [defaults valueForKey:kXMRegCode];
	NSString * name = [defaults valueForKey:kXMRegName];
	
	// Here we match CocoaFob's licensekey.rb "productname,username" format
	NSString * regName = [NSString stringWithFormat:@"%@,%@", kXMProductCode, name];
	
	// TODO: Obfuscated public key inspired by AquaticPrime: break up your pubkey.pem and insert it below.
	// Do not use this actual key in your app: it was generated specifically for LittleQuizzer.app.
	// Don't insert the header or footer text, just the key itself. 
	// Add a "\n" token to represent each pubkey.pem newline.
	NSMutableString *pkb64 = [NSMutableString string];
	[pkb64 appendString:@"MIHxMIGoB"];
	[pkb64 appendString:@"gcqhkjOOAQBMIGcAkEA6Ah8svzNTVXVs"];
	[pkb64 appendString:@"iHprGuupWolp9L15XM29/qP\n4"];
	[pkb64 appendString:@"VNOUyIW6"];
	[pkb64 appendString:@"RpTaQC3nLALUlKGpK9Naiz50irHNMoW7JfLrSED"];
	[pkb64 appendString:@"QQIVAMKIbFTXW1v+\n4ViyI6jaO"];
	[pkb64 appendString:@"Kdq1z"];
	[pkb64 appendString:@"YzAkAhvKo8f4ESn6TFJkP8P0ZabIC"];
	[pkb64 appendString:@"QN1"];
	[pkb64 appendString:@"6nVCBbvQDuOT4kp1/G\neYg9G"];
	[pkb64 appendString:@"Gw5/6h5Q1Q39+BTCOf"];
	[pkb64 appendString:@"AGGFPBvEFxBxm+OGkA0QAAkEApDjwVXy"];
	[pkb64 appendString:@"Pn4KA4OKC\nrRhtCY7"];
	[pkb64 appendString:@"4zmT6CRzRmQ8fZu/DobsQ/fZyWeZ9oZN7zCj/nARPPu"];
	[pkb64 appendString:@"nH+Qk1xLT90pkM\ntqaDSg=="];
	[pkb64 appendString:@"\n"];
	NSString *publicKey = [NSString stringWithString:pkb64];
	
	
	publicKey = [CFobLicVerifier completePublicKeyPEM:publicKey];

	CFobLicVerifier * verifier = [CFobLicVerifier verifierWithPublicKey:publicKey];

	verifier.regName = regName;
	verifier.regCode = regCode;
	NSLog(@"publicKey %@ \n regCode: %@ regName: %@", publicKey, verifier.regCode, verifier.regName);
	 
	if ([verifier verify]) {

		NSLog(@"Yes %@", verifier);
		return YES;
	}
		 
	NSLog(@"No %@", verifier);
	return NO;
}
	 
- (void) registrationChanged:(NSNotification *)notification {
		
	XMLicensingWindowController * licenseWindowController = [self sharedLicensingWindowController];
	[self showLicensingWindow:self];
	
	BOOL isValidLicense = [self verifyLicense];
	
	[licenseWindowController showLicensedStatus:isValidLicense];
}

@end
