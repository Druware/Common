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
    var _errorCode : Int?;
    var _errorCondition : String?;
    var _exitStatus : Int;
    
    public init(request : Request) {
        _request = request;
        _exitStatus = 0;
        
        print("");
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
    
    public func dictionaryForError() -> Dictionary<String, AnyObject> {
        var child : Dictionary<String, String> = Dictionary<String, String>();
        var this : Dictionary<String, AnyObject> = Dictionary<String, AnyObject>();
        
        child["errorCode"] = String(_errorCode!);
        child["errorCondition"] = _errorCondition!;
        this["error"] = child;
    
        return this;
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
        print("1");
        
        // for the moment, we are sending plain text
        _request.response.contentType = "text/plain";
        
        // no parameters, *, or all passed in
        var parameter : String?;
        parameter = nil;
        var shouldShowAll : Bool = false;
        if (_request.parameters == nil) {
            shouldShowAll = true;
        } else {
            print("debug: param count \(_request.parameters!.count)");
            if (_request.parameters!.count > 0) {
                parameter = _request.parameters![0];
            }
            
            shouldShowAll = (parameter == nil);
            if (shouldShowAll == false) {
                shouldShowAll = (parameter == "");
            }
            if (shouldShowAll == false) {
                shouldShowAll = (parameter == "*");
            }
            if (shouldShowAll == false) {
                shouldShowAll = (parameter == "all");
            }
        }
        
        
        print("debug: shouldShowAll \(shouldShowAll)");
        if (shouldShowAll == true) {
            // move the environment variables into a JSON conforming object
            var dictionary : Dictionary<String, AnyObject> = Dictionary<String, AnyObject>();
            for (keyName, _) in _request.server.allVariables() {
                if let value = _request.server.allVariables()[keyName] {
                    dictionary[keyName] = value;
                }
            }
            
            // show all
            
            // for the moment, just send it as text, but this should format 
            // the entire thing in a properly formed JSON object.
            let json : String = CreateJSONFromObject(dictionary);
            _request.response.content = json;
            
            
        } else {
            var dictionary : Dictionary<String, AnyObject> = Dictionary<String, AnyObject>();
            if let value = _request.server.allVariables()[_request.parameters![0]] {
                dictionary[_request.parameters![0]] = value;
            }
            
            // show all
            
            // for the moment, just send it as text, but this should format
            // the entire thing in a properly formed JSON object.
            let json : String = CreateJSONFromObject(dictionary);
            _request.response.content = json;
        }
        
        
        _exitStatus = 0;
    }
    
    func CreateJSONFromObject(object: AnyObject, prettyPrinted:Bool = true) -> String {
        let options = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : NSJSONWritingOptions(rawValue: 0)
        
        
        if NSJSONSerialization.isValidJSONObject(object) {
            
            do{
                let data = try NSJSONSerialization.dataWithJSONObject(object, options: options)
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return string as String
                }
            }catch {
                
                print("error")
                //Access error here
            }
            
        }
        return ""
        
    }
    
    public var exitStatus : Int {
        get {
            return _exitStatus;
        }
    }
    
}
