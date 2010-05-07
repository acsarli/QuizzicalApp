//
//  LQTextView.m
//  Quizzical
//
//  Created by Adrian Sarli on 5/4/10.
//  Copyright 2010 Adrian Sarli. All rights reserved.
//

#import "LQTextView.h"


@implementation LQTextView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

#pragma mark -
#pragma mark pictureTaker callback

- (void)pictureTakerDidEnd:(IKPictureTaker *)pictureTaker returnCode:(NSInteger)returnCode contextInfo:(void  *)contextInfo
{
    static int snapCount = 0;
    
    if(returnCode == NSOKButton){
        NSImage *image = [pictureTaker outputImage];
        NSString *outputPath = [NSString stringWithFormat:@"/tmp/snap%d.tiff", ++snapCount];
        
        [[image TIFFRepresentation] writeToFile:outputPath atomically:YES];
		
        // Create a file wrapper with an image.
		NSFileWrapper *fwrap = [[[NSFileWrapper alloc] initRegularFileWithContents:
								 [image TIFFRepresentation]] autorelease];
		//[fwrap setFilename:outputPath];
		[fwrap setPreferredFilename:[NSString stringWithFormat:@"snap%d.tiff", ++snapCount]];
		
		// Create an attachment with the file wrapper
		NSTextAttachment * ta = [[[NSTextAttachment alloc] initWithFileWrapper:fwrap] autorelease];
				
		// Append the attachment to the end of the attributed string
		 [self insertText:[NSAttributedString attributedStringWithAttachment:ta]];
		
    }
}


#pragma mark -
#pragma mark actions

- (IBAction) importImage:(id)sender
{
	DLog(@"TEST");
    IKPictureTaker *sharedPictureTaker = [IKPictureTaker pictureTaker];
    
    [sharedPictureTaker setValue:[NSNumber numberWithBool:YES] forKey:IKPictureTakerShowEffectsKey];
    [sharedPictureTaker beginPictureTakerSheetForWindow:[self window] withDelegate:self didEndSelector:@selector(pictureTakerDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

@end
