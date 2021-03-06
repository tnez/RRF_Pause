////////////////////////////////////////////////////////////
//  RRFPauseController.h
//  RRFPause
//  --------------------------------------------------------
//  Author: Travis Nesland
//  Created: 11/28/10
//  Copyright 2010, Residential Research Facility,
//  University of Kentucky. All Rights Reserved.
/////////////////////////////////////////////////////////////
#import <Cocoa/Cocoa.h>
#import <TKUtility/TKUtility.h>

@interface RRFPauseController : NSObject <TKComponentBundleLoading> {

  // PROTOCOL MEMBERS
  ///////////////////
  NSDictionary *definition;
  id delegate;
  NSString *errorLog;
  IBOutlet NSView *view;

  // ADDITIONAL MEMBERS
  /////////////////////
  NSInteger secondsToPause;
  bool shouldStartFromRegValue;
  IBOutlet NSTextField *timeDisplay;
  NSDate *targetDate;
  NSTimer *updateTimer;
}

// PROTOCOL PROPERTIES
//////////////////////
@property (assign) NSDictionary *definition;
@property (assign) id <TKComponentBundleLoading> delegate;
@property (nonatomic, retain) NSString *errorLog;
@property (assign) IBOutlet NSView *view;

// ADDITIONAL PROPERTIES
////////////////////////
@property (assign) IBOutlet NSTextField *timeDisplay;


#pragma mark REQUIRED PROTOCOL METHODS

/**
   Start the component - will receive this message from the component controller
*/
- (void)begin;

/**
   Return full path to data directory as string
*/
- (NSString *)dataDirectory;

/**
   Return a string object representing all current errors in log form
*/
- (NSString *)errorLog;

/**
   Perform any and all error checking required by the component - return YES if
   passed
*/
- (BOOL)isClearedToBegin;

/**
   Returns the file name containing the raw data that will be appended to the
   data file
*/
- (NSString *)rawDataFile;

/**
   Perform actions required to recover from crash using the given raw data passed
   as string
*/
- (void)recover;

/**
   Accept assignment for the component definition
*/
- (void)setDefinition: (NSDictionary *)aDictionary;

/**
   Accept assignment for the component delegate - The component controller will
   assign itself as the delegate
   Note: The new delegate must adopt the TKComponentBundleDelegate protocol
*/
- (void)setDelegate: (id <TKComponentBundleDelegate> )aDelegate;

/**
   Perform any and all initialization required by component - load any nib files
   and perform all required initialization
*/
- (void)setup;

/**
   Return YES if component should perform recovery actions
*/
- (BOOL)shouldRecover;

/**
   Return the Task Name as string
*/
- (NSString *)taskName;

/**
   Perform any and all finalization required by component
*/
- (void)tearDown;

/**
   Return the main view that should be presented to the subject
*/
- (NSView *)mainView;




#pragma mark OPTIONAL PROTOCOL METHODS
// UNCOMMENT ANY OF THE FOLLOWING METHODS IF THEIR BEHAVIOR IS DESIRED
//////////////////////////////////////////////////////////////////////

/**
   Run header if something other than default is required
*/
//- (NSString *)runHeader;

/**
   Session header if something other than default is required
*/
//- (NSString *)sessionHeader;

/**
   Summary data if desired
*/
//- (NSString *)summary;




#pragma mark ADDITIONAL METHODS
// PLACE ANY NON-PROTOCOL METHODS HERE
//////////////////////////////////////

/**
   Add the error to an ongoing error log
*/
- (void)registerError: (NSString *)theError;

/**
   End the pause
*/
- (void)end;

/**
 Return the number of seconds to the time given (represented in military time 
 to minute precision).
 Ex: Current Time = 11:59, Given Time = 12:30
      return: (12:30 - 11:59) <===> 31 * 60 <===> 1860
 This method returns a negative value if the absolute time is in the past
 Ex: Current Time = 11:59, Given Time = 11:30
      return: (11:30 - 11:59) <===> -29 * 30 <===> -1740
*/
- (NSInteger)secondsToPauseForABSTime: (NSInteger)givenSeconds;

/**
 Evaluate the time given as an interval of time in terms of seconds
 Example:
 
 60 ===> the next minute
 120 ===> the minute after next
 3600 ===> the next hour
 3600*2 ===> the hour after next
 3600*3/2 ===> the next hour and a half mark that occurs
 
 In all of these cases, the next interval could be as little as
 seconds away... so the next hour and a half mark would be at a
 maximum one hour and a half away and at a minimum one second away
 ...however, two hours away (3600*2) would be at a minimum one hour
 and one second away and at a maximum two hours away
 
 THIS IS A CONFUSING AND AMBIGUOUS CONFIGURATION!!!
 */
- (NSInteger)secondsToPauseForNextInterval: (NSInteger)givenSeconds;

/**
 Update the display to read remaining minutes left in pause
 */
- (void)updateTimeDisplay: (NSTimer *)theTimer;


#pragma mark Preference Keys
// HERE YOU DEFINE KEY REFERENCES FOR ANY PREFERENCE VALUES
// ex: extern NSString * const RRFPauseNameOfPreferenceKey;
////////////////////////////////////////////////////////////
extern NSString * const RRFPauseTaskNameKey;
extern NSString * const RRFPauseDataDirectoryKey;
extern NSString * const RRFPauseDurationKey;
extern NSString * const RRFPauseModeKey;
extern NSString * const RRFPauseComponentReferenceKey;


#pragma mark Internal Strings
// HERE YOU DEFINE KEYS FOR CONSTANT STRINGS
////////////////////////////////////////////
extern NSString * const RRFPauseMainNibNameKey;


#pragma mark Enumerated Values
// HERE YOU CAN DEFINE ENUMERATED VALUES
////////////////////////////////////////
enum {
  RRFPauseModeFromNow           = 0,
  RRFPauseModeFromComponent     = 1,
  RRFPauseModeToABSTime         = 2,
  RRFPauseModeToNextInterval    = 3
};

@end
