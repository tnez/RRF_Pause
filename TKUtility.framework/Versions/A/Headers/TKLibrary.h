/***************************************************************
 
 TKLibrary.h
 TKUtility
 
 Author: Scott Southerland
 Maintainer: Travis Nesland <tnesland@gmail.com>
 
 Copyright 2010 Residential Research Facility
 (University of Kentucky). All rights reserved.
 
 LastMod: 20100803 - tn
 
 ***************************************************************/

#import <Cocoa/Cocoa.h>

@interface TKLibrary : NSObject {
}
+ (TKLibrary *)sharedLibrary;
-(void) centerView:(NSView *) theView inWindow:(NSWindow *) theWindow;
-(void) enterFullScreenWithWindow:(NSWindow *) theWindow;
-(void) exitFullScreenWithWindow:(NSWindow *) theWindow;
@end
