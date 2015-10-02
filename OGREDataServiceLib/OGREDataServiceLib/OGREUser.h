/*          file: OGREUser.h
 *   description: Defines a Database interface for generation and interaction
 *                with the users in the database.
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

@interface OGREUser : PGSQLDataObject
{
    // OGREContact *_contact;
}

#pragma mark customer initializers

- (id)initWithConnection:(PGSQLConnection *)pgConn;
- (id)initWithConnection:(PGSQLConnection *)pgConn
                   forId:(NSNumber *)referenceId;
- (id)initWithConnection:(PGSQLConnection *)pgConn
               forRecord:(PGSQLRecordset *)rs;
- (id)initWithConnection:(PGSQLConnection *)pgConn
                  forLogin:(NSString *)login
                  withHash:(NSString *)hash;

#pragma mark persistance methods (rdbms, xml)

- (BOOL)save;
- (NSXMLElement *)xmlForObject;
- (BOOL)loadFromXml:(NSXMLElement *)xmlElement;
- (NSDictionary *)jsonForObject;
- (BOOL)loadFromJson:(NSArray *)jsonElement;

#pragma mark custom properties

@property (copy,readonly)   NSNumber    *userId;
@property (copy)            NSString    *login;
@property (copy)            NSString    *passwordHash;
@property (copy,readonly)   NSDate      *accountValidated;
@property (copy,readonly)   NSNumber    *contactId;
// @property (copy,readonly)   OGREContact *contact;

#pragma mark custom accessors / property overrides

- (NSNumber *)userId;
- (NSString *)login;
- (NSString *)passwordHash;
- (NSDate *)accountValidated;
- (void)setAccountValidated:(NSDate *)value;
- (NSNumber *)contactId;

// - (OGREContact *)contact;

#pragma mark custom methods and implmentation

// will need methods for resetting passwords, and other fun things.

@end

