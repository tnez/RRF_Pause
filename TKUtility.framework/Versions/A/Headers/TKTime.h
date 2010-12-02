/***************************************************************
 
 TKTime.h
 TKUtility
 
 Author: Travis Nesland <tnesland@gmail.com>
 Maintainer: Travis Nesland <tnesland@gmail.com>
 
 Copyright 2010 Residential Research Facility
 (University of Kentucky). All rights reserved.
 
 LastMod: 20100803 - tn
 
 ***************************************************************/


#import <Cocoa/Cocoa.h>
#import <sys/time.h>

typedef struct {
  NSUInteger seconds;
  NSUInteger microseconds;
} TKTime;

/** Returns a new time value using the given second and microsecond values */
TKTime new_time_marker (NSUInteger sec, NSUInteger microsec);

/** Returns a new time marker using the current second and mircrosecond values */
TKTime current_time_marker ();

/** Returns the difference of two time markers as a time */
TKTime difference (TKTime startMarker, TKTime stopMarker);

/** Returns the difference between the current time and a previous time
    marker as a time */
TKTime time_since (TKTime startMarker);

/** Returns the count of microseconds in a given time */
NSUInteger time_as_microseconds (TKTime timeMarker);

/** Returns a new time marker created from microseconds value */
TKTime time_from_microseconds (NSUInteger usecs);

/** Returns the count of milliseconds for a given time marker */
NSUInteger time_as_milliseconds (TKTime timeMarker);

/** Returns a new time marker created from milliseconds value */
TKTime time_from_milliseconds (NSUInteger msecs);
