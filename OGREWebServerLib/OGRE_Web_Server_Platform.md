# OGRE Web Server Platform

The OGRE Web Server Platform is our custom stack for handling web requets that allows us to do our development work on a platform that we enjoy working on, and allows us to control more of the stack. That said, the fact that it runs on OS X and leverages Objective C and Swift places some limits on the stack. We know that, but frankly, the limits that it imposes, well, if this ever gets big enough that they become a problem, then there are worse problems to have.

## Repository

The master repo for the source code is on Github, and can be found at: 

	https://github.com/WeAreOGRE/Common.git

## License

As strong advocates of Open Source, in it's purest sense, this code is released under the simplified BSD license in order to allow for the greatest flexiibity in adoption. In simple terms, You are welcome to use it so long as you keep the original copyright notice in place, and if something goes wrong in your usage of the software it is not our fault.

	Copyright (c) 2014-2015, Satori & Associates, Inc. DBA WeAreOGRE
	All rights reserved.
	
	Redistribution and use in source and binary forms, with or without
	modification, are permitted provided that the following conditions are met:
	
	* Redistributions of source code must retain the above copyright notice, this
	  list of conditions and the following disclaimer.
	  
	* Redistributions in binary form must reproduce the above copyright notice,
	  this list of conditions and the following disclaimer in the documentation
	  and/or other materials provided with the distribution.
	
	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
	DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
	FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
	DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
	SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
	CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
	OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
	OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

## Background

Born out of frustration with other tools, that shall remain nameless, this platform is evolutionary, not revolutionary. There are many things it could do, but doesn't. The short version is that it does what we need. When we find something we need it to do that it doesn't, it gets added. In it's original form, it was a .Framework, but that complicated the deployment, so over time we have altered it to be a static library. Yes, it increases the size of our executables and creates some redundant code, but deployment convenience wins over on disk efficiency.

## Implementation

This is all written in OBjective-C at the moment, as it's roots predate Swift by several years, however, as Swift supplants Objective-C, we do expect to slowly transition this platform to Swift as well. Many of the outward facing bits are already being done in Swift, but the underlying code you find in the WebServerLib remains Objective-C.

### Dependancies

In order to build OGREWebServerLib, or anything linked against it, the following libraries will need to be in place.

* libFCGI.a - expected in /usr/local ( /usr/local/lib & /usr/local/include )
* PGSQLKit.Framework - expected in /Library/Frameworks 
* A working PostgreSQL 8 or newer installation that can be accessed

## Installation

Our Web Server Platform is built to work using the CGI engine ( specifically the FastCGI library, though it is not a required element ). The plaform itself requires  database, an access layer and the scripts themselves set up for access within a web server that supports the use of CGI scripts. Though others will work, the documentation you will find here is designed around the installations provided by Apple in the Apple Server 5 tools.

### Configuration

The definition of the PostgreSQL connection is done in a .plist file stored in the system preferences: 

	Server Preferences: com.OGRE.Server.Preferences.plist in /Library/Preferences
	
There is a GUI tool for reading and writing the configuration. There is support for multiple connections based upon the host name used in the request from the web client.

#### OGRE Server Library Management

Initially this is simply a tool for configuring the Database connections by hostname.



