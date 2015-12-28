//
//  CGIRequest.swift
//  CGIScript
//
//  Created by Andy Satori on 12/21/15.
//  Copyright © 2015 Druware Software Designs. All rights reserved.
//

import Foundation

public class Request {
    var _server : Server;
    var _response : Response?;
    
    var _parameters : [String]?;
    var _queryString : Dictionary<String, String>?;
    var _form : Dictionary<String, String>?;
    
    //var data : NSData?; // or maybe [UInt8] instead ?
    
    public init(server : Server? = nil) {
        // setup the members
        if (server != nil) {
            _server = server!;
        } else {
            _server = Server();
        }
        
        _response = Response();
        _form = nil;
        _queryString = nil;
        
        // parse the query string into it's elements
        let qs : String? = _server.variable("QUERY_STRING");
        if (qs! != "") {
            _queryString = Dictionary<String, String>();

            let keyValuePairs : [String] = (qs?.componentsSeparatedByString("&"))!;
            for (var i : Int = 0; i < keyValuePairs.count; i++) {
            
                if (keyValuePairs[i].containsString("="))
                {
                    let keyValuePair : [String] = keyValuePairs[i].componentsSeparatedByString("=");
                    _queryString![keyValuePair[0]] = keyValuePair[1];
                }
            }
        }

        // parameters = nil;
        let paramString : String = (_server.requestUri?.componentsSeparatedByString("&")[0].componentsSeparatedByString(_server.scriptName!)[1])!;
        _parameters = paramString.componentsSeparatedByString("/");
        
        // form = nil;
        if (_server.requestMethod == "POST") {
            _form = Dictionary<String, String>();
            let input = NSFileHandle.fileHandleWithStandardInput();
            let data : NSData = input.readDataToEndOfFile();
            let dataAsString = NSString(data: data,encoding: NSUTF8StringEncoding);
            
            let keyValuePairs : [String] = (dataAsString?.componentsSeparatedByString("&"))!;
            for (var i : Int = 0; i < keyValuePairs.count; i++) {
                
                if (keyValuePairs[i].containsString("="))
                {
                    let keyValuePair : [String] = keyValuePairs[i].componentsSeparatedByString("=");
                    _form![keyValuePair[0]] = keyValuePair[1];
                }
            }
            
        }
    }
    
    public var host : String? {
        get {
            if (_server.httpHost == nil) {return nil};
            return _server.httpHost;
        }
    }
    
    public var userAgent : String? {
        get {
            if (_server.httpUserAgent == nil) {return nil};
            return _server.httpUserAgent;
        }
    }
    
    public var referer : String? {
        get {
            if (_server.variable("HTTP_REFERER") == nil) {return nil};
            return _server.variable("HTTP_REFERER");
        }
    }

    public var accept : String? {
        get {
            if (_server.httpAccept == nil) {return nil};
            return _server.httpAccept;
        }
    }
    
    public var method : String? {
        get {
            if (_server.requestMethod == nil) {return nil};
            return _server.requestMethod;
        }
    }
    
    public var remoteAddress : String? {
        get {
            if (_server.remoteAddress == nil) {return nil};
            return _server.remoteAddress;
        }
    }
    
    // form
    public var form : Dictionary<String, String>? {
        get {
            if (_form == nil) {return nil};
            return _form;
        }
    }
    
    public var queryString : Dictionary<String, String>? {
        get {
            if (_queryString == nil) {return nil};
            return _queryString;
        }
    }
    
    public var parameters : [String]? {
        get {
            if (_parameters == nil) {return nil};
            return _parameters;
        }
    }
    
    public var response : Response {
        get {
            if (_response == nil) {
                _response = Response();
            }
            return _response!;
        }
    }
    
    public var server : Server {
        get {
            return _server;
        }
    }
}