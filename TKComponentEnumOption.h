////////////////////////////////////////////////////////////
//  TKComponentEnumParameter.h
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/6/10
//  Copyright 2010 Resedential Research Facility,
//  University of Kentucky. All rights reserved.
/////////////////////////////////////////////////////////////
#import <Cocoa/Cocoa.h>
#import "TKComponentOption.h"

@interface TKComponentEnumOption : TKComponentOption {

    NSArray                             *enumeratedList;
    NSNumber                            *value;
}

@property (nonatomic, retain) NSArray   *enumeratedList;
@property (nonatomic, retain) NSNumber  *value;

- (id)initWithDictionary: (NSDictionary *)values;

@end

extern NSString * const TKComponentOptionEnumeratedListKey;
extern NSString * const TKComponentEnumOptionNibNameKey;

