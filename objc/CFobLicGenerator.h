//
//  CFobLicGenerator.h
//  CocoaFob
//
//  Created by Gleb Dolgich on 09/02/2009.
//  Follow me on Twitter @gbd.
//  Copyright (C) 2009 PixelEspresso. All rights reserved.
//  Licensed under CC Attribution License 3.0 <http://creativecommons.org/licenses/by/3.0/>
//

#import <Foundation/Foundation.h>
#import <openssl/dsa.h>

/*!
	@class       CFobLicGenerator 
	@superclass  NSObject
	@abstract    Generates CocoaFob-style registration codes.
	@discussion  Given user name and DSA private key, generates a human-readable registration code.
*/
@interface CFobLicGenerator : NSObject {
	DSA *dsa;
	NSString *regName;
	NSString *regCode;
	NSString *lastError;
}

@property (nonatomic, copy) NSString *regName;
@property (nonatomic, copy) NSString *regCode;
@property (nonatomic, copy) NSString *lastError;

/*!
	@method     generatorWithPrivateKey:
	@abstract   Creates a new registration code generator given DSA private key.
	@discussion Use this class method to create an autoreleased registration code generator.
	@param      privKey PEM-encoded non-encrypted DSA private key.
	@result     A new autoreleased registration code generator object.
*/
+ (id)generatorWithPrivateKey:(NSString *)privKey;

/*!
	@method     initWithPrivateKey:
	@abstract   Designated initializer that takes a DSA private key.
	@discussion Initializes registration code generator using a DSA private key.
	@param      privKey PEM-encoded non-encrypted DSA private key.
	@result     An initialized registration code generator object.
*/
- (id)initWithPrivateKey:(NSString *)privKey;

/*!
	@method     setPrivateKey:
	@abstract   Sets a new DSA private key.
	@discussion Sets a new DSA private key to be used for subsequent generated registration codes.
	@param      privKey PEM-encoded non-encrypted DSA private key.
	@result     YES on success, NO on error.
*/
- (BOOL)setPrivateKey:(NSString *)privKey;

/*!
	@method     generate
	@abstract   Generates a registration code from regName property.
	@discussion Takes regName property and DSA private key and generates a new registration code that is placed in regCode property.
	@result     YES on success, NO on error.
*/
- (BOOL)generate;

@end
