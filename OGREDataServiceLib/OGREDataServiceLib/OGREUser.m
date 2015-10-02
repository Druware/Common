/*          file: OGREUser.m
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

#import "OGREUser.h"

@implementation OGREUser

#pragma mark property implementations;

@synthesize userId, login, passwordHash, accountValidated, contactId;
// @synthesize contact;

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
                            forTable:@"web.user"
                      withPrimaryKey:@"user_id"];
    if (!self) {return nil;}

    // set any needed defaults
    
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
                            forTable:@"web.user"
                      withPrimaryKey:@"user_id"
                               forId:referenceId];
    if (!self) {return nil;}
    
    if (self.contactId.intValue > 0)
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
- (id)initWithConnection:(PGSQLConnection *)pgConn
                forLogin:(NSString *)forLogin
                withHash:(NSString *)hash;
{
    self = [super initWithConnection:pgConn
                            forTable:@"web.user"
                      withPrimaryKey:@"user_id"
                           lookupKey:@"login"
                         lookupValue:forLogin];
    if (!self) {return nil;}
    
    // compare the stored hash to the provided hash. if they match, validate
    // the user and
    
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
                            forTable:@"web.user"
                      withPrimaryKey:@"user_id"
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
- (NSDictionary *)jsonForObject
{
    NSDictionary *result = [super jsonForObject];
    
    // add the child nodes to the result, in this instance we don't want to
    // send the full user information, just the selected elements as appropriate
    // [result addChild:[self.user xmlForObject]];
    
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

/* userId
 *   description
 *     get accessor for the userId field, this is also the primary key. it
 *     is a bigserial int8 value in the database and as such will be
 *     automatically assigned.
 *     *** THIS IS A READ ONLY FIELD ***
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

/* login
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
- (NSString *)login
{
    return [super valueForProperty:@"login"];
}

/* setLogin
 *   description
 *     set accessor for the login timestamp field.
 *   arguments
 *     (none)
 *   returns
 *     NSString representing the login value ( internally: varchar(255) )
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (void)setLogin:(NSString *)value
{
    // do some heavy lifting here.
    
    // 1. is the login in use? duplicates are not allowed
    // 2. the login cannot be set unless this is a new object.
    
    [super setValue:value forProperty:@"login"];
}

/* passwordHash
 *   description
 *     get accessor for the passwordHash field, *   arguments
 *     (none)
 *   returns
 *     NSString representing the passwordHash value ( internally: varchar(255) )
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (NSString *)passwordHash
{
    return [super valueForProperty:@"passwordHash"];
}

/* setPasswordHash
 *   description
 *     set accessor for the passwordHash field. For security reasons, we never 
 *     even send the password to the server, only the hash, which we compare at
 *     the server side.
 *   arguments
 *     (none)
 *   returns
 *     NSString representing the passwordHash value ( internally: varchar(255) )
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (void)setPasswordHash:(NSString *)value
{
    [super setValue:value forProperty:@"passwordHash"];
}

/* accountValidated
 *   description
 *     get accessor for the account_validated timestamp field.
 *   arguments
 *     (none)
 *   returns
 *     NSString representing the account_validated value ( internally: timestamp )
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (NSDate *)accountValidated
{
    return [super valueForProperty:@"account_validated"];
}

/* setLastAccess
 *   description
 *     set accessor for the account_validated timestamp field.
 *   arguments
 *     (none)
 *   returns
 *     NSString representing the account_validated value ( internally: timestamp )
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
- (void)setAccountValidated:(NSDate *)value
{
    [super setValue:value forProperty:@"account_validated"];
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
- (NSNumber *)contactId
{
    return [super valueForProperty:@"contact_id"];
}


/* contact
 *   description
 *     get accessor for the contact child object ( referenced from the
 *     user_id field )
 *   arguments
 *     (none)
 *   returns
 *     OGREUser representing the user object
 *   history
 *     who   date    change
 *     --- -------- -----------------------------------------------------------
 ******************************************************************************/
/*
 - (OGREUser *)user
 {
     if (!user)
     {
         if (userId)
         {
             user = [[OGREUser alloc] initWithConnection:connection
                                                   forId:userId];
             [user retain];
         }
     }
     return user;
 }
 */

#pragma mark custom methods and implmentation


@end
