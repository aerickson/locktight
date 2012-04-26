//
//  SleepTightHotKeyPanel.m
//
//	Key trap for configure panel
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

#import "SleepTightHotKeyPanel.h"

@implementation SleepTightHotKeyPanel

- (void)sendEvent:(NSEvent *)theEvent {

	if ([self delegate]) {
		// Filter key events with modifiers
		if (([theEvent type] == NSKeyDown) && [theEvent modifierFlags]) {
			if ([(SleepTightPref *)[self delegate] hotkeyFromPanelKeyEvent:theEvent]) {
				// Eat the event
			}
			else {
				// Don't eat the event
				[super sendEvent:theEvent];
			}
		}
		else {
			// Don't eat the event
			[super sendEvent:theEvent];
		}
	}
	else {
		// No delegate, don't eat the event
		[super sendEvent:theEvent];
	}
	
} // sendEvent

- (BOOL)performKeyEquivalent:(NSEvent *)theEvent {

	if ([self delegate]) {
		// Filter key events with modifiers
		if (([theEvent type] == NSKeyDown) && [theEvent modifierFlags]) {
			if ([(SleepTightPref *)[self delegate] hotkeyFromPanelKeyEvent:theEvent]) {
				// Eat the event
				return YES;
			}
			else {
				// Don't eat the event
				return [super performKeyEquivalent:theEvent];
			}
		}
		else {
			// Don't eat the event
			return [super performKeyEquivalent:theEvent];
		}
	}
	else {
		// No delegate, don't eat the event
		return [super performKeyEquivalent:theEvent];
	}
	
	return [super performKeyEquivalent:theEvent];

} // performKeyEquivalent

@end
