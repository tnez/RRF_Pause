////////////////////////////////////////////////////////////
//  TKSubject.h
//  TK-Utility
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 8/29/10
//  Copyright 2010 Residential Research Facility, University
//  of Kentucky. All Rights Reserved.
/////////////////////////////////////////////////////////////
#import <Cocoa/Cocoa.h>

@interface TKSubject : NSObject {
    NSString                                *subject_id;
    NSString                                *study;
    NSString                                *session;
    NSString                                *drugDose;
    NSString                                *drugLevel;
    NSString                                *drugCode;
    NSString                                *drug;    
}

@property (nonatomic, retain) NSString      *subject_id;
@property (nonatomic, retain) NSString      *study;
@property (nonatomic, retain) NSString      *session;
@property (nonatomic, retain) NSString      *drugDose;
@property (nonatomic, retain) NSString      *drugLevel;
@property (nonatomic, retain) NSString      *drugCode;
@property (nonatomic, retain) NSString      *drug;

- (id)init;
- (id)initWithDictionary: (NSDictionary *)subjectInformation;

@end

extern NSString * const TKSubjectIdentifierKey;
extern NSString * const TKSubjectStudyKey;
extern NSString * const TKSubjectSessionKey;
extern NSString * const TKSubjectDrugDoseKey;
extern NSString * const TKSubjectDrugLevelKey;
extern NSString * const TKSubjectDrugCodeKey;
extern NSString * const TKSubjectDrugKey;
