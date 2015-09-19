//
//  OGREWebServer.m
//  OGRE.Server.Web
//
//  Created by Andy Satori on 9/18/15.
//  Copyright © 2015 O.G.R.E. All rights reserved.
//

#import "OGREWebServer.h"

@implementation OGREWebServer

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
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        // DOCUMENT_ROOT	The root directory of your server
        [self addEnvironmentVariable:"DOCUMENT_ROOT" toDictionary:dict];
        
        // HTTP_COOKIE	The visitor's cookie, if one is set
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("HTTP_COOKIE")]
                 forKey:@"HTTP_COOKIE"];
        
        NSString *cookie = [NSString stringWithFormat:@"%s", getenv("HTTP_COOKIE")];
        NSLog(@"Cookies: %@", cookie);
        
        // parse the cookies into something usable.  Cookies are 'key/value/expiration/domain'
        
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
        [self addEnvironmentVariable:"REQUEST_URI" toDictionary:dict];
        
        // SCRIPT_FILENAME	The full pathname of the current CGI
        [dict setObject:[NSString stringWithFormat:@"%s", getenv("SCRIPT_FILENAME")]
                 forKey:@"SCRIPT_FILENAME"];
        // SCRIPT_NAME	The interpreted pathname of the current CGI (relative to the document root)
        [self addEnvironmentVariable:"SCRIPT_NAME" toDictionary:dict];
        
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
        
        // if the file exists, load it and go.
#ifdef DEBUG
        NSLog(@"Looking for preferences file");
#endif
        if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/Preferences/com.ogre.server.preferences.plist"])
        {
#ifdef DEBUG
            NSLog(@"Found for preferences file at /Library/Preferences/com.ogre.server.preferences.plist");
#endif
            NSDictionary *prefs;
            prefs = [[NSDictionary alloc] initWithContentsOfFile:@"/Library/Preferences/com.ogre.server.preferences.plist"];
            
            // look for a dictionary corresponding to the host name,
            // if it is not found, then move to the 'default' record
            
            // get the 'hosts' array
            // enumerate the hosts array looking for the dictionary for the
            // passed in host name ( from the server object itself )
            NSArray *allHosts = [prefs objectForKey:@"hosts"];
            NSDictionary *defaultDict = nil;
            _preferences = nil;
            
            NSLog(@"All Hosts: %@", allHosts);
            NSLog(@"Host Count: %ld", [allHosts count]);
            for (int i =0; i < [allHosts count]; i++)
            {
                NSDictionary *currentHost = [allHosts objectAtIndex:i];
                
                NSLog(@"This hostName: %@", [currentHost objectForKey:@"hostName"]);
                
                if ([[currentHost objectForKey:@"hostName"] isEqualToString:@"(default)"])
                {
#ifdef DEBUG
                    NSLog(@"Using default preferences");
#endif
                    defaultDict = [allHosts objectAtIndex:i];
                }
                
                if ([[currentHost objectForKey:@"hostName"] isEqualToString:[_environment objectForKey:@"HTTP_HOST"]])
                {
#ifdef DEBUG
                    NSLog(@"Using preferences for %@", [_environment objectForKey:@"HTTP_HOST"]);
#endif
                    _preferences = [allHosts objectAtIndex:i];
                }
            }
            
            if (_preferences == nil) { _preferences = [[NSDictionary alloc] initWithDictionary:defaultDict]; }
        }
        NSLog(@"Server OBject Created");
    }
    return self;
}

#pragma mark -
#pragma mark accessors

- (NSDictionary *)environment
{
    return [[NSDictionary alloc] initWithDictionary:_environment];
}

- (NSString *)scriptName
{
    return [_environment objectForKey:@"SCRIPT_NAME"];
}

- (NSString *)requestUri
{
    return [_environment objectForKey:@"REQUEST_URI"];
}

// prefences

- (NSDictionary *)preferences
{
    if (_preferences != nil)
    {
        return _preferences;
    } else {
        return nil;
    }
}

@end
