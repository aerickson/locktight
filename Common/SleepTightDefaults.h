//
//  SleepTightDefaults.h
//
//	SleepTight preferences
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

// Pref internal defines
#define		PREFVERSIONKEY			@"SleepTightPrefVersion"
#define		CURRENTPREFVERSION		1

@interface SleepTightDefaults : NSObject {
	// Defaults objects
	NSUserDefaults			*theDefaults;
	NSMutableDictionary		*thePrefs;
}

// Pref read/write
- (void)syncFromDisk;
- (void)syncToDisk;
// Pref access
- (BOOL)sleepTightEnabled;
- (void)setSleepTightEnabled:(BOOL)state;
- (BOOL)hotkeyEnabled;
- (void)setHotkeyEnabled:(BOOL)state;
- (BOOL)hotkeySleep;
- (void)setHotkeySleep:(BOOL)state;
- (int)hotkeyModifier;
- (void)setHotkeyModifier:(int)modifier;
- (int)hotkeyCode;
- (void)setHotkeyCode:(int)code;

// Internal
- (BOOL)_loadBoolPref:(NSString *)prefname defaultValue:(BOOL)defaultval;
- (void)_saveBoolPref:(NSString *)prefname value:(BOOL)value;
- (int)_loadIntPref:(NSString *)prefname defaultValue:(int)defaultval;
- (void)_saveIntPref:(NSString *)prefname value:(int)value;

@end
