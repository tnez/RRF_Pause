////////////////////////////////////////////////////////////
//  RRFPauseController.m
//  RRFPause
//  --------------------------------------------------------
//  Author: Travis Nesland
//  Created: 11/28/10
//  Copyright 2010, Residential Research Facility,
//  University of Kentucky. All Rights Reserved.
/////////////////////////////////////////////////////////////
#import "RRFPauseController.h"

@implementation RRFPauseController

// add any member that has a property
@synthesize delegate,definition,errorLog,view,timeDisplay;

// Definitions //
/////////////////
#define RRFPauseModeEval [[definition valueForKey:RRFPauseModeKey] unsignedIntegerValue]

#pragma mark HOUSEKEEPING METHODS
/**
 Give back any memory that may have been allocated by this bundle
 */
- (void)dealloc {
    [errorLog release];
    // any additional release calls go here
    // ------------------------------------
    
    [super dealloc];
}

#pragma mark REQUIRED PROTOCOL METHODS

/**
 Start the component - will receive this message from the component controller
 */
- (void)begin {
  [self performSelector:@selector(end)
             withObject:self afterDelay:secondsToPause];
  NSLog(@"Begin pause for %d seconds",secondsToPause);
}

/**
 Return the full path to the data directory
 (in this component we probably will not be logging data - but we will provide
 jic)
 */
- (NSString *)dataDirectory {
    return [[definition valueForKey:RRFPauseDataDirectoryKey]
            stringByStandardizingPath];
}

/**
 Return a string object representing all current errors in log form
 */
- (NSString *)errorLog {
    return errorLog;
}

/**
 Perform any and all error checking required by the component - return YES if
 passed
 */
- (BOOL)isClearedToBegin {
  return [errorLog length] == 0;
}

/**
 Returns the file name containing the raw data that will be appended to the
 data file
 */
- (NSString *)rawDataFile {
    return [delegate defaultTempFile]; // this is the default implementation
}

/**
 Perform actions required to recover from crash using the given raw data passed
 as string
 */
- (void)recover {
    // if no recovery is needed, nothing need be done here
}

/**
 Accept assignment for the component definition
 */
- (void)setDefinition: (NSDictionary *)aDictionary {
    definition = aDictionary;
}
/**
 Accept assignment for the component delegate - The component controller will
 assign itself as the delegate
 Note: The new delegate must adopt the TKComponentBundleDelegate protocol
 */
- (void)setDelegate: (id <TKComponentBundleDelegate> )aDelegate {
    delegate = aDelegate;
}
/**
 Perform any and all initialization required by component - load any nib files
 and perform all required initialization
 */
- (void)setup {

  // CLEAR ERROR LOG
  //////////////////
  [self setErrorLog:@""];
    
  // --- WHAT NEEDS TO BE INITIALIZED BEFORE THIS COMPONENT CAN OPERATE? ---
  ///////////////////////////////////////////////////////////////////////////
  switch(RRFPauseModeEval) {
      
      case RRFPauseModeFromNow:
        // TODO: seconds to pause = now + duration
        secondsToPause = 
        [[definition valueForKey:RRFPauseDurationKey] unsignedIntegerValue];
      NSLog(@"Pause mode selected: RRFPauseModeFromNow");
        break;
        
      case RRFPauseModeFromLastComponent:
        // TODO: get the time value from the registry file
        [self registerError:@"Specified pause mode is not yet supported"];
      NSLog(@"Pause mode selected: RRFPauseModeFromLastComponent");
        break;

      case RRFPauseModeToNextWallClock:
        // TODO: determine the next wall clock interval
        [self registerError:@"Specified pause mode is not yet supported"];
      NSLog(@"Pause mode selected: RRFPauseModeToNextWallClock");      
        break;

      default:
        [self registerError:@"Invalid mode of operation"];
      NSLog(@"Pause mode selected: invalid mode of operation");
  }
  // TODO: check that time value is accecptable
  if(NO) {
    [self registerError:@"Invalid pause parameter"];
  }

  // LOAD NIB
  ///////////
  if([NSBundle loadNibNamed:RRFPauseMainNibNameKey owner:self]) {
      // SETUP THE INTERFACE VALUES
      /////////////////////////////
      
  } else { // NIB DID NOT LOAD
      [self registerError:@"Could not load Nib file"];
  }
}

/**
 Return YES if component should perform recovery actions
 */
- (BOOL)shouldRecover {
    return NO;  // this is the default; change if needed
}

/**
 Return the task name as string
 */
- (NSString *)taskName {
  return [definition valueForKey:RRFPauseTaskNameKey];
}

/**
 Perform any and all finalization required by component
 */
- (void)tearDown {
    
}
/**
 Return the main view that should be presented to the subject
 */
- (NSView *)mainView {
    return view;
}

#pragma mark OPTIONAL PROTOCOL METHODS
/** Uncomment and implement the following methods if desired */
/**
 Run header if something other than default is required
 */
//- (NSString *)runHeader {
//
//}
/**
 Session header if something other than default is required
 */
//- (NSString *)sessionHeader {
//
//}
/**
 Summary data if desired
 */
//- (NSString *)summary {
//
//}

        
        

        
#pragma mark ADDITIONAL METHODS
/** Add additional methods required for operation */
- (void)registerError: (NSString *)theError {
    // append the new error to the error log
    [self setErrorLog:[[errorLog stringByAppendingString:theError]
                       stringByAppendingString:@"\n"]];
}

/**
 End the pause
 */
- (void)end {
  // notify our delegate that we are done
  [delegate componentDidFinish:self];
}

#pragma mark Preference Keys
// HERE YOU DEFINE KEY REFERENCES FOR ANY PREFERENCE VALUES
// ex:
// NSString * const RRFPauseNameOfPreferenceKey = @"RRFPauseNameOfPreference"
NSString * const RRFPauseTaskNameKey = @"RRFPauseTaskName";
NSString * const RRFPauseDataDirectoryKey = @"RRFPauseDataDirectory";
NSString * const RRFPauseDurationKey = @"RRFPauseDuration";
NSString * const RRFPauseModeKey = @"RRFPauseMode";



#pragma mark Internal Strings
// HERE YOU DEFINE KEYS FOR CONSTANT STRINGS //
///////////////////////////////////////////////
NSString * const RRFPauseMainNibNameKey = @"RRFPauseMainNib";


@end
