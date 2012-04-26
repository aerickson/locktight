//
//  SleepTightDefaults.m
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
#import "SleepTightDefaults.h"

@implementation SleepTightDefaults

///////////////////////////////////////////////////////////////
//	
//	init/dealloc
//
///////////////////////////////////////////////////////////////

- (id)init {
	
	// Allow super to init
	self = [super init];
	if (!self) {
		return nil;
	}
	
	// Build the defaults and preferences
	theDefaults = [[NSUserDefaults standardUserDefaults] retain];
	[self syncFromDisk];
				
	// Send on back
	return self;
	
} // init

- (void)dealloc {
	
	// Save back
	[theDefaults synchronize];
	
	// Release
	[thePrefs release];
	[theDefaults release];
			
	// Super do its thing
	[super dealloc];

} // dealloc

///////////////////////////////////////////////////////////////
//	
//	Pref read/write
//
///////////////////////////////////////////////////////////////

- (void)syncFromDisk {
	NSMutableDictionary		*releaseMe = nil;
	
	releaseMe = thePrefs;
	[theDefaults synchronize];
	thePrefs = [[NSMutableDictionary dictionaryWithDictionary:[theDefaults persistentDomainForName:SLEEPTIGHTID]] retain];
	if (releaseMe) {
		[releaseMe release];
	}

} // syncFromDisk

- (void)syncToDisk {
	
	[theDefaults removePersistentDomainForName:SLEEPTIGHTID];
	[theDefaults setPersistentDomain:thePrefs forName:SLEEPTIGHTID];
	[self syncFromDisk];

} // syncToDisk

///////////////////////////////////////////////////////////////
//	
//	Pref accessors
//
///////////////////////////////////////////////////////////////

- (BOOL)sleepTightEnabled {
	return [self _loadBoolPref:STENABLEPREFKEY defaultValue:STENABLEDDEFAULT];
} // sleepTightEnabled

- (void)setSleepTightEnabled:(BOOL)state {
	[self _saveBoolPref:STENABLEPREFKEY value:state];
} // setSleepTightEnabled

- (BOOL)hotkeyEnabled {
	return [self _loadBoolPref:STHOTKEYENABLEPREFKEY defaultValue:STHOTKEYENABLEDDEFAULT];
} // hotkeyEnabled

- (void)setHotkeyEnabled:(BOOL)state {
	[self _saveBoolPref:STHOTKEYENABLEPREFKEY value:state];
} // setHotkeyEnabled

- (BOOL)hotkeySleep {
	return [self _loadBoolPref:STHOTKEYSLEEPPREFKEY defaultValue:STHOTKEYSLEEPDEFAULT];
} // hotkeySleep

- (void)setHotkeySleep:(BOOL)state {
	[self _saveBoolPref:STHOTKEYSLEEPPREFKEY value:state];
} // setHotkeySleep

- (int)hotkeyModifier {
	return [self _loadIntPref:STHOTKEYMODIFIERPREFKEY defaultValue:STMODIFIERDEFAULT];
} // hotkeyModifier

- (void)setHotkeyModifier:(int)modifier {
	[self _saveIntPref:STHOTKEYMODIFIERPREFKEY value:modifier];
} // setHotkeyModifier

- (int)hotkeyCode {
	return [self _loadIntPref:STHOTKEYCODEPREFKEY defaultValue:STKEYCODE];
} // hotkeyCode

- (void)setHotkeyCode:(int)code {
	[self _saveIntPref:STHOTKEYCODEPREFKEY value:code];
} // setHotkeyCode

- (BOOL)firstRunWarnOff {
	return [self _loadBoolPref:STFIRSTRUNWARNPREFKEY defaultValue:NO];
} // firstRunWarnOff

- (void)setFirstRunWarnOff:(BOOL)state {
	[self _saveBoolPref:STFIRSTRUNWARNPREFKEY value:state];
} // setFirstRunWarnOff

///////////////////////////////////////////////////////////////
//	
//	Internal
//
///////////////////////////////////////////////////////////////

- (BOOL)_loadBoolPref:(NSString *)prefname defaultValue:(BOOL)defaultval {
	
	// Load the data
	if ([thePrefs objectForKey:prefname]) {
		return [(NSNumber *)[thePrefs objectForKey:prefname] boolValue];
	}
	else {
		[self _saveBoolPref:prefname value:defaultval];
		return defaultval;
	}
					
} // _loadBoolPref

- (void)_saveBoolPref:(NSString *)prefname value:(BOOL)value {
	[thePrefs setObject:[NSNumber numberWithBool:value] forKey:prefname];
} // _saveBoolPref

- (int)_loadIntPref:(NSString *)prefname defaultValue:(int)defaultval {
	int			theint = 0;
	
	// Load the data
	if ([thePrefs objectForKey:prefname]) {
		theint = [(NSNumber *)[thePrefs objectForKey:prefname] intValue];
	}
	else {
		theint = defaultval;
		[self _saveIntPref:prefname value:theint];
	}
	return theint;
					
} // _loadIntPref

- (void)_saveIntPref:(NSString *)prefname value:(int)value {
	[thePrefs setObject:[NSNumber numberWithInt:value] forKey:prefname];
} // _saveIntPref

@end
