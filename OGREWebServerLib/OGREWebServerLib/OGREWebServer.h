//
//  OGREWebServer.h
//  OGRE.Server.Web
//
//  Created by Andy Satori on 9/18/15.
//  Copyright © 2015 O.G.R.E. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OGREWebServer : NSObject
{
    NSDictionary *_environment;
    NSDictionary *_preferences;
    NSArray *_cookies;
    
    NSString *serverName;
    NSString *databaseName;
    NSString *sessionManagerUser;
    NSString *sessionManagerPass;
}

- (NSDictionary *)environment;
- (NSString *)scriptName;
- (NSString *)requestUri;

- (NSDictionary *)preferences;
@end
