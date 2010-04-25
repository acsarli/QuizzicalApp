//
//  AHTableHeaderCell.h
//  CustomViews
//
//  Created by Adrian Sarli on 4/23/10.
//  Copyright 2010 SimpleUpdates LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AHTableHeaderCell : NSTableHeaderCell {
	NSGradient *activeCellGradient;
	NSGradient *inactiveCellGradient;
	NSGradient *cellBorder;
	NSGradient *activeRightBorder;
	NSColor *activeTriangleColor;
	NSColor *inactiveTriangleColor;
	BOOL ascending;
}

@property (retain) NSGradient *activeCellGradient;
@property (retain) NSGradient *inactiveCellGradient;
@property (retain) NSColor *activeTriangleColor;
@property (retain) NSColor *inactiveTriangleColor;
@property (retain) NSGradient *cellBorder;
@property (retain) NSGradient *activeRightBorder;

-(void) drawBackgroundInFrame:(NSRect)frame selected:(BOOL)selected;
-(void) drawBorderInFrame:(NSRect)frame selected:(BOOL)selected;	//This draws the border gradient and overwrites the background...
-(void) drawTitleInFrame:(NSRect)frame selected:(BOOL)selected;
-(void) drawArrowInFrame:(NSRect)frame selected:(BOOL)selected;
@end
