////////////////////////////////////////////////////////////
//  TKComponentStringOption.h
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/6/10
//  Copyright 2010 Resedential Research Facility,
//  University of Kentucky. All rights reserved.
/////////////////////////////////////////////////////////////
#import <Cocoa/Cocoa.h>
#import "TKComponentOption.h"

@interface TKComponentStringOption : TKComponentOption {
    NSString *value;
}
@property (nonatomic, retain) NSString *value;

- (id)initWithDictionary: (NSDictionary *)values;

- (BOOL)isValid;

- (void)setValue: (NSString *)newValue;

- (IBAction)validate: (id)sender;

@end

extern NSString * const TKComponentStringOptionNibNameKey;