//
//  SleepTightBezel.h
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

#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>
#import "SleepTight.h"

#define ALPHASTEP		0.05

@interface SleepLockBezel : NSWindow {
	// The timer
	NSTimer		*fadeTimer;
}

- (void)positionOnScreen;
- (void)showLockDisplay;
- (void)startFadeWindow:(NSTimer *)theTimer;
- (void)fadeWindow:(NSTimer *)theTimer;

@end
