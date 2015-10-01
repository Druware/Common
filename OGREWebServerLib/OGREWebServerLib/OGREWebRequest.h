/*          file: OGREWebRequest.h
 *
 *   description: Define the Web Request as recieved from the client via the 
 *                base CGI interfaces. 
 *
 *                For detailed usage and design notes, please refer to
 *                OGRE_Web_Server_Library.md.
 *
 * License *********************************************************************
 *
 * Copyright (c) 2014-2015,
 *   Andy 'Dru' Satori @ Satori & Associates, Inc DBA WeAreOGRE
 *   All rights reserved.
 *
 * See LICENSE.txt for detailed license information.
 *
 *******************************************************************************
 *
 * history:
 *   see method headers for detailed history of changes
 *
 ******************************************************************************/

#import <Foundation/Foundation.h>
#import "OGREWebServer.h"
#import "OGREWebResponse.h"

@interface OGREWebRequest : NSObject
{
    OGREWebServer	*server;        // ro
    OGREWebResponse	*response;		// ro
    
    NSArray			*parameters;    // ro
    NSDictionary	*queryString;   // ro
    NSDictionary	*form;			// ro
    
    NSDictionary *_environment;
    
    NSString *accept;				// rw
    // long contentLength;			// rw
    // NSString *contentType;		// rw
    // expect;                      // rw
    NSDate *date;					// ro
    NSString *host;					// ro
    // BOOL ifModifiedSince;        // rw
    // range;
    NSString *referer;				// ro
    // BOOL sendChunked;            // rw
    NSString *userAgent;            // ro
    NSString *method;				// ro
}

#pragma mark custom initializers

- (id)init;

#pragma mark custom properties

@property (copy) OGREWebServer *server;
@property (copy, readonly) NSArray *parameters;
@property (copy, readonly) NSDictionary *queryString;
@property (copy, readonly) NSDictionary *form;
@property (copy, readonly) NSString *host;
@property (copy, readonly) NSString *userAgent;
@property (copy, readonly) NSString *referer;
@property (copy, readonly) NSString *method;
@property (copy, readonly) NSString *remoteAddress;

@property (copy, readonly) OGREWebResponse *response;

#pragma mark custom accessors / property overrides


#pragma mark standard web request properties

@end
