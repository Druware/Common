//
//  main.swift
//  showEnvironment
//
//  Created by Andy Satori on 12/21/15.
//  Copyright © 2015 Druware Software Designs. All rights reserved.
//

import Foundation
import CGIScript

//print("Content-type: text/plain\r\n\r\n");

// Setup the Server
let server = Server();


// In this instance, we are running as a CGI, ratehr than using the fcgi 
// interface, so there is no need for the following
// while (FCGI_Accept() >= 0) {
//  ...
// }

let request = Request(server: server);

let restfulInterface : RESTfulEnvironment = RESTfulEnvironment(request: request);
if (restfulInterface.exitStatus > 0) {
    // presume this is an error condition, and notify the consumer of the error
    // in a properly formed JSON or XML stream according to your preference
}


