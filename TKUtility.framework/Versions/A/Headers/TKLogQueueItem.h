/***************************************************************
 
 TKLogQueueItem.h
 TKUtility
 
 Author: Scott Southerland
 Maintainer: Travis Nesland <tnesland@gmail.com>
 
 Copyright 2010 Residential Research Facility
 (University of Kentucky). All rights reserved.
 
 LastMod: 20100803 - tn
 
 ***************************************************************/

#import <Cocoa/Cocoa.h>

@interface TKLogQueueItem : NSObject {
	NSString * directory;
	NSString * file;
	NSString * logMessage;
	BOOL overwrite;
	NSNumber * offset;
}
@property(nonatomic,retain) NSString * directory;
@property(nonatomic,retain) NSString * file;
@property(nonatomic,retain) NSString * logMessage;
@property(readwrite) BOOL overwrite;
@property(nonatomic,retain) NSNumber * offset;

@end
