////////////////////////////////////////////////////////////
//  Mock_AppDelegate.m
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/7/10
//  Copyright 2010 Resedential Research Facility,
//  University of Kentucky. All rights reserved.
/////////////////////////////////////////////////////////////
#import "Mock_AppDelegate.h"
#import "TKComponentConfigurationView.h"
#import "TKComponentOption.h"
#import "TKComponentStringOption.h"
#import "TKComponentNumberOption.h"
#import "TKComponentBooleanOption.h"
#import "TKComponentPathOption.h"
#import "TKComponentEnumOption.h"

@implementation Mock_AppDelegate
@synthesize manifest,componentOptions,subject,leftView,topRightView,bottomRightView,
componentDefinition,setupWindow,sessionWindow,presentedOptions,errorLog;

- (void)dealloc {
    // remove notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // release objects
    [manifest release];
    [componentOptions release];
    [componentDefinition release];
    [presentedOptions release];
    [errorLog release];
    [super dealloc];
}

- (void)awakeFromNib {

    // setup loggers and timers
    [NSThread detachNewThreadSelector:@selector(spawnAndBeginTimer:) toTarget:[TKTimer class] withObject:nil];
    NSLog(@"Session timer started");
    [NSThread detachNewThreadSelector:@selector(spawnMainLogger:) toTarget:[TKLogging class] withObject:nil];
    [NSThread detachNewThreadSelector:@selector(spawnCrashRecoveryLogger:) toTarget:[TKLogging class] withObject:nil];
    NSLog(@"Session logs started");

    // clear any old components
    component = nil;

    // register for notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(theComponentWillBegin:)
                                                 name:TKComponentWillBeginNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(theComponentDidBegin:)
                                                 name:TKComponentDidBeginNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(theComponentDidFinish:)
                                                 name:TKComponentDidFinishNotification
                                               object:nil];

    // reset error log
    errorLog = nil;

    // read manifest
    [self setManifest:MANIFEST];

    // get options
    [self setPresentedOptions:[NSMutableArray array]];
    [self setComponentOptions:[NSArray arrayWithArray:
                               [manifest valueForKey:TKComponentOptionsKey]]];
    [self setComponentDefinition:[[NSMutableDictionary alloc] init]];

    // load component config view
    componentConfigView =
        [[TKComponentConfigurationView alloc] initWithFrame:[leftView frame]];
    [componentConfigView setMargins:10.0];

    // for each option add a subview
    id tmp = nil;
    for(id option in componentOptions) {
        switch([[option valueForKey:TKComponentOptionTypeKey] integerValue]) {
            case TKComponentOptionTypeString:
                tmp = [[TKComponentStringOption alloc]
                          initWithDictionary:option];
                [componentConfigView addSubview:[tmp view]];
                [presentedOptions addObject:tmp];
                [tmp release]; tmp=nil;
                break;
            case TKComponentOptionTypeNumber:
                tmp = [[TKComponentNumberOption alloc]
                          initWithDictionary:option];
                [componentConfigView addSubview:[tmp view]];
                [presentedOptions addObject:tmp];
                [tmp release]; tmp=nil;
                break;
            case TKComponentOptionTypeBoolean:
                tmp = [[TKComponentBooleanOption alloc]
                          initWithDictionary:option];
                [componentConfigView addSubview:[tmp view]];
                [presentedOptions addObject:tmp];
                [tmp release]; tmp=nil;
                break;
            case TKComponentOptionTypePath:
                tmp = [[TKComponentPathOption alloc]
                          initWithDictionary:option];
                [componentConfigView addSubview:[tmp view]];
                [presentedOptions addObject:tmp];
                [tmp release]; tmp=nil;
                break;
            case TKComponentOptionTypeEnum:
                tmp = [[TKComponentEnumOption alloc]
                          initWithDictionary:option];
                [componentConfigView addSubview:[tmp view]];
                [presentedOptions addObject:tmp];
                [tmp release]; tmp=nil;
                break;
            default:
                break;
        }   // end switch
    }       // end for

    // add component view to left view
    [leftView setDocumentView:componentConfigView];

    // display views
    [componentConfigView setNeedsDisplay:YES];
    [leftView setNeedsDisplay:YES];
    [[leftView superview] setNeedsDisplay:YES];

}

- (void)createDefinition {

    // populate universal manifest info
    [componentDefinition setValue:[manifest valueForKey:TKComponentTypeKey] forKey:TKComponentTypeKey];
    [componentDefinition setValue:[manifest valueForKey:TKComponentNameKey] forKey:TKComponentNameKey];
    [componentDefinition setValue:[manifest valueForKey:TKComponentBundleNameKey] forKey:TKComponentBundleNameKey];
    [componentDefinition setValue:[manifest valueForKey:TKComponentBundleIdentifierKey] forKey:TKComponentBundleIdentifierKey];

    // populate options
    for(TKComponentOption *option in presentedOptions) {
      DLog(@"Attempting to insert: %@ into %@",
           [option value],[option optionLabel]);
        [componentDefinition setValue:[option value]
                               forKey:[option optionKeyName]];
    }
}


- (IBAction)preflight: (id)sender {

    // create definition from options
    [self createDefinition];

    // create component
    component = [[TKComponentController loadFromDefinition:componentDefinition] retain];

    // setup component
    [component setSubject:subject];
    [component setSessionWindow:sessionWindow];

    // test
    [self setErrorLog:[component preflightAndReturnErrorAsString]];

    // give back component
    [component release]; component = nil;
}

- (IBAction) run: (id)sender {

    // create definition
    [self createDefinition];

    // create component
    component = [[TKComponentController loadFromDefinition:componentDefinition] retain];

    // setup component
    [component setSubject:subject];
    [component setSessionWindow:sessionWindow];

    // begin component
    [component begin];

}

- (IBAction) runWithSample: (id)sender {

    // create component definition
    [self setComponentDefinition:[NSDictionary dictionaryWithContentsOfFile:
                                  [[NSBundle mainBundle] pathForResource:@"SampleDefinition" ofType:@"plist"]]];

    // create component
    component = [[TKComponentController loadFromDefinition:componentDefinition] retain];

    // setup component
    [component setSubject:subject];
    [component setSessionWindow:setupWindow];

    // if component is good to go...
    if([component isClearedToBegin]) {
        // ...go
        [component begin];
    } else { // if component is not good...
        // ...
    }
}

- (void)theComponentWillBegin: (NSNotification *)aNote {

    NSLog(@"The component will begin");
    // bring up the session window
    [sessionWindow makeKeyAndOrderFront:self];
}

- (void)theComponentDidBegin: (NSNotification *)aNote {
    NSLog(@"The component did begin");

}

- (void)theComponentDidFinish: (NSNotification *)aNote {
    NSLog(@"The component did finish");
    [[TKLibrary sharedLibrary] exitFullScreenWithWindow:sessionWindow];
    [component release]; component = nil;
}

@end
