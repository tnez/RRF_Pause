////////////////////////////////////////////////////////////
//  TKComponentParameter.h
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/6/10
//  Copyright 2010 Resedential Research Facility,
//  University of Kentucky. All rights reserved.
/////////////////////////////////////////////////////////////
#import <Cocoa/Cocoa.h>

@interface TKComponentOption : NSObject {

    NSString                                *optionLabel;
    NSString                                *optionKeyName;
    NSString                                *errorMessage;
    NSString                                *help;
    BOOL                                    allowsEdit;
    BOOL                                    allowsNull;
    id                                      defaultValue;
    /** Outlets */
    IBOutlet NSView                         *view;
    IBOutlet NSControl                      *control;
}

@property (nonatomic, retain)   NSString    *optionLabel;
@property (nonatomic, retain)   NSString    *optionKeyName;
@property (nonatomic, retain)   NSString    *errorMessage;
@property (nonatomic, retain)   NSString    *help;
@property (readwrite)           BOOL        allowsEdit;
@property (readwrite)           BOOL        allowsNull;
@property (nonatomic, retain)   id          defaultValue;
/** Outlets */
@property (assign)  IBOutlet    NSView      *view;
@property (assign)  IBOutlet    NSControl   *control;

/** initWithDictionary: - sets values for given opiton using dictionary */
- (id)initWithDictionary: (NSDictionary *)values;

/** isValid - returns the validity of the user input value */
- (BOOL)isValid;

/** validate: - validation of the value as an action when user did finish editing */
- (IBAction)validate: (id)sender;

@end

extern NSString * const TKComponentOptionsKey;
extern NSString * const TKComponentOptionIdentifierKey;
extern NSString * const TKComponentOptionDisplayNameKey;
extern NSString * const TKComponentOptionTypeKey;
extern NSString * const TKComponentOptionDefaultKey;
extern NSString * const TKComponentOptionAllowsEditKey;
extern NSString * const TKComponentOptionAllowsNullKey;
extern NSString * const TKComponentOptionHelpKey;


enum TKComponentOptionType {
    TKComponentOptionTypeString     = 0,
    TKComponentOptionTypeNumber     = 1,
    TKComponentOptionTypeBoolean    = 2,
    TKComponentOptionTypePath       = 3,
    TKComponentOptionTypeEnum       = 4
}; typedef NSInteger TKComponentOptionType;
