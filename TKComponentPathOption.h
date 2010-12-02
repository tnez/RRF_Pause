////////////////////////////////////////////////////////////
//  TKComponentPathOption.h
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/7/10
//  Copyright 2010 Resedential Research Facility,
//  University of Kentucky. All rights reserved.
/////////////////////////////////////////////////////////////
#import <Cocoa/Cocoa.h>
#import "TKComponentOption.h"

@interface TKComponentPathOption : TKComponentOption {
    BOOL                    selectionIsDirectoryType;
    NSString                *value;
}

@property (readwrite) BOOL  selectionIsDirectoryType;
@property (nonatomic, retain) NSString *value;

- (IBAction)browseForPath: (id)sender;

- (id)initWithDictionary: (NSDictionary *)values;

- (BOOL)isValid;

- (IBAction)validate: (id)sender;

@end

extern NSString * const TKComponentOptionIsDirKey;

extern NSString * const TKComponentPathOptionNibNameKey;