//
//  AHTableHeaderCell.m
//  CustomViews
//
//  Created by Adrian Sarli on 4/23/10.
//  Copyright 2010 SimpleUpdates LLC. All rights reserved.
//

#import "AHTableHeaderCell.h"


@implementation AHTableHeaderCell

@synthesize activeCellGradient;
@synthesize inactiveCellGradient;
@synthesize activeTriangleColor;
@synthesize inactiveTriangleColor;
@synthesize cellBorder;
@synthesize activeRightBorder;

- (id) init
{
	if(self = [super init])
	{
		self.activeCellGradient = [[[NSGradient alloc] initWithColorsAndLocations:[NSColor colorWithDeviceRed:.663 green:.722 blue:.808 alpha:1.0],0.0,[NSColor colorWithDeviceRed:.804 green:.851 blue:.918 alpha:1.0],1.0,nil] autorelease];
		self.inactiveCellGradient = [[[NSGradient alloc] initWithColorsAndLocations:[NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:1.0],0.0,[NSColor colorWithDeviceRed:.929 green:.929 blue:.929 alpha:1.0],1.0,nil] autorelease];
		self.cellBorder = [[[NSGradient alloc] initWithColorsAndLocations:[NSColor colorWithDeviceRed:0.684 green:0.684 blue:0.684 alpha:1.0],0.0,[NSColor colorWithDeviceRed:.655 green:.655 blue:.655 alpha:1.0],1.0,nil] autorelease];
		self.activeRightBorder = [[[NSGradient alloc] initWithColorsAndLocations:[NSColor colorWithDeviceRed:.58 green:.675 blue:.816 alpha:1.0],0.0,[NSColor colorWithDeviceRed:.565 green:.667 blue:.824 alpha:1.0],1.0,nil] autorelease];
	}
	return self;
}
- (void)highlight:(BOOL)flag withFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	[super highlight:flag withFrame:cellFrame inView:controlView];
	BOOL selected = (flag && ([controlView.window isMainWindow] && [NSApp isActive]));
	[self drawBorderInFrame:cellFrame selected:selected];
	[self drawBackgroundInFrame:cellFrame selected:selected];
	[self drawTitleInFrame:cellFrame selected:selected];
	//[self drawSortIndicatorWithFrame:cellFrame inView:controlView ascending:ascending priority:0];
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	[super drawWithFrame:cellFrame inView:controlView];
	BOOL selected = ([self state] == NSOnState && ([controlView.window isMainWindow] && [NSApp isActive]));
	[self drawBorderInFrame:cellFrame selected:selected];
	[self drawBackgroundInFrame:cellFrame selected:selected];
	[self drawTitleInFrame:cellFrame selected:selected];
}


-(void) drawBackgroundInFrame:(NSRect)frame selected:(BOOL)selected
{
	frame = NSMakeRect(frame.origin.x, frame.origin.y+1, frame.size.width-1, frame.size.height-2);
	if (selected == YES) {
		[self.activeCellGradient drawInRect:frame angle:-90];
	}
	else {
		[self.inactiveCellGradient drawInRect:frame angle:90];
	}
}
-(void) drawBorderInFrame:(NSRect)frame selected:(BOOL)selected
{
	if (selected == YES) {
		[self.activeRightBorder drawInRect:frame angle:90];
		frame = NSMakeRect(frame.origin.x, frame.origin.y, frame.size.width-1, frame.size.height);
	}
	[self.cellBorder drawInRect:frame angle:90];
}

-(void) drawTitleInFrame:(NSRect)frame selected:(BOOL)selected
{
	NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];	//The attributes for the white background text
    [attrs setValue:[NSColor colorWithCalibratedWhite:1.0 alpha:0.7] 
             forKey:@"NSColor"];
	NSRect whiteDropRect = NSMakeRect(frame.origin.x+.5, frame.origin.y+1, frame.size.width, frame.size.height);
	[[self title] drawInRect:whiteDropRect withAttributes:attrs];
	
	[[NSColor blackColor] set];
	[[self title] drawInRect:frame withAttributes:nil];
	
	//Cleanup
	[attrs release];
}
//-(void) drawArrowInFrame:(NSRect)frame selected:(BOOL)selected;
@end
