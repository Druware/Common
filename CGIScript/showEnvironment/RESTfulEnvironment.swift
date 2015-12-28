//
//  RESTfulEnvironment.swift
//  CGIScript
//
//  Created by Andy Satori on 12/27/15.
//  Copyright © 2015 Druware Software Designs. All rights reserved.
//

import Foundation
import CGIScript

public class RESTfulEnvironment {
    var _request : Request;
    var _exitStatus : Int;
    
    public init(request : Request) {
        _request = request;
        _exitStatus = 0;
        
        if (_request.method == "DELETE")
        {
            self.delete();
        } else if (_request.method == "PUT")
        {
           self.put();
        } else if (_request.method == "POST")
        {
            self.post();
        } else {
            self.get(); // this is the default
        }
        _request.response.write();
    }
    
    public func delete() {
        // delete. not valid in this implementation
    }
    
    public func put() {
        // update. not valid in this implementation
    }
    
    public func post() {
        // create. not valid in this implementation
        
        
    }
    
    public func get() {
        // read. all functionality is demonstrated here.
        
        // for the moment, we are sending plain text
        _request.response.contentType = "text/plain";
        
        // no parameters, *, or all passed in
        var parameter : String?;
        parameter = nil;
        var shouldShowAll : Bool = false;
        if (_request.parameters == nil) {
            shouldShowAll = true;
        } else {
            if (_request.parameters!.count > 0) {
                parameter = _request.parameters![0];
            }
            
            shouldShowAll = (parameter == nil);
            if (shouldShowAll == false) {
                shouldShowAll = (parameter == "*");
            }
            if (shouldShowAll == false) {
                shouldShowAll = (parameter == "all");
            }
        }
        
        if (shouldShowAll == true) {
            // show all
            
            // for the moment, just send it as text, but this should format 
            // the entire thing in a properly formed JSON object.
            for (keyName, _) in _request.server.allVariables() {
                if let value = _request.server.allVariables()[keyName] {
                    print(keyName, value)
                }
            }
            
        } else {
            // show the value for the parameter passed in (if it exists)
            
        }
        
    }
    
    public var exitStatus : Int {
        get {
            return _exitStatus;
        }
    }
    
}
