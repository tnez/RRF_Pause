/***************************************************************
 
 TKTimer.h
 TKUtility
 
 Author: Scott Southerland
 Maintainer: Travis Nesland <tnesland@gmail.com>
 
 Copyright 2010 Residential Research Facility
 (University of Kentucky). All rights reserved.
 
 LastMod: 20100803 - tn
 
 ***************************************************************/


#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface TKTimer : NSObject {
	NSUInteger  microseconds;
	NSUInteger	seconds;
	NSUInteger	startTimeSeconds;
	NSUInteger  startTimeMicroSeconds;
	NSMutableArray * notificationQueue;
	BOOL	    continueTimer;
}
@property(readwrite) NSUInteger microseconds;
@property(readwrite) NSUInteger seconds;
@property(readwrite) NSUInteger startTimeSeconds;
@property(readwrite) NSUInteger startTimeMicroSeconds;
@property(readwrite) BOOL continueTimer;
@property(nonatomic,retain) NSMutableArray * notificationQueue;
+(TKTimer *)appTimer;
-(void)mainTimeLoop;
+(void)spawnAndBeginTimer:(id)param;
-(void)registerEventWithNotification:(NSNotification *) notification inSeconds:(NSUInteger) secondsTilRun microSeconds:(NSUInteger)microsecondsTilRun;



@end
