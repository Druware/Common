//
//  CGIServer.swift
//  CGIScript
//
//  Created by Andy Satori on 12/21/15.
//  Copyright © 2015 Druware Software Designs. All rights reserved.
//

import Foundation

public class Server {
    var httpAcceptLanguage : String?
    var httpHost : String?;
    var httpConnection : String?;
    var httpAcceptEncoding : String?;
    var httpUserAgent : String?;
    
    var remoteAddress : String?;
    var remotePort : String?;
    
    
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
    
    var cookies : Dictionary<String, String?>;
    var environment : Dictionary<String, String?>;
    
    public init() {
        cookies = Dictionary<String, String?>();
        environment = Dictionary<String, String?>();
        for (keyName, _) in NSProcessInfo().environment {
            if let value = NSProcessInfo().environment[keyName] {
                environment[keyName] = value;
            }
        }
        
        // http

        self.httpAcceptLanguage = NSProcessInfo().environment["HTTP_ACCEPT_LANGUAGE"];
        self.httpHost = NSProcessInfo().environment["HTTP_HOST"];
        self.httpConnection = NSProcessInfo().environment["HTTP_CONNECTION"];
        self.httpAcceptEncoding = NSProcessInfo().environment["HTTP_ACCEPT_ENCODING"];
        self.httpUserAgent = NSProcessInfo().environment["HTTP_USER_AGENT"];

    
        // other
        self.remoteAddress = NSProcessInfo().environment["REMOTE_ADDR"];
        self.remotePort = NSProcessInfo().environment["REMOTE_PORT"];
        
        self.path = NSProcessInfo().environment["PATH"];
        self.pathInfo = NSProcessInfo().environment["PATH_INFO"];
        self.pathTranslated = NSProcessInfo().environment["PATH_TRANSLATED"];
        
        self.documentRoot = NSProcessInfo().environment["DOCUMENT_ROOT"];
        
        self.contextPrefix = NSProcessInfo().environment["CONTEXT_PREFIX"];
        self.contextDocumentRoot = NSProcessInfo().environment["CONTEXT_DOCUMENT_ROOT"];
        
        self.scriptFilename = NSProcessInfo().environment["SCRIPT_FILENAME"];
        
        self.requestMethod = NSProcessInfo().environment["REQUEST_METHOD GET"];
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
    
    // Server Properties
    
    public var serverName : String? {
        get {
            if (environment["SERVER_NAME"] == nil) {return nil};
            return environment["SERVER_NAME"]!;
        }
    }
    
    public var serverProtocol : String? {
        get {
            return environment["SERVER_PROTOCOL"]!;
        }
    }
    
    public var serverAddress : String? {
        get {
            return environment["SERVER_ADDR"]!;
        }
    }
    
    public var serverPort : String? {
        get {
            return environment["SERVER_PORT"]!;
        }
    }
    
    public var serverSoftware : String? {
        get {
            return environment["SERVER_SOFTWARE"]!;
        }
    }
    
    public var serverAdmin : String? {
        get {
            return environment["SERVER_ADMIN"]!;
        }
    }
    
    public var serverSignature : String? {
        get {
            return environment["SERVER_SIGNATURE"]!;
        }
    }
    
    // Script Information
    
    public var scriptName : String? {
        get {
            return environment["SCRIPT_NAME"]!;
        }
    }
    
    public var requestUri : String? {
        get {
            return environment["REQUEST_URI"]!;
        }
    }
    
    // General Server Tidbits
    
    public var httpAccept: String? {
        get {
            if (environment["HTTP_ACCEPT"] == nil) {return nil};
            return environment["HTTP_ACCEPT"]!;
        }
    }
    
    // Utility Bits
    
    public func allVariables() -> Dictionary<String, String?> {
        return environment;
    }
    
    public func variable(name: String) -> String? {
        return environment[name]!;
    }
}
