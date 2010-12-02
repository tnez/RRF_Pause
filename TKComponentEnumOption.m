////////////////////////////////////////////////////////////
//  TKComponentEnumParameter.m
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/6/10
//  Copyright 2010 Resedential Research Facility,
//  University of Kentucky. All rights reserved.
/////////////////////////////////////////////////////////////
#import "TKComponentEnumOption.h"

@implementation TKComponentEnumOption
@synthesize enumeratedList,value;

- (void) dealloc {
    [enumeratedList release];
    [value release];
    [super dealloc];
}

- (id)initWithDictionary: (NSDictionary *)values {
    if(self=[super initWithDictionary:values]) {
        [self setEnumeratedList:[values valueForKey:TKComponentOptionEnumeratedListKey]];
        [self setValue:(NSNumber *)[values valueForKey:TKComponentOptionDefaultKey]];
        [NSBundle loadNibNamed:TKComponentEnumOptionNibNameKey owner:self];
        return self;
    }
    return nil;
}

@end

NSString * const TKComponentOptionEnumeratedListKey = @"enumeratedList";
NSString * const TKComponentEnumOptionNibNameKey = @"EnumOption";