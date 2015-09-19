//
//  OGREWebResponse.h
//  OGRE.Server.Web
//
//  Created by Andy Satori on 9/18/15.
//  Copyright © 2015 O.G.R.E. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OGREWebResponse : NSObject
{
    NSString *contentType;		// rw
    NSNumber *contentLength;	// rw
    NSMutableArray *headers;	// ro
    NSString *content;			// rw
    NSData	*rawData;			// rw
}

#pragma mark custom initializers

- (id)init;

#pragma mark custom methods

- (void)write;
- (void)redirect:(NSString *)url;

#pragma mark custom properties

@property (copy) NSString *contentType;
@property (copy) NSNumber *contentLength;
@property (copy, readonly) NSMutableArray *headers;
@property (copy) NSString *content;
@property (copy) NSData *rawData;

#pragma mark custom accessors / property overrides

@end
