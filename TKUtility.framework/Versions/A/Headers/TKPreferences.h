/***************************************************************
 
 TKPreferences.h
 TKUtility
 
 Author: Travis Nesland <tnesland@gmail.com>
 Maintainer: Travis Nesland <tnesland@gmail.com>
 
 Copyright 2010 Residential Research Facility
 (University of Kentucky). All rights reserved.
 
 LastMod: 20100803 - tn
 
 ***************************************************************/

#import <Cocoa/Cocoa.h>

#define TK_PREFS_DEFAULT_FILE_NAME @"preferences.plist"
#define TK_PREFS_DEFAULT_NIB_NAME @"preferences"

/** Notifications */
extern NSString * const TKPreferencesDidChangeNotification;

// singleton in which all application
// parameters should be held as key-value-pairs
@interface TKPreferences : NSObject {
	NSMutableDictionary *data;
	NSString *file;
	NSString *filename;
	NSString *filepath;
	BOOL isDirty;
	NSString *nibName;
	IBOutlet NSWindow *window;
}
@property (retain) NSMutableDictionary *data;
@property (readonly) NSString *file;
@property (readonly) NSString *filename;
@property (readonly) NSString *filepath;
@property	(readwrite) BOOL isDirty;
@property (nonatomic, retain) NSString *nibName;
@property (assign) IBOutlet NSWindow *window;
+(TKPreferences *) defaultPrefs;
-(TKPreferences *) init;
-(IBAction) open:(id) sender;
-(void) read;
-(IBAction) save:(id) sender;
-(void) setValue:(id) theValue forKey:(NSString *) theKey;
-(id) valueForKey:(NSString *) key;
-(void) windowWillClose:(NSNotification *) notification;
-(void) write;
@end

// DELEGATE METHODS //
@interface TKPreferencesDelegate : NSObject
-(void) preferencesDidChage:(NSNotification *) notification;
@end
