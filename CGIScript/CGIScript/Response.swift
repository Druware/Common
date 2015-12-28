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
    var headers : [String];          // ro
    var content : String?;			// rw
    var rawData : [UInt8]?;			// rw
    
    
    public init() {
        // setup the members
        _contentType = "text/xml";
        contentLength = 0;
        headers = [];
        content = "";
        rawData = nil;
    }
  
    public func write() {
        print("Content-type: \(_contentType)");
        if (rawData != nil) {
            print("Content-length: \(rawData!.count)");
        } else {
            print ("Content-length: \(content?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))");
        }
        // handle any extra headers we might have
        for (var i : Int = 0; i < headers.count; i++)
        {
            print("\(headers[i])\r");
        }
        
        print("");
        
        print("test");
        /*

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
        
*/
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
        
        // additional headers if they exist.
        for (var i : Int = 0; i < headers.count; i++)
        {
            print("\(headers[i])");
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
        } else if (content != nil) {
            print("\(content!.cStringUsingEncoding(NSUTF8StringEncoding))");
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
    
/*
    @property (copy) NSNumber *contentLength;
    @property (copy, readonly) NSMutableArray *headers;
    @property (copy) NSString *content;
    @property (copy) NSData *rawData;
*/
}