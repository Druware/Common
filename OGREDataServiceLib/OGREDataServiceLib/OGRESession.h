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

#import <PGSQLKit/PGSQLKit.h>
#import <PGSQLKit/PGSQLDataObject.h>
#import <PGSQLKit/PGSQLRecordset.h>
// #import "TWJUser.h"

@interface OGRESession : PGSQLDataObject
{
    // TWJUser *user;
}

#pragma mark customer initializers

- (id)initWithConnection:(PGSQLConnection *)pgConn;
- (id)initWithConnection:(PGSQLConnection *)pgConn
                   forId:(NSNumber *)referenceId;
- (id)initWithConnection:(PGSQLConnection *)pgConn
               forRecord:(PGSQLRecordset *)rs;
- (id)initWithConnection:(PGSQLConnection *)pgConn
                  forUid:(NSString *)referenceId;

#pragma mark persistance methods (rdbms, xml)

- (BOOL)save;
- (NSXMLElement *)xmlForObject;
- (BOOL)loadFromXml:(NSXMLElement *)xmlElement;
- (NSMutableArray *)jsonForObject;
- (BOOL)loadFromJson:(NSArray *)jsonElement;


#pragma mark custom properties

@property (copy,readonly)   NSNumber    *sessionId;
@property (copy,readonly)   NSString    *sessionUid;
@property (copy,readonly)   NSDate      *lastAccess;
@property (copy,readonly)   NSString    *deviceId;
@property (assign,readonly) BOOL         isPersistant;
@property (copy,readonly)   NSNumber    *userId;

// @property (copy, readonly)  TWJUser     *user;

#pragma mark custom accessors / property overrides

- (NSNumber *)sessionId;
- (NSString *)sessionUid;
- (NSDate *)lastAccess;
- (NSString *)deviceId;
- (BOOL)isPersistant;
- (NSNumber *)userId;

// - (TWJUser *)user;

#pragma mark custom methods and implmentation

- (BOOL)renew;
// - (BOOL)purgeExpireds;
// - (BOOL)expireSessions;
- (BOOL)validateUser:(NSString *)checkLogin withPassword:(NSString *)checkPassword;

@end
