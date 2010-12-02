/***************************************************************
 
 TKQuestionSet.h
 TKUtility
 
 Author: Travis Nesland <tnesland@gmail.com>
 Maintainer: Travis Nesland <tnesland@gmail.com>
 
 Copyright 2010 Residential Research Facility
 (University of Kentucky). All rights reserved.
 
 LastMod: 20100803 - tn
 
 ***************************************************************/


#import <Cocoa/Cocoa.h>
#import "TKDelimitedFileParser.h"
#import "TKQuestion.h"

#define DEFAULT_ENCODING NSUTF8StringEncoding
#define DEFAULT_RECORD_DELIM @"\n"
#define DEFAULT_FIELD_DELIM @"\t"

enum {TKQuestionSetSequentialAccess = 0,
      TKQuestionSetRandomNoRepeat = 1,
      TKQuestionSetRandomWithRepeat = 2} TKQuestionAccessMethod;

@interface TKQuestionSet : NSObject {
  NSString *uid;
  NSString *directory;
  NSString *filename;
  NSString *fullPathToFile;
  NSString *errorDescription;
  NSMutableArray *questions;
  NSUInteger accessMethod;
}

@property(readonly) NSString *uid;
@property(readonly) NSString *errorDescription;
@property(readwrite) NSUInteger accessMethod;

-(id) addQuestion:(TKQuestion *) newQuestion;
-(NSInteger) count;
-(id) initFromFile:(NSString *) _fullpath usingAccessMethod:(NSUInteger) _accessMethod;
-(BOOL) isEmpty;
-(BOOL) isValidQuestion:(NSArray *)_question;
-(id) nextQuestion;
-(id) questionWithId:(NSString *) questionId;
+(id) questionSetFromFile:(NSString *) _fullpath usingAccessMethod:(NSUInteger) _accessMethod;
-(void) removeQuestionWithId:(NSString *) questionId;

@end

///////////////////////////////////////////
// PRIVATE METHODS:
///////////////////////////////////////////
@interface TKQuestionSet ()

-(BOOL) questionsHaveLoaded;
-(TKQuestion *) nextSequentialQuestion;
-(TKQuestion *) nextRandomQuestionNoRepeat;
-(TKQuestion *) nextRandomQuestionWithRepeat;
@end
