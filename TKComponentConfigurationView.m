//
//  TKComponentConfigurationView.m
//  ComRrfComponentVas
//
//  Created by Travis Nesland on 9/7/10.
//  Copyright 2010 Resedential Research Facility,
//  University of Kentucky. All rights reserved.
//

#import "TKComponentConfigurationView.h"


@implementation TKComponentConfigurationView
@synthesize marginLeft,marginRight,marginTop,marginBottom;
- (void)awakeFromNib {
    width = marginLeft + marginRight;
    height = marginTop + marginBottom;
    [self setAutoresizesSubviews:NO];
    [self setNeedsDisplay:YES];
}

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        width = marginLeft + marginRight;
        height = marginTop + marginBottom;
        [self setAutoresizesSubviews:NO];
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
    [self setFrame:NSMakeRect(0.0,0.0,width,height)];
}

- (void)addSubview: (NSView *)theSubview {
    // set the frame origin for new subview
    [theSubview setFrameOrigin:
     NSMakePoint(marginLeft,height-marginBottom)];
    // if the subview's width is greater than our current width...
    if([theSubview frame].size.width > width-marginLeft-marginRight) {
        // ...expand
        width = [theSubview frame].size.width + marginLeft + marginRight;
    }
    // expand the view's height to include new subview
    height = height + [theSubview frame].size.height;
    // add the subview
    [super addSubview:theSubview];
    // mark both views for drawing
    [theSubview setNeedsDisplay:YES];
    [self setNeedsDisplay:YES];
}

- (BOOL)isFlipped {
    return YES; // do this so origin is top left
}

- (void)setMargins: (float)newValue {
    // save old values needed for bounds recalc
    float oldLeft, oldTop;
    oldLeft         = marginLeft;
    oldTop          = marginTop;
    // set new values
    marginLeft      = newValue;
    marginRight     = newValue;
    marginTop       = newValue;
    marginBottom    = newValue;
    height          = marginTop + marginBottom + height;
    width           = marginLeft + marginRight + width;
    // for each subview...
    for(NSView *v in [self subviews]) {
        // update frame origin
        NSPoint old = [v frame].origin;
        [v setFrameOrigin:NSMakePoint(old.x+marginLeft-oldLeft,
                                      old.y+marginTop-oldTop)];
        // if subview spans beyone width...
        if([v bounds].size.width+marginLeft+marginRight > width) {
            //...update width
            width = [v bounds].size.width+marginLeft+marginRight;
        }
        // if subview spans beyond height...
        if([v frame].origin.y+[v bounds].size.height+marginBottom > height) {
            //...update height
            height = [v frame].origin.y+[v bounds].size.height+marginBottom;
        }
        // flag subview for redraw
        [v setNeedsDisplay:YES];
    }
    // flag ourself for redraw
    [self setNeedsDisplay:YES];
}

@end
