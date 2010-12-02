////////////////////////////////////////////////////////////
//  TKComponentParameter.m
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/6/10
//  Copyright 2010 Resedential Research Facility,
//  University of Kentucky. All rights reserved.
/////////////////////////////////////////////////////////////
#import "TKComponentOption.h"

@implementation TKComponentOption

@synthesize optionLabel,optionKeyName,errorMessage,help,allowsEdit,allowsNull,defaultValue,view,control;

- (void)dealloc {
    [optionLabel release];
    [optionKeyName release];
    [errorMessage release];
    [help release];
    [defaultValue release];
    [super dealloc];
}

- (id)initWithDictionary: (NSDictionary *)values {
    if(self=[super init]) {
        [self setOptionLabel:[values valueForKey:TKComponentOptionDisplayNameKey]];
        [self setOptionKeyName:[values valueForKey:TKComponentOptionIdentifierKey]];
        [self setErrorMessage:nil];
        [self setHelp:[values valueForKey:TKComponentOptionHelpKey]];
        [self setAllowsEdit:[[values valueForKey:TKComponentOptionAllowsEditKey] boolValue]];
        [self setAllowsNull:[[values valueForKey:TKComponentOptionAllowsNullKey] boolValue]];
        [self setDefaultValue:[values valueForKey:TKComponentOptionDefaultKey]];
        return self;
    }
    return nil;
}
    
- (BOOL)isValid {
    return YES; // override if needed
}

- (IBAction)validate: (id)sender {
}

@end

NSString * const TKComponentOptionsKey = @"TKComponentOptions";
NSString * const TKComponentOptionIdentifierKey = @"optionIdentifier";
NSString * const TKComponentOptionDisplayNameKey = @"displayName";
NSString * const TKComponentOptionTypeKey = @"type";
NSString * const TKComponentOptionDefaultKey = @"default";
NSString * const TKComponentOptionAllowsEditKey = @"allowsEdit";
NSString * const TKComponentOptionAllowsNullKey = @"allowsNull";
NSString * const TKComponentOptionHelpKey = @"help";