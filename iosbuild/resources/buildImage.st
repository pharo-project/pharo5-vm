"Installation"
Gofer it 
	squeaksource: 'iPhone';
	package: 'ConfigurationOfIPhone';
	load.
(Smalltalk at: #ConfigurationOfIPhone) load.

SmalltalkImage checkSourcesFileAvailability: false.
SmalltalkImage checkChangesFileAvailability: false.

"Start a demo server"
(ZnServer startDefaultOn: 8080) 
	onRequestRespond: [ :request | 
		ZnResponse ok: (ZnEntity text: 'Welcome.

This text has been served by Pharo running locally in your device or simulator. 

- Execute "UIApplicationLauncher url: ''http://myUrl:myPort''" to point the UIWebView to your jQueryMobile Seaside application. 
- Execute "UIApplicationLauncher register" to ensure the launcher is in the startup sequence.

(And of course, you need to load your application into this image :)') ]. 

"Stop the demo server"

"ZnServer stopDefault. "

UIApplicationLauncher 
	url: 'http://localhost:8080';
	register.
	
Smalltalk snapshot: true andQuit: true.