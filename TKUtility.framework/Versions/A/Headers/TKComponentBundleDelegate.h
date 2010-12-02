#import "TKTime.h"
#import "TKSubject.h"


/** 
 TKComponentBundleDelegate: Denotes ability to perform delegate functions for the a loadable cocoa bundle known as TKComponentBundle
 */

@protocol TKComponentBundleDelegate <NSObject>
/**
 Component should send this method to delegate when it has finished
 */
- (void)componentDidFinish: (id)sender;
/**
 Returns name of default temporary file as string
 */
- (NSString *)defaultTempFile;
/**
 Logs string to temporary file (also appends newline at end of string) - string should be sent in format desired for final data file
 */
- (void)logStringToDefaultTempFile: (NSString *)theString;
/**
 Logs string to given directory and file (also appends newline at end of string)
 */
- (void)logString: (NSString *)theString toDirectory: (NSString *)theDirectory toFile: (NSString *)theFile;
/**
 Returns the run count by evaluating the current data file
 */
- (NSInteger)runCount;
/**
 Current session value
 */
- (NSString *)session;
/**
 Start time of the component
 */
- (TKTime)startTime;
/**
 Current subject object
 */
- (TKSubject *)subject;
/**
 Current task name
 */
- (NSString *)task;
/**
 Returns the full path of the temporary directory used for storing crash recovery data and temporary raw data
 */
- (NSString *)tempDirectory;
/**
 Error handling method - when component encounters an error it should send this message to delegate
 */
- (void)throwError: (NSString *)errorDescription andBreak: (BOOL)shouldBreak;
@end
