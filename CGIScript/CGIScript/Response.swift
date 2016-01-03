//
//  Response.swift
//  CGIScript
//
//  Created by Andy Satori on 12/21/15.
//  Copyright © 2015 Druware Software Designs. All rights reserved.
//

import Foundation

public class Response {
    var _contentType : String;		// rw
    var contentLength : Int32;      // rw
    var headers : [String]?;          // ro
    var _content : String?;			// rw
    var rawData : [UInt8]?;			// rw
    
    
    public init() {
        // setup the members
        _contentType = "text/xml";
        contentLength = 0;
        headers = nil;
        _content = nil;
        rawData = nil;
    }
  
    public func write() {
        print("");
        print("");
        print("Content-type: \(_contentType)");
        if (rawData != nil) {
            print("Content-length: \(rawData!.count)");
        } else if (_content != nil) {
            print ("Content-length: \(_content!.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))");
        }
        print("");
        print("");
        print("debug (headers): \(headers)");
        print("debug (content): \(_content)");
        print("");
        // handle any extra headers we might have
        if (headers != nil) {
            for (var i : Int = 0; i < headers!.count; i++) {
                print("\(headers![i])\r");
            }
        }
        // end of the headers
        print("");
        
        // print the content
        if (rawData != nil)
        {
/*            unsigned char buff;
            int i;
            for (i = 0; i < [rawData length]; i++)
            {
                NSRange readRange = NSMakeRange(i, 1);
                [rawData getBytes:&buff range:readRange];
                printf("%c", buff);
            }
*/
        } else if (_content != nil) {
            print("\(_content!)");
        }
    }

    public func redirect(url : String) {
        print("HTTP/1.1 303 See Other");
        print("Location: \(url.cStringUsingEncoding(NSUTF8StringEncoding))");
        print("Content-type: \(_contentType.cStringUsingEncoding(NSUTF8StringEncoding))");
        if (rawData != nil)
        {
            print("Content-length: \(rawData!.count)");
        } else {
            print("Content-length: \(contentLength)");
        }
        
        // additional headers if they exist
        if (headers != nil) {
            for (var i : Int = 0; i < headers!.count; i++) {
                print("\(headers![i])");
            }
        }
        
        // move to the content
        print("");
        
        if (rawData != nil)
        {
/*            unsigned char buff;
            int i;
            for (i = 0; i < [rawData length]; i++)
            {
                NSRange readRange = NSMakeRange(i, 1);
                [rawData getBytes:&buff range:readRange];
                print("%c", buff);
            }
*/
        } else if (_content != nil) {
            print("\(_content!.cStringUsingEncoding(NSUTF8StringEncoding))");
        }
    }
    
    public var contentType : String {
        get {
            return _contentType;
        }
        set(value) {
            _contentType = value;
        }
    }
    
    public var content : String {
        get {
            if (_content == nil) {
                _content = String();
            }
            return _content!;
        }
        set(value) {
            _content = value;
        }
    }
    
/*
    @property (copy) NSNumber *contentLength;
    @property (copy, readonly) NSMutableArray *headers;
    @property (copy) NSString *content;
    @property (copy) NSData *rawData;
*/
}