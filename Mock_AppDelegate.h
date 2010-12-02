////////////////////////////////////////////////////////////
//  Mock_AppDelegate.h
//  ComRrfComponentVas
//  --------------------------------------------------------
//  Author: Travis Nesland <tnesland@gmail.com>
//  Created: 9/7/10
//  Copyright 2010 Resedential Research Facility,
//  University of Kentucky. All rights reserved.
/////////////////////////////////////////////////////////////
#import <Cocoa/Cocoa.h>
#import <TKUtility/TKUtility.h>

#ifdef DEBUG
#  define DLog(...) NSLog(__VA_ARGS__)
#else
#  define DLog(...) /* */
#endif
#define MANIFEST [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"RRFPauseManifest" ofType:@"plist"]]


@class TKComponentConfigurationView;
@interface Mock_AppDelegate : NSObject {

    /** setup material */
    NSDictionary                                *manifest;
    NSArray                                     *componentOptions;
    IBOutlet TKSubject                          *subject;
    TKComponentController                       *component;

    /** view boxes */
    IBOutlet NSScrollView                       *leftView;
    IBOutlet NSView                             *topRightView;
    IBOutlet NSView                             *bottomRightView;
    IBOutlet NSWindow                           *setupWindow;
    IBOutlet NSWindow                           *sessionWindow;
    TKComponentConfigurationView                *componentConfigView;

    /** run products */
    NSMutableDictionary                         *componentDefinition;
    NSMutableArray                              *presentedOptions;
    NSString                                    *errorLog;

}

@property (nonatomic, retain) NSDictionary          *manifest;
@property (nonatomic, retain) NSArray               *componentOptions;
@property (assign) IBOutlet TKSubject               *subject;
@property (assign) IBOutlet NSScrollView            *leftView;
@property (assign) IBOutlet NSView                  *topRightView;
@property (assign) IBOutlet NSView                  *bottomRightView;
@property (assign) IBOutlet NSWindow                *setupWindow;
@property (assign) IBOutlet NSWindow                *sessionWindow;
@property (nonatomic, retain) NSMutableDictionary   *componentDefinition;
@property (nonatomic, retain) NSMutableArray        *presentedOptions;
@property (nonatomic, retain) NSString              *errorLog;

/** ACTIONS */
- (IBAction)run: (id)sender;
- (IBAction)runWithSample: (id)sender;
- (IBAction)preflight: (id)sender;

/** INTERNAL METHODS */
- (void)createDefinition;

@end
