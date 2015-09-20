 /*          file: OGRESession.h
 *   description: Implements a Database interface for generation and interaction
 *                with the sessions on the server.
 *
 *                For detailed usage and design notes, please refer the
 *                OGRE Server - Data Services.md documentation.
 *
 * License *********************************************************************
 *
 * Copyright (c) 2014-2015, Andy 'Dru' Satori @ WeAreOGRE.com
 * All rights reserved.
 *
 * See LICENSE.txt for detailed license information.
 *
 *******************************************************************************
 *
 * history:
 *   see method headers for detailed history of changes
 *
 ******************************************************************************/

#import "OGRESession.h"
#import <CoreFoundation/CFUUID.h>

@implementation OGRESession

#pragma mark property implementations;

@synthesize sessionId, sessionUid, lastAccess, isPersistant, deviceId, userId; // , user;

#pragma mark custom initializers

/* initWithConnection
 *   description
 *     implements an init that takes an active PGSQLConnection for use in data
 *     operations withing the object (and it's children as needed)
 *   arguments
 *     (PGSQLConnection *) as the connection to be used for the current object.
 *       note that this connection cannot have multiple result sets open at a
 *       time.
 *   returns
 *     (id) as the current object reference initialized as a new object
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (id)initWithConnection:(PGSQLConnection *)pgConn
{
    self = [super initWithConnection:pgConn
                            forTable:@"web.\"session\""
                      withPrimaryKey:@"session_id"];
    if (!self) {return nil;}
    
    CFUUIDRef       _UUID;
    CFUUIDBytes     myUUIDBytes;
    CFStringRef     myUUIDString;
    char            strBuffer[42];
    NSString 	   *myGUIDString;
    
    _UUID = CFUUIDCreate(kCFAllocatorDefault);
    
    myUUIDString = CFUUIDCreateString(kCFAllocatorDefault, _UUID);
    myUUIDBytes = CFUUIDGetUUIDBytes(_UUID);
    
    // This is the safest way to obtain a C string from a CFString.
    CFStringGetCString(myUUIDString, strBuffer, 42, kCFStringEncodingASCII);
    myGUIDString = [[NSString alloc] initWithFormat:@"%s",strBuffer];
    [super setValue:myGUIDString forProperty:@"session_uid"];
    
    // set the dates
    NSDate *tempLastAccess = [[NSDate alloc] init];
    
    [super setValue:tempLastAccess forProperty:@"last_access"];
    [super setValue:@"NO" forProperty:@"is_persistant"];
    
    if (![self save])
    {
        NSLog(@"Error: %@", [self lastError]);
        [super setValue:nil forProperty:@"session_id"];
    }
    
    return self;
}

/* initWithConnection
 *   description
 *     implements an init that takes an active PGSQLConnection for use in data
 *     operations withing the object (and it's children as needed)
 *   arguments
 *     (PGSQLConnection *) as the connection to be used for the current object.
 *       note that this connection cannot have multiple result sets open at a
 *       time.
 *     (NSNumber *) as the reference number of the primary key for the desired
 *       data record.
 *   returns
 *     (id) as the current object reference initialized as the referenced
 *       data record
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (id)initWithConnection:(PGSQLConnection *)pgConn forId:(NSNumber *)referenceId
{
    self = [super initWithConnection:pgConn
                            forTable:@"web.\"session\""
                      withPrimaryKey:@"session_id"
                               forId:referenceId];
    if (!self) {return nil;}
    
    if (self.userId.intValue > 0)
    {
        //user = [[TWJUser alloc] initWithConnection:connection
        //                                     forId:userId];
        //[user retain];
    }
    
    return self;
}

/* initWithConnection
 *   description
 *     implements an init that takes an active PGSQLConnection for use in data
 *     operations withing the object (and it's children as needed)
 *   arguments
 *     (PGSQLConnection *) as the connection to be used for the current object.
 *       note that this connection cannot have multiple result sets open at a
 *       time.
 *     (NSString *) as the UUID string of the ssessionUID  for the desired
 *       data record.
 *   returns
 *     (id) as the current object reference initialized as the referenced
 *       data record
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (id)initWithConnection:(PGSQLConnection *)pgConn forUid:(NSString *)referenceId
{
    self = [super initWithConnection:pgConn
                            forTable:@"web.\"session\""
                      withPrimaryKey:@"session_id"
                           lookupKey:@"session_uid"
                         lookupValue:referenceId];
    if (!self) {return nil;}
    
    if (self.userId.intValue > 0)
    {
        //user = [[TWJUser alloc] initWithConnection:connection
        //                                     forId:userId];
        //[user retain];
    }
    return self;
}

/* initWithConnection
 *   description
 *     implements an init that takes an active PGSQLConnection for use in data
 *     operations withing the object (and it's children as needed)
 *   arguments
 *     (PGSQLConnection *) as the connection to be used for the current object.
 *       note that this connection cannot have multiple result sets open at a
 *       time.
 *     (PGSQLRecordset *) as a recordset where the desired record is the current
 *       record in the recordset.
 *   returns
 *     (id) as the current object reference initialized as the referenced
 *       data record
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (id)initWithConnection:(PGSQLConnection *)pgConn
               forRecord:(PGSQLRecordset *)rs
{
    self = [super initWithConnection:pgConn
                            forTable:@"web.\"session\""
                      withPrimaryKey:@"session_id"
                           forRecord:rs];
    if (!self) {return nil;}
    
    if (self.userId.intValue > 0)
    {
        //user = [[TWJUser alloc] initWithConnection:connection
        //                                     forId:userId];
        //[user retain];
    }
    
    return self;
}

/* dealloc
 *   description
 *     performs the cleanup of the object, releasing any allocated resources.
 *   arguments
 *     none
 *   returns
 *     none
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (void)dealloc
{
/*
 if (user != nil)
    {
        [user release];
        user = nil;
    }
 */
}

#pragma mark persistance methods (rdbms, xml)

/* save
 *   description
 *     performs the save, though in most cases, this would also save and child
 *     objects, the 'child' objects in this instance are related, but not truly
 *     children and are therefore not saved as a part of the save process.
 *   arguments
 *     none
 *   returns
 *     none
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (BOOL)save
{
    BOOL result = [super save];
    
    // save any child objects that have been altered (as appropriate)
    // category is a related object, but is not going to be altered as a part of
    // an article, so is not considered a 'child' reference.
    
    return result;
}

/* xmlForObject
 *   description
 *     retrieve and XMLElement representing the current object, then add the
 *     child elements to the element in order to get the proper nested data.
 *     if the child objects have not been loaded, they need to be loaded as a
 *     part of this process.
 *   arguments
 *     none
 *   returns
 *     NSXMLElement * representing the XmlElement that contains the description
 *       of the current objects.
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (NSXMLElement *)xmlForObject
{
    NSXMLElement *result = [super xmlForObject];
    
    // add the child nodes to the result, in this instance we don't want to
    // send the full user information, just the selected elements as appropriate
    // [result addChild:[self.user xmlForObject]];
    
    return result;
}

/* loadFromXml
 *   description
 *     provides a method for populating an object from a passed in xml stream.
 *     the stream populates the state of the object and the current state can be
 *     used to update or create a database record based upon the input.
 *   arguments
 *     (NSXMLElement *)xmlElement as the data element defining this object (and
 *       potentially any child objects associated with it.
 *   returns
 *     BOOL result as success or failure of the load.  Should this return NO
 *       then the lastError property should contain a string defining the
 *       reason(s) for the failure.
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (BOOL)loadFromXml:(NSXMLElement *)xmlElement
{
    // reload from the input xml, deal with the child objects as needed
    return [super loadFromXml:xmlElement];
}

#pragma mark custom accessors / property overrides

/* sessionId
 *   description
 *     get accessor for the sessionId field, this is also the primary key. it
 *     is a bigserial int8 value in the database and as such will be
 *     automatically assigned.
 *     *** THIS IS A READ ONLY FIELD ***
 *   arguments
 *     (none)
 *   returns
 *     NSNumber representing the session_id value ( internally: long / bigint )
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (NSNumber *)sessionId
{
    return [super valueForProperty:@"session_id"];
}

/* sessionUid
 *   description
 *     get accessor for the sessionUid field, this is also the public/exposed
 *     key. as far as the outside world is concerned this guuid is the session
 *     identifier.
 *     *** THIS IS A READ ONLY FIELD ***
 *   arguments
 *     (none)
 *   returns
 *     NSString representing the session_uid value ( internally: varchar(64)
 *     / GUUUID )
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (NSString *)sessionUid
{
    return [super valueForProperty:@"session_uid"];
}

/* createdTS
 *   description
 *     get accessor for the createdTS timestamp field.
 *   arguments
 *     (none)
 *   returns
 *     NSString representing the createdTS value ( internally: timestamp )
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (NSDate *)createdTS
{
    return [super valueForProperty:@"created_ts"];
}

/* expiredTS
 *   description
 *     get accessor for the expiredTS timestamp field.
 *   arguments
 *     (none)
 *   returns
 *     NSString representing the expiredTS value ( internally: timestamp )
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (NSDate *)expiredTS
{
    return [super valueForProperty:@"expired_ts"];
}

/* isExpired
 *   description
 *     get accessor for the isExpired timestamp field.
 *   arguments
 *     (none)
 *   returns
 *     BOOL representing the is_expired value ( internally: timestamp )
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (BOOL)isExpired
{
    return ([[super valueForProperty:@"is_expired"] isEqualToString:@"YES"]);
}



/* userId
 *   description
 *     get accessor for the userId field, this is also the foreign key
 *     reference that attaches to the OGREUser relation object.
 *   arguments
 *     (none)
 *   returns
 *     NSNumber representing the user_id value ( internally: long / bigint )
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (NSNumber *)userId
{
    return [super valueForProperty:@"user_id"];
}

// contactId & contact child objects

/* user
 *   description
 *     get accessor for the user child object ( referenced from the
 *     user_id field )
 *   arguments
 *     (none)
 *   returns
 *     TWJUser representing the user object
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
/*
- (TWJUser *)user
{
    if (!user)
    {
        if (userId)
        {
            user = [[TWJUser alloc] initWithConnection:connection
                                                 forId:userId];
            [user retain];
        }
    }
    return user;
}
*/

#pragma mark custom methods and implmentation

/* renew
 *   description
 *     renews the current session extending it by 30 minutes from the current
 *     time at the database level.  for consistancy sake, this will also save
 *     immediately.
 *   arguments
 *     (none)
 *   returns
 *     BOOL as the result of the renew command, yes indicates the renew was
 *     successful
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (BOOL)renew
{
    NSDate *now = [[NSDate alloc] init];
    NSDate *expiredTS = [now dateByAddingTimeInterval:(60 * 30)]; // time interval in seconds.  60s * 30m
    
    if ([expiredTS compare:lastAccess] == NSOrderedDescending)
    {
        NSLog(@"Cannot Renew an Expired Session");
        return NO;
    }
    
    [self setValue:now forProperty:@"last_access"];
    return [self save];
}

/* purgeExpireds
 *   description
 *     prunes all expired sessions from the database, as they should have been
 *     logged at both expiration and creation.  This call does log WHO ran the
 *     purge and when.
 *   arguments
 *     ( none )
 *   returns
 *     BOOL as the result of the purge command, no records to purge will be
 *     treated as a failure (NO)
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
/*
 - (BOOL)purgeExpireds
{
    if (self.user == nil) // eventually this should ALSO set
    {
        NSLog(@"Cannot Purge without permissions");
        return NO;
    }
    
    NSMutableString *cmd = [[NSMutableString alloc] init];
    [cmd appendString:@"delete from t_session where is_expired = true"];
    if ([connection execCommand:cmd] == 0)
    {
        NSLog(@"SQL Error: %@", [connection lastError]);
        [cmd release];
        return NO;
    }
    [cmd release];
    return YES;
}
*/

/* expireSessions
 *   description
 *     sets the isExpired flag on all records where the expired timestamp has
 *     passed.
 *   arguments
 *     (none)
 *   returns
 *     BOOL with YES representing a successful expire.
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
/*
 - (BOOL)expireSessions
{
    // perform an update
    if (self.user == nil)
    {
        NSLog(@"Cannot expire without permissions");
        return NO;
    }
    NSDate *now = [[NSDate alloc] init];
    NSDateFormatter *format = [[[NSDateFormatter alloc] init] autorelease];
    [format setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSMutableString *cmd = [[NSMutableString alloc] init];
    [cmd appendFormat:@"update t_session set is_expired = true where expires_ts < '%@'",
     [format stringFromDate:now]];
    if ([connection execCommand:cmd] == 0)
    {
        
        NSLog(@"SQL Error: %@", [connection lastError]);
        [cmd release];
        return NO;
    }
    [cmd release];
    return YES;
}
*/

/* validateUser
 *   description
 *     using a passed in login and password, find a valid user to assign to the
 *     session.  Fail this validation is the user is already assigned and valid.
 *
 *   arguments
 *     (none)
 *   returns
 *
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (BOOL)validateUser:(NSString *)checkLogin withPassword:(NSString *)checkPassword
{
    BOOL isValid = NO;
    /*
    // TODO: rework this to use a PostgreSQL User instead of the half ass t_user
    
    NSString *cmd = [NSString stringWithFormat:@"select * from t_user where login = %@ and password = %@",
                     [self stringForString:checkLogin],
                     [self stringForString:checkPassword]];
    // NSLog(@"SQL: %@", cmd);
    
    PGSQLRecordset *rs = (PGSQLRecordset *)[connection open:cmd];
    if (![rs isEOF])
    {
        // NSLog(@"Dictionary %@", [rs dictionaryFromRecord]);
        user = [[TWJUser alloc] initWithConnection:connection forRecord:rs];
        [super setValue:[user userId] forProperty:@"user_id"];
        isValid = YES;
        
        [self renew];
    }
    [rs close];
     */
    
    return isValid;
}


@end



