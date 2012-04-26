//
//  SleepTightBezel.m
//
//	Lock icon window
//
//	Copyright © 2003 Alex Harper
//
// 	This file is part of SleepTight.
// 
// 	SleepTight is free software; you can redistribute it and/or modify
// 	it under the terms of the GNU General Public License as published by
// 	the Free Software Foundation; either version 2 of the License, or
// 	(at your option) any later version.
// 
// 	SleepTight is distributed in the hope that it will be useful,
// 	but WITHOUT ANY WARRANTY; without even the implied warranty of
// 	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// 	GNU General Public License for more details.
// 
// 	You should have received a copy of the GNU General Public License
// 	along with SleepTight; if not, write to the Free Software
// 	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
// 

#import "SleepLockBezel.h"

@implementation SleepLockBezel

///////////////////////////////////////////////////////////////
//	
//	init/awake/dealloc
//
///////////////////////////////////////////////////////////////

- (id)initWithContentRect:(NSRect)contentRect styleMask:(unsigned int)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
	
    self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:bufferingType defer:flag];
	if (!self) {
		return nil;
	}
	
	// Setup the window
	[self setOpaque:NO];
	[self setHasShadow:YES];
	[self setLevel:NSFloatingWindowLevel];
	[self setBackgroundColor:[NSColor clearColor]];
	[self setAlphaValue:1.0];
	// Ignore events
	[self setIgnoresMouseEvents:YES];
	
	return self;
	
} // initWithContentRect

- (void)awakeFromNib {
	
	// Nothing to do
	
} // awakeFromNib

-(void)dealloc {
	
	// Deal with the timer
	if (fadeTimer) {
		if ([fadeTimer isValid]) {
			[fadeTimer invalidate];
		}
		[fadeTimer release];
	}
	
	// Super do its thing
    [super dealloc];

} // dealloc

///////////////////////////////////////////////////////////////
//	
//	subclass stuff
//
///////////////////////////////////////////////////////////////

- (BOOL)canBecomeKeyWindow {
    return NO;
}

- (BOOL)canBecomeMainWindow {
   return NO;
}

///////////////////////////////////////////////////////////////
//	
//	Position and fading
//
///////////////////////////////////////////////////////////////

- (void)positionOnScreen {
	NSScreen	*theScreen = [NSScreen mainScreen];
	NSRect		screenRect, windowRect;
	
	screenRect = [theScreen frame];
	windowRect = [self frame];
	[self setFrameOrigin:NSMakePoint((screenRect.size.width - windowRect.size.width) / 2,
				140)]; // 140 is the (apparently arbitrary) position of the OS builtin bezels

} // positionOnScreen

- (void)showLockDisplay {

	// Deal with the timer
	if (fadeTimer) {
		if ([fadeTimer isValid]) {
			[fadeTimer invalidate];
		}
		[fadeTimer release];
	}
	
	// Set alpha, position, and show
	[self positionOnScreen];
	[self orderFront:nil];
	[self setAlphaValue:1.0];
	
	// Start a timer for when to start the fade
	fadeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self 
					selector:@selector(startFadeWindow:) userInfo:nil repeats:NO];
	[fadeTimer retain];	

} // showLockDisplay

- (void)startFadeWindow:(NSTimer *)theTimer {

	// Kill our caller
	if ([theTimer isValid]) {
		[theTimer invalidate];
	}
	[theTimer release];
	
	// Start the fade
	fadeTimer = [NSTimer scheduledTimerWithTimeInterval:ALPHASTEP target:self 
					selector:@selector(fadeWindow:) userInfo:nil repeats:YES];
	[fadeTimer retain];	

} // startFadeWindow

- (void)fadeWindow:(NSTimer *)theTimer {
	
	// Close the window if we need to
	if ([self alphaValue] < 0.1) {
		[self orderOut:nil];
		[theTimer invalidate];
	}
	else {
		[self setAlphaValue:[self alphaValue] - ALPHASTEP];
	}
	
} // fadeWindow

@end
