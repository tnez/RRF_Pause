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
  // add check in case seconds to pause is invalid
  if(secondsToPause<1 || secondsToPause>43200) {
    // we will default to 5 seconds if we deem our value invalid
    secondsToPause = 5;
    DLog(@"Seconds to pause deemed invalid (%d sec)",secondsToPause);
  }
  [self performSelector:@selector(end) withObject:nil
             afterDelay:secondsToPause];
  // logging....
  DLog(@"RRFPause - Target Time: %@",[targetDate description]);
  DLog(@"RRFPause(begin) - Begin pause for %d seconds",secondsToPause);
  // initial update of the time display
  [self updateTimeDisplay:nil];
  // begin the update display timer
  [NSTimer scheduledTimerWithTimeInterval:60.0
                                   target:self
                                 selector:@selector(updateTimeDisplay:)
                                 userInfo:nil
                                  repeats:YES];
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
   Perform actions required to recover from crash using the given raw data
   passed as string
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
      secondsToPause = 
        [[definition valueForKey:RRFPauseDurationKey] unsignedIntegerValue];
      DLog(@"RRFPause - Mode:RRFPauseModeFromNow");
      break;
        
  case RRFPauseModeFromComponent:
      DLog(@"RRFPause - Mode:RRFPauseModeFromComponent");
      // get specified pause value
      NSUInteger specifiedPValue = [[definition valueForKey:RRFPauseDurationKey]
                                    unsignedIntegerValue] + 1;
      // get start value from specified component
      NSDate *compStart =
      [[delegate registryForRunWithOffset:0 
                                  forTask:[definition valueForKey:RRFPauseComponentReferenceKey]]
                          valueForKey:@"start"];
      // if we got a valid start value
      if(compStart) {
        // add specified duration to start value for component
        NSDate *futureDate = [compStart initWithTimeInterval:specifiedPValue
                                                   sinceDate:compStart];
        secondsToPause = [futureDate timeIntervalSinceNow];
        DLog(@"Specified Seconds:%d",specifiedPValue);
        DLog(@"Start Value:%@ of Component:%@",compStart,
             [definition valueForKey:RRFPauseComponentReferenceKey]);
      } else { // no valid start date
        // ... log error TODO: change to ELog
        DLog(@"No value found for start date for component:%@",
             [definition valueForKey:RRFPauseComponentReferenceKey]);
      }
      break;

    case RRFPauseModeToABSTime:
      DLog(@"RRFPause - Mode:RRFPauseModeToABSTime");            
      secondsToPause =
      [self secondsToPauseForABSTime:
       [[definition valueForKey:RRFPauseDurationKey] unsignedIntegerValue]] + 1;
      break;
      
    case RRFPauseModeToNextInterval:
      DLog(@"RRFPause - Mode:RRFPauseModeToNextInterval");
      secondsToPause = 
      [self secondsToPauseForNextInterval:
       [[definition valueForKey:RRFPauseDurationKey] unsignedIntegerValue]] + 1;
      break;

  default:
      [self registerError:@"Invalid mode of operation"];
      DLog(@"RRFPause - Mode:Invalid mode selected");
  }
  // if value of pause seconds is not acceptable...
  if(secondsToPause<1) {
    NSLog(@"RRFPause - Invalid pause parameter... defaulting to 1 second");
    // set the pause to 1 second and continue
    secondsToPause = 1;
  }
  
  targetDate =
  [[NSDate dateWithTimeIntervalSinceNow:secondsToPause] retain];
  
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
  // logging
  NSLog(@"RRFPause - Actual Time: %@",
        [[NSDate date] description]);
  // notify our delegate that we are done
  [delegate componentDidFinish:self];
}

/**
 Evaluate the specified second values as an even time division
 ex: - if 60 then pause until the next wall-clock minute
 - if 3600 (60*60) pause until the next wall-clock hour
 - if 1600 (60*30) pause until the next wall-clock half-hour
 Note: This method first finds the magnitude relative to seconds, ie. hours
 would be second-order magnitude, days would be third-order, and then evaluates
 the scalar value for said magnitude (1 hour, 7 hours, etc.). After this the
 next occurence of this magnitude and scalar is sought and scheduled.
 */
- (NSInteger)secondsToPauseForABSTime: (NSInteger)militaryTime {
  // if given time is invalid, register the error
  if( 0 > militaryTime || militaryTime > 2400 ) { 
    [self registerError:@"RRFPause(ABSTime) - Given time is invalid"];
  }
  // create now and parse now into components
  unsigned timeUnits = NSYearCalendarUnit | NSMonthCalendarUnit |
  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
  NSDateComponents *comps = [[NSCalendar currentCalendar]
                             components:timeUnits
                             fromDate:[NSDate date]];
  DLog(@"RRFPause(ABSTime) - Current Time {day:%d hrs: %d min: %d}",
       [comps day],[comps hour],[comps minute]);
  // parse our input time value
  NSInteger min = militaryTime % 100 % 60;
  NSInteger hrs = (militaryTime / 100) % 24;
  // modify our components to match
  [comps setMinute:min];
  [comps setHour:hrs];
  DLog(@"RRFPause(ABSTime) - Scheduled Time {day:%d hrs:%d min:%d}",
       [comps day],[comps hour],[comps minute]);
  // create target date from components
  NSDate *_targetDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
  DLog(@"RRFPause(ABSTime) - Target Time %@",[_targetDate description]);
  // return the time interval between the two dates
  return [_targetDate timeIntervalSinceNow];
}

/**
 Evaluate the time given as an interval of time in terms of seconds
 Example:

          60 ===> the next minute
         120 ===> the minute after next
        3600 ===> the next hour
        3660 ===> the next time a one minute mark occurs
      3600*2 ===> the hour after next
    3600*3/2 ===> the next hour and a half mark that occurs

 In all of these cases, the next interval could be as little as
 seconds away... so the next hour and a half mark would be at a
 maximum one hour and a half away and at a minimum one second away
 ...however, two hours away (3600*2) would be at a minimum one hour
 and one second away and at a maximum two hours away

 THIS IS A CONFUSING AND AMBIGUOUS CONFIGURATION!!!
*/
- (NSInteger)secondsToPauseForNextInterval: (NSInteger)givenSeconds {
  // create now and parse now into components
  unsigned timeUnits = NSYearCalendarUnit | NSMonthCalendarUnit |
  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit |
  NSSecondCalendarUnit;
  NSDateComponents *comps = [[NSCalendar currentCalendar]
                             components:timeUnits
                             fromDate:[NSDate date]];
  DLog(@"RRFPause(RelInterval) - Current Time {day:%d hrs:%d min:%d sec:%d}",
       [comps day],[comps hour],[comps minute],[comps second]);
  // generate target times
  NSInteger targetHrs = givenSeconds / 60 / 60 % 24;
  NSInteger targetMins = givenSeconds / 60 % 60;
  NSInteger targetSecs = givenSeconds % 60;
  DLog(@"RRFPause(RelInterval) - Given Hours:%d",targetHrs);
  DLog(@"RRFPause(RelInterval) - Given Mins:%d",targetMins);
  DLog(@"RRFPause(RelInterval) - Given Seconds:%d",targetSecs);
  // prepare and return values
  if(targetHrs) {
    DLog(@"RRFPause(RelInterval) - Handler:Hours Parser");
    // if minute mark has passed
    if(targetMins<=[comps minute]) {
      [comps setHour:[comps hour]+targetHrs];
    } else { // minute mark has not passed
      [comps setHour:[comps hour]+targetHrs-1];
    }
    [comps setMinute:targetMins];
    [comps setSecond:targetSecs];
    DLog(@"RRFPause(RelInterval) - Target Time:%@",
         [[[NSCalendar currentCalendar] dateFromComponents:comps]
          description]);
    return [[[NSCalendar currentCalendar] dateFromComponents:comps]
            timeIntervalSinceNow];
  }
  // if we are here, then no hours are provided...
  // so sum minute component
  if(targetMins) {
    DLog(@"RRFPause(RelInterval) - Handler:Minutes Parser");
    // if second mark has passed
    if(targetSecs<=[comps second]) {
      [comps setMinute:[comps minute]+targetMins];
    } else { // second mark has not passed
      [comps setMinute:[comps minute]+targetMins-1];
    }
    [comps setSecond:targetSecs];
    DLog(@"RRFPause(RelInterval) - Target Time:%@",
         [[[NSCalendar currentCalendar] dateFromComponents:comps]
          description]);
    return [[[NSCalendar currentCalendar] dateFromComponents:comps]
            timeIntervalSinceNow];
  }
  if(targetSecs) {
    DLog(@"RRFPause(RelInterval) - Handler:Seconds Parser");
    [comps setSecond:[comps second]+targetSecs];
    DLog(@"RRFPause(RelInterval) - Target Time:%@",
         [[[NSCalendar currentCalendar] dateFromComponents:comps]
          description]);
    return [[[NSCalendar currentCalendar] dateFromComponents:comps]
            timeIntervalSinceNow];
  }
  // ...as a default and fail-safe, return -1 to represent invalid param
  DLog(@"RRFPause(RelInterval) - Given time is invalid");
  return -1;
}      

- (void)updateTimeDisplay: (NSTimer *)theTimer {
  // remaining minutes
  NSInteger remMinutes = ([targetDate timeIntervalSinceNow]+1) / 60;
  if(remMinutes>0) {
    // update remaining time display
    [timeDisplay setStringValue:[NSString stringWithFormat:
                                 @"Time Out... %d minutes remain",remMinutes]];
  } else {
    // invalidate timer
    [theTimer invalidate];
  }
  DLog(@"RRFPause(updateTimeDisplay) - timestamp:%@",
       [[NSDate date] description]);
}


#pragma mark Preference Keys
// HERE YOU DEFINE KEY REFERENCES FOR ANY PREFERENCE VALUES
// ex:
// NSString * const RRFPauseNameOfPreferenceKey = @"RRFPauseNameOfPreference"
NSString * const RRFPauseTaskNameKey = @"RRFPauseTaskName";
NSString * const RRFPauseDataDirectoryKey = @"RRFPauseDataDirectory";
NSString * const RRFPauseDurationKey = @"RRFPauseDuration";
NSString * const RRFPauseModeKey = @"RRFPauseMode";
NSString * const RRFPauseComponentReferenceKey = @"RRFPauseComponentReference";



#pragma mark Internal Strings
// HERE YOU DEFINE KEYS FOR CONSTANT STRINGS //
///////////////////////////////////////////////
NSString * const RRFPauseMainNibNameKey = @"RRFPauseMainNib";


@end
