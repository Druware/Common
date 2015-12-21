//
//  CGIServer.swift
//  CGIScript
//
//  Created by Andy Satori on 12/21/15.
//  Copyright © 2015 Druware Software Designs. All rights reserved.
//

import Foundation

class WebServer {
    var httpAccept : String?;
    var httpAcceptLanguage : String?
    var httpHost : String?;
    var httpConnection : String?;
    var httpAcceptEncoding : String?;
    var httpUserAgent : String?;
    
    var remoteAddress : String?;
    var remotePort : String?;
    
    var serverName : String?;
    var serverProtocol : String?;
    var serverAddress : String?;
    var serverPort : String?;
    var serverSoftware : String?;
    var serverAdmin : String?;
    var serverSignature : String?;
    
    var path : String?;
    var pathInfo : String?;
    var pathTranslated : String?;
    
    var documentRoot : String?;
    
    var contextPrefix : String?;
    var contextDocumentRoot : String?;
    
    var requestMethod : String?;
    var requestScheme : String?;
    
    var queryString : String?;
    
    var gatewayInterface : String?;
    
    var scriptFilename : String?;
    var scriptName : String?;
    var requestUri : String?;
    
    var cookies : Dictionary<String, String?>;
    var environment : Dictionary<String, String?>;
    
    init() {
        cookies = Dictionary<String, String?>();
        environment = Dictionary<String, String?>();
        for (keyName, _) in NSProcessInfo().environment {
            if let value = NSProcessInfo().environment[keyName] {
                environment[keyName] = value;
            }
        }
        
        // http
        self.httpAccept = NSProcessInfo().environment["HTTP_ACCEPT"];
        self.httpAcceptLanguage = NSProcessInfo().environment["HTTP_ACCEPT_LANGUAGE"];
        self.httpHost = NSProcessInfo().environment["HTTP_HOST"];
        self.httpConnection = NSProcessInfo().environment["HTTP_CONNECTION"];
        self.httpAcceptEncoding = NSProcessInfo().environment["HTTP_ACCEPT_ENCODING"];
        self.httpUserAgent = NSProcessInfo().environment["HTTP_USER_AGENT"];
        
        // request
        
        // server
        
        self.serverName = NSProcessInfo().environment["SERVER_NAME"];
        self.serverProtocol = NSProcessInfo().environment["SERVER_PROTOCOL"];
        self.serverAddress = NSProcessInfo().environment["SERVER_ADDR"];
        self.serverName = NSProcessInfo().environment["SERVER_NAME"];
        self.serverProtocol = NSProcessInfo().environment["SERVER_PROTOCOL"];
        self.serverPort = NSProcessInfo().environment["SERVER_PORT"];
        self.serverSoftware = NSProcessInfo().environment["SERVER_SOFTWARE"];
        self.serverAdmin = NSProcessInfo().environment["SERVER_ADMIN"];
        self.serverSignature = NSProcessInfo().environment["SERVER_SIGNATURE"];
        
        // other
        self.remoteAddress = NSProcessInfo().environment["REMOTE_ADDR"];
        self.remotePort = NSProcessInfo().environment["REMOTE_PORT"];
        
        self.path = NSProcessInfo().environment["PATH"];
        self.pathInfo = NSProcessInfo().environment["PATH_INFO"];
        self.pathTranslated = NSProcessInfo().environment["PATH_TRANSLATED"];
        
        self.scriptName = NSProcessInfo().environment["SCRIPT_NAME"];
        
        self.documentRoot = NSProcessInfo().environment["DOCUMENT_ROOT"];
        
        self.contextPrefix = NSProcessInfo().environment["CONTEXT_PREFIX"];
        self.contextDocumentRoot = NSProcessInfo().environment["CONTEXT_DOCUMENT_ROOT"];
        
        self.scriptFilename = NSProcessInfo().environment["SCRIPT_FILENAME"];
        
        self.requestMethod = NSProcessInfo().environment["REQUEST_METHOD GET"];
        self.requestUri = NSProcessInfo().environment["REQUEST_URI"];
        self.requestScheme = NSProcessInfo().environment["REQUEST_SCHEME"];
        
        self.queryString = NSProcessInfo().environment["QUERY_STRING"];
        
        self.gatewayInterface = NSProcessInfo().environment["GATEWAY_INTERFACE"];
        
        /*
        
        HTTP_X_APPLE_SERVICE_PROFILE_MANAGER_ENABLED true
        HTTP_X_APPLE_SERVICE_WEBCALSSL_ENABLED true
        HTTP_X_FORWARDED_FOR ::1
        HTTP_X_FORWARDED_PORT 80
        HTTP_X_FORWARDED_SERVER 127.0.0.1
        HTTP_X_FORWARDED_PROTO http
        HTTP_X_FORWARDED_HOST localhost
        */
    }
}

class WebRequest {
    
}

class WebResponse {
    
}

class Cookie {
    
}