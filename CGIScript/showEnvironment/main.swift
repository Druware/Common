//
//  main.swift
//  showEnvironment
//
//  Created by Andy Satori on 12/21/15.
//  Copyright © 2015 Druware Software Designs. All rights reserved.
//

import Foundation
import CGIScript

print("Content-type: text/plain\r\n\r\n");

//
let server = Server();

print("-- Server --");
print("Server Name: \(server.serverName)");
print("Server Protocol: \(server.serverProtocol)");
print("Server Address: \(server.serverAddress)");
print("Server Port: \(server.serverPort)");
print("Server Software: \(server.serverSoftware)");
print("Server Admin: \(server.serverAdmin)");
print("Server Signature: \(server.serverSignature)");
print("\r\n");

print("-- Request --");
/*
print("HTTP Accept: \(server.httpAccept)");
print("HTTP Accept Language: \(server.httpAcceptLanguage)");
print("HTTP Host: \(server.httpHost)");
print("HTTP Connection: \(server.httpConnection)");
print("HTTP Accept Encoding: \(server.httpAcceptEncoding)");
print("HTTP User Agent: \(server.httpUserAgent)");
print("\r\n");

print("-- Request --");
print("Server Signature: \(server.remoteAddress)");
print("Server Signature: \(server.remotePort)");
print("Server Signature: \(server.requestMethod)");
print("Server Signature: \(server.requestUri)");
print("Server Signature: \(server.requestScheme)");

print("Server Signature: \(server.queryString)");

print("Server Signature: \(server.path)");
print("Server Signature: \(server.pathInfo)");
print("Server Signature: \(server.pathTranslated)");
*/

print("Script Name: \(server.scriptName)");
print("\r\n");


print("-- Other --");

/*print("Server Signature: \(server.documentRoot)");

print("Server Signature: \(server.contextPrefix)");
print("Server Signature: \(server.contextDocumentRoot)");

print("Server Signature: \(server.scriptFilename)");

print("Server Signature: \(server.gatewayInterface)");
*/

print("\r\n");

print("- ALL Environment Variables -");

for (keyName, varName) in server.allVariables() {
    if var value = server.allVariables()[keyName] {
        print(keyName, value)
    }
}

// complete the request
print("\r\n");

