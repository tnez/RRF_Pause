//
//  TKComponentConfigurationView.h
//  ComRrfComponentVas
//
//  Created by Travis Nesland on 9/7/10.
//  Copyright 2010 Resedential Research Facility,
//  University of Kentucky. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface TKComponentConfigurationView : NSView {
    float width;                // width of entire view
    float height;               // height of entire view
    float marginLeft;
    float marginRight;
    float marginTop;
    float marginBottom;
    NSPoint nextOrigin;         // point of insertion for next subview
}

@property (readwrite) float marginLeft;
@property (readwrite) float marginRight;
@property (readwrite) float marginTop;
@property (readwrite) float marginBottom;

/** Override to provide automatic layout of subviews - Add each view starting at the top and working down, expanding the view as we go */
- (void)addSubview: (NSView *)theSubview;

/** Override to flip the coordinate system - top-down */
- (BOOL)isFlipped;

/** Set all margins equally using number */
- (void)setMargins: (float)newValue;

@end
