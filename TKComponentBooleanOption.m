////////////////////////////////////////////////////////////
//  TKComponentBooleanParameter.m
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/6/10
//  Copyright 2010 Resedential Research Facility,
//  University of Kentucky. All rights reserved.
/////////////////////////////////////////////////////////////
#import "TKComponentBooleanOption.h"

@implementation TKComponentBooleanOption
@synthesize value;

- (void)dealloc {
    [value release];
    [super dealloc];
}

- (id)initWithDictionary: (NSDictionary *)values {
    if(self=[super initWithDictionary:values]) {
        [self setValue:(NSNumber *)[values valueForKey:TKComponentOptionDefaultKey]];
        [NSBundle loadNibNamed:TKComponentBooleanOptionNibNameKey owner:self];
        return self;
    }
    return nil;
}

@end

NSString * const TKComponentBooleanOptionNibNameKey = @"BooleanOption";