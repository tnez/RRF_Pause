/***************************************************************
 
 TKNotificationQueueItem.h
 TKUtility
 
 Author: Scott Southerland
 Maintainer: Travis Nesland <tnesland@gmail.com>
 
 Copyright 2010 Residential Research Facility
 (University of Kentucky). All rights reserved.
 
 LastMod: 20100803 - tn
 
 ***************************************************************/

#import <Cocoa/Cocoa.h>

@interface TKNotificationQueueItem : NSObject {
	NSNotification * notification;
	NSUInteger secondsToRun;
	NSUInteger microsecondsToRun;
}
@property(nonatomic,retain) NSNotification * notification;
@property(readwrite) NSUInteger secondsToRun;
@property(readwrite) NSUInteger microsecondsToRun;
- (NSComparisonResult)compare:(TKNotificationQueueItem *)queueItem;
@end
