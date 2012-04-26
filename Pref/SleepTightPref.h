//
//  SleepTightPref.h
//
//	The pref pane
//
//	Copyright � 2003 Alex Harper
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

#import <PreferencePanes/PreferencePanes.h>
#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>
#import "SleepTight.h"
#import "SleepTightDefaults.h"
#import "SleepTightSaverPref.h"
#import "SleepTightKeyCode.h"

#define AGENTPATH [[self bundle] pathForResource:@"SleepTightAgent" ofType:@"app" inDirectory:@""]
#define AGENTBUNDLENAME @"SleepTightAgent.app"
#define AGENTNAME @"SleepTightAgent"

// Localizable strings
#define OSERRORTITLESTRING @"Unsupported OS Version"
#define OSERRORSTRING @"SleepTight is only supported on MacOS X 10.3 Panther. See the ReadMe file for details."
#define FIRSTRUNTITLESTRING @"SleepTight First Run"
#define FIRSTRUNSTRING @"SleepTight works with most Macintosh models and most screensavers, however some combinations of Mac model and screensaver can cause serious problems. Please read the FAQ in the ReadMe file before enabling SleepTight\n\nThis message will only appear once."


@interface SleepTightPref : NSPreferencePane {
	// Prefs
	SleepTightDefaults		*ourPrefs;
	// Keycode conversion
	SleepTightKeyCode		*keyCoder;
	// Interface outlets
	IBOutlet NSButton		*stEnable;
	IBOutlet NSTextField	*hotkeyLabel;
	IBOutlet NSTextField	*hotkeyDisplay;
	IBOutlet NSButton		*hotkeyChange;
	IBOutlet NSTextField	*versionDisplay;
	// Panel
	IBOutlet NSPanel		*hotkeyPanel;
	IBOutlet NSButton		*hotkeyPanelOK;
	IBOutlet NSButton		*hotkeyPanelCancel;
	IBOutlet NSTextField	*hotkeyPanelDisplay;
	int						lastPanelModifiers;
	int						lastPanelKeyCode;
}

- (void)mainViewDidLoad;
- (void)willSelect;
- (void)didSelect;
- (void)didUnselect;
- (void)disableControls;
- (IBAction)enableChange:(id)sender;
- (IBAction)enableHotkey:(id)sender;
- (IBAction)configureHotkey:(id)sender;
- (void)updateControls;
- (void)updateAgent;
- (IBAction)acceptHotkeySheet:(id)sender;
- (IBAction)cancelHotkeySheet:(id)sender;
- (BOOL)hotkeyFromPanelKeyEvent:(NSEvent *)event;
- (void)addAgentLoginItem;
- (void)removeAgentLoginItem;
- (void)startAgent;
- (void)stopAgent;
- (BOOL)agentIsRunning;

@end
