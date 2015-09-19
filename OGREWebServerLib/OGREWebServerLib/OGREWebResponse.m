//
//  OGREWebResponse.m
//  OGRE.Server.Web
//
//  Created by Andy Satori on 9/18/15.
//  Copyright © 2015 O.G.R.E. All rights reserved.
//

#import "OGREWebResponse.h"

@implementation OGREWebResponse

@synthesize contentType, contentLength, headers, content, rawData;

#pragma mark custom initializers

- (id)init
{
    self = [super init];
    
    if (self != nil)
    {
        contentType = @"text/xml";
        contentLength = [[NSNumber alloc] initWithInt:0];
        headers = [[NSMutableArray alloc] init];
        content = nil;
        rawData = nil;
    }
    
    return self;
}

#pragma mark custom methods

- (void)write
{
    printf("Content-type: %s\r\n", [contentType cStringUsingEncoding:NSUTF8StringEncoding]);
    if (rawData != nil)
    {
        printf("Content-length: %lu\r\n", [rawData length]);
    } else {
        printf("Content-length: %d\r\n", [contentLength intValue]);
    }
    
    // additional headers if they exist.
    
    printf("\r\n");
    
    if (rawData != nil)
    {
        unsigned char buff;
        int i;
        for (i = 0; i < [rawData length]; i++)
        {
            NSRange readRange = NSMakeRange(i, 1);
            [rawData getBytes:&buff range:readRange];
            printf("%c", buff);
        }
    } else {
        printf("%s", [content cStringUsingEncoding:NSUTF8StringEncoding]);
    }
    
    printf("\r\n");
    printf("\r\n");
    
}

- (void)redirect:(NSString *)url
{
    printf("HTTP/1.1 303 See Other\r\n");
    printf("Location: %s\r\n", [url cStringUsingEncoding:NSUTF8StringEncoding]);
    printf("Content-type: %s\r\n", [contentType cStringUsingEncoding:NSUTF8StringEncoding]);
    if (rawData != nil)
    {
        printf("Content-length: %lu\r\n", [rawData length]);
    } else {
        printf("Content-length: %d\r\n", [contentLength intValue]);
    }
    
    // additional headers if they exist.
    
    printf("\r\n");
    
    if (rawData != nil)
    {
        unsigned char buff;
        int i;
        for (i = 0; i < [rawData length]; i++)
        {
            NSRange readRange = NSMakeRange(i, 1);
            [rawData getBytes:&buff range:readRange];
            printf("%c", buff);
        }
    } else {
        printf("%s", [content cStringUsingEncoding:NSUTF8StringEncoding]);
    }
    
    printf("\r\n");
    printf("\r\n");
    
}

@end
