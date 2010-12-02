/***************************************************************
 
 TKDelimitedFileParser.h
 TKUtility
 
 Author: Travis Nesland <tnesland@gmail.com>
 Maintainer: Travis Nesland <tnesland@gmail.com>
 
 Copyright 2010 Residential Research Facility
 (University of Kentucky). All rights reserved.
 
 LastMod: 20100803 - tn
 
 ***************************************************************/

#import <Cocoa/Cocoa.h>

#define TKDELIM_TEXT_QUALIFIERS @"\"\'"
#define TKDELIM_DEFAULT_ENCODING NSUTF8StringEncoding

@interface TKDelimitedFileParser : NSObject {
  NSString *file;               // the file to be parsed
  NSStringEncoding encoding;    // encoding of target file
  NSString *recordDelimiter;    // character(s) to mark record end
  NSString *fieldDelimiter;     // character(s) to mark field end
  BOOL hasFieldsHeader;         // set true if file contains field
                                // names as header- this will allow
                                // access to field values by field
                                // keys
  BOOL isKeyValueSet;           // set true if file is a list of key
                                // -> value- this will allow access to
                                // value by key
  NSMutableArray *records;      // the set of records read by parser
                                // (each record will be another array
                                // containing fields)
                                // To loop through records and fields fast enumeration can be used. Example: for(NSArray *rec in records) { for(NSString *field in rec) { ...do something }}
  NSArray *fieldnames;          // if has header info, this contains
                                // the field names to be mapped for
                                // reference
  NSError *error;               // error container for this object
  NSCharacterSet *charsToIgnore;// set of characters we wish to ignore, things like text-qualifiers and things like that
}
@property(readwrite) BOOL hasFieldsHeader;
@property(readwrite) BOOL isKeyValueSet;
@property(readonly) NSMutableArray *records;
//(id)initParserWithFile: usingEncoding:withRecordDelimiter: withFieldDelimiter:
// returns parsed file, or nil if error or no records were found
-(id)initParserWithFile:(NSString *)_file usingEncoding:(NSStringEncoding)_encoding withRecordDelimiter:(NSString *)_rdelim withFieldDelimiter:(NSString *)_fdelim;
//(id)parserWithFile: withRecordDelimiter: withFieldDelimiter:
// returns parsed file, or nil if error or no records were found
+(id)parserWithFile:(NSString *)_file withRecordDelimiter:(NSString *)_rdelim withFieldDelimiter:(NSString *)_fdelim;
//(id)parserWithFile: usingEncoding:withRecordDelimiter: withFieldDelimiter:
// returns parsed file, or nil if error or no records were found
+(id)parserWithFile:(NSString *)_file usingEncoding:(NSStringEncoding)_encoding withRecordDelimiter:(NSString *)_rdelim withFieldDelimiter:(NSString *)_fdelim;
-(NSArray *)recordByIndex:(NSUInteger)index;
// recordByKey- returns record of first match of key to set of first
// field values in record set, nil if key not found
-(NSArray *)recordByKey:(NSString *)key;
// valueForField(key)- requires that hasFieldsHeader is set to YES
-(NSString *)valueForFieldByKey:(NSString *)fieldKey ofRecord:(id)record;
-(NSString *)valueForFieldByKey:(NSString *)fieldKey ofRecordByIndex:(NSUInteger)recordIndex;
-(NSString *)valueForFieldByKey:(NSString *)fieldKey ofRecordByKey:(NSString *)recordKey;
-(NSString *)valueForFieldByIndex:(NSUInteger)fieldIndex ofRecord:(id)record;
-(NSString *)valueForFieldByIndex:(NSUInteger)fieldIndex ofRecordByIndex:(NSUInteger)recordIndex;
-(NSString *)valueForFieldByIndex:(NSUInteger)fieldIndex ofRecordByKey:(NSString *)recordKey;
// valueForKey- requires that isKeyValueSet is set to YES
-(NSString *)valueForKey:(NSString *)key;
@end
// PRIVATE METHODS
@interface TKDelimitedFileParser ()
// canUseFirstColumnAsKey- check that the file appears to have valid
// key-value format note- this only checks all records have no more
// than two fields
-(BOOL)canUseFirstColumnAsKey;
// canUseFirstRowAsFieldsHeader- check that the file appears to have a
// valid field header note- this only checks that each record has the
// same amount of fields and can be referred to by the header for each
// field, will not validate that first row is not itself a record
-(BOOL)canUseFirstRowAsFieldsHeader;
-(void)dealloc;
// indexForField- returns the index that maps the field key to the field in a given record
-(NSUInteger)indexForField:(NSString *)fieldKey;
-(id)init;
// hasSuccessfullyReadFile- parse the file, return NO if error
-(BOOL)hasSuccessfullyReadFile;
@end
