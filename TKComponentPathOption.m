////////////////////////////////////////////////////////////
//  TKComponentPathOption.m
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/7/10
//  Copyright 2010 Resedential Research Facility,
//  University of Kentucky. All rights reserved.
/////////////////////////////////////////////////////////////
#import "TKComponentPathOption.h"

@implementation TKComponentPathOption
@synthesize selectionIsDirectoryType,value;

- (void) dealloc {
    [value release];
    [super dealloc];
}

- (IBAction)browseForPath: (id)sender {
    NSOpenPanel *p = [NSOpenPanel openPanel];
    [p setAllowsMultipleSelection:NO];
    [p setCanChooseFiles:!selectionIsDirectoryType];
    [p setCanChooseDirectories:selectionIsDirectoryType];
    [p runModal];
    // user then selects something
    [self setValue:[[[p URLs] objectAtIndex:0] path]];
}

- (id)initWithDictionary: (NSDictionary *)values {
    if(self=[super initWithDictionary:values]) {
        [self setSelectionIsDirectoryType:[[values valueForKey:TKComponentOptionIsDirKey] boolValue]];
        [self setValue:[values valueForKey:TKComponentOptionDefaultKey]];
        [NSBundle loadNibNamed:TKComponentPathOptionNibNameKey owner:self];
        return self;
    }
    return nil;
}

- (BOOL)isValid {
    return [value length] > 0 || allowsNull;
}

- (IBAction)validate: (id)sender {
    // reset error string
    [self setErrorMessage:nil];
    if(![self isValid]) {
        [self setErrorMessage:@"Path must not be nil"];
    }
}

@end

NSString * const TKComponentOptionIsDirKey = @"isDirectory";
NSString * const TKComponentPathOptionNibNameKey = @"PathOption";