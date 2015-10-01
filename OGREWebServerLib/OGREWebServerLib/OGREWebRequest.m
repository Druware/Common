//
//  OGREWebRequest.m
//  OGRE.Server.Web
//
//  Created by Andy Satori on 9/18/15.
//  Copyright © 2015 O.G.R.E. All rights reserved.
//

#import "OGREWebRequest.h"

@implementation OGREWebRequest

@synthesize parameters, host, userAgent, referer, method, response, form, queryString,
    remoteAddress;
@dynamic server;

- (BOOL)addEnvironmentVariable:(const char *)name toDictionary:(NSMutableDictionary *)dict
{
    NSString *envName;
    envName = [NSString stringWithFormat:@"%s", name];
    NSString *envVariable;
    envVariable = [NSString stringWithFormat:@"%s", getenv(name)];
    
    // make sure the envVariable is not NULL
    if ([envVariable caseInsensitiveCompare:@"(null)"] != NSOrderedSame)
    {
        [dict setObject:envVariable forKey:envName];
        return YES;
    }
    
    return NO;
}

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        response = [[OGREWebResponse alloc] init];
        host = [[NSString alloc] initWithFormat:@"%s", getenv("HTTP_HOST")];
        userAgent = [[NSString alloc] initWithFormat:@"%s", getenv("HTTP_USER_AGENT")];
        referer = [[NSString alloc] initWithFormat:@"%s", getenv("HTTP_REFERER")];
        method = [[NSString alloc] initWithFormat:@"%s", getenv("REQUEST_METHOD")];
        remoteAddress = [[NSString alloc] initWithFormat:@"%s", getenv("REMOTE_ADDR")];
        form = nil;
        queryString = nil;
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        // DOCUMENT_ROOT	The root directory of your server
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("DOCUMENT_ROOT")]
                 forKey:@"DOCUMENT_ROOT"];
        // HTTP_COOKIE	The visitor's cookie, if one is set
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("HTTP_COOKIE")]
                 forKey:@"HTTP_COOKIE"];
        // HTTP_HOST	The hostname of the page being attempted
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("HTTP_HOST")]
                 forKey:@"HTTP_HOST"];
        // HTTP_REFERER	The URL of the page that called your program
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("HTTP_REFERER")]
                 forKey:@"HTTP_REFERER"];
        // HTTP_USER_AGENT	The browser type of the visitor
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("HTTP_USER_AGENT")]
                 forKey:@"HTTP_USER_AGENT"];
        // HTTPS	"on" if the program is being called through a secure server
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("HTTPS")]
                 forKey:@"HTTPS"];
        // PATH	The system path your server is running under
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("PATH")]
                 forKey:@"PATH"];
        // QUERY_STRING	The query string (see GET, below)
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("QUERY_STRING")]
                 forKey:@"QUERY_STRING"];
        // REMOTE_ADDR	The IP address of the visitor
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("REMOTE_ADDR")]
                 forKey:@"REMOTE_ADDR"];
        // REMOTE_HOST	The hostname of the visitor (if your server has reverse-name-lookups on; otherwise this is the IP address again)
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("REMOTE_HOST")]
                 forKey:@"REMOTE_HOST"];
        // REMOTE_PORT	The port the visitor is connected to on the web server
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("REMOTE_PORT")]
                 forKey:@"REMOTE_PORT"];
        // REMOTE_USER	The visitor's username (for .htaccess-protected pages)
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("REMOTE_USER")]
                 forKey:@"REMOTE_USER"];
        // REQUEST_METHOD	GET or POST
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("REQUEST_METHOD")]
                 forKey:@"REQUEST_METHOD"];
        // REQUEST_URI	The interpreted pathname of the requested document or CGI (relative to the document root)
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("REQUEST_URI")]
                 forKey:@"REQUEST_URI"];
        // SCRIPT_FILENAME	The full pathname of the current CGI
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("SCRIPT_FILENAME")]
                 forKey:@"SCRIPT_FILENAME"];
        // SCRIPT_NAME	The interpreted pathname of the current CGI (relative to the document root)
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("SCRIPT_NAME")]
                 forKey:@"SCRIPT_NAME"];
        // SERVER_ADMIN	The email address for your server's webmaster
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("SERVER_ADMIN")]
                 forKey:@"SERVER_ADMIN"];
        // SERVER_NAME	Your server's fully qualified domain name (e.g. www.cgi101.com)
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("SERVER_NAME")]
                 forKey:@"SERVER_NAME"];
        // SERVER_PORT	The port number your server is listening on
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("SERVER_PORT")]
                 forKey:@"SERVER_PORT"];
        // SERVER_SOFTWARE	The server software you're using (e.g. Apache 1.3)
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("SERVER_SOFTWARE")]
                 forKey:@"SERVER_SOFTWARE"];
        
        _environment = [[NSMutableDictionary alloc] initWithDictionary:dict];
        
        // read any posted form data if it exists:
        
        if ([method isEqualToString:@"POST"])
        {
            NSMutableDictionary *tempForm = [[NSMutableDictionary alloc] init];
            
            NSFileHandle *input = [NSFileHandle fileHandleWithStandardInput];
            NSData *inputData = [NSData dataWithData:[input readDataToEndOfFile]];
            NSString *inputString = [[NSString alloc] initWithData:inputData encoding:NSUTF8StringEncoding];
            
            // at the moment, this appears to be the choke point, the data is
            // not apparently making it into the form data element.
            
            NSArray *allPairs = [inputString componentsSeparatedByString:@"&"];
            int i;
            for (i = 0; i < [allPairs count]; i++)
            {
                NSArray *thisPair = [[allPairs objectAtIndex:i] componentsSeparatedByString:@"="];
                NSLog(@"KEY: %@ VALUE: %@", [thisPair objectAtIndex:0], [thisPair objectAtIndex:1]);
                [tempForm setObject:[thisPair objectAtIndex:1] forKey:[thisPair objectAtIndex:0]];
            }
            form = [[NSDictionary alloc] initWithDictionary:tempForm];
            
            NSLog(@"POST DATA:%@", inputString);
        }
        
        
        // parse the query string into it's elements
        if ([[_environment objectForKey:@"QUERY_STRING"] length] > 0)
        {
            NSMutableDictionary *tempData = [[NSMutableDictionary alloc] init];
            
            NSString *inputString = [_environment objectForKey:@"QUERY_STRING"];
            
            NSArray *allPairs = [inputString componentsSeparatedByString:@"&"];
            int i;
            for (i = 0; i < [allPairs count]; i++)
            {
                if ([[allPairs objectAtIndex:i] containsString:@"="])
                {
                    NSArray *thisPair = [[allPairs objectAtIndex:i] componentsSeparatedByString:@"="];
                    NSLog(@"KEY: %@ VALUE: %@", [thisPair objectAtIndex:0], [thisPair objectAtIndex:1]);
                    [tempData setObject:[thisPair objectAtIndex:1] forKey:[thisPair objectAtIndex:0]];
                }
            }
            queryString = [[NSDictionary alloc] initWithDictionary:tempData];
            
            NSLog(@"QueryString DATA:%@", inputString);
        }
    }
    return self; 
}

- (void)dealloc
{
    // 	[super dealloc];
}

#pragma mark custom accessors / property overrides

- (OGREWebServer *)server
{
    return server;
}

- (void)setServer:(OGREWebServer *)value
{
    server = value;
    if ([[server requestUri] length] > 0)
    {
        if ([[server requestUri] length] > [[server scriptName] length])
        {
            NSRange queryStringRange = [[server requestUri] rangeOfString:@"?" options:NSBackwardsSearch];
            
            
            NSString *paramString;
            if (queryStringRange.location == NSNotFound)
            {
                paramString = [[server requestUri] substringFromIndex:[[server scriptName] length] + 1];
            } else {
                paramString = [[server requestUri] substringWithRange:NSMakeRange(
                                                                                  [[server scriptName] length] + 1, queryStringRange.location - [[server scriptName] length] - 1)];
            }
            NSLog(@"DEBUG: paramString = %@", paramString);
            
            parameters = [paramString componentsSeparatedByString:@"/"];
        }
        
        
    }
}

@end
