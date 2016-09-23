#! /bin/bash

./image/pharo ./image/Pharo.image eval "
| json username password url currentMonth |

username := 'estebanlm'.
password := '$BINTRAY_API_KEY'.
url := 'https://api.bintray.com/packages/estebanlm/pharo-vm/build'.
currentMonth := Month current year 	* 100 + Month current index.

json := ZnClient new 
	username: username password: password;
	url: url;
	contentReader: [ :entity | STON fromString: entity contents ];
	get.

(json at: 'versions') 
	select: [ :each | (each first: 6) asInteger < currentMonth ] 
	thenDo: [ :each | | response newLine |
		newLine := Smalltalk platform lineEnding.
		response := ZnClient new 
			username: username password: password;
			url: (url, '/versions/', each);
			delete;
			response.
		response isSuccess
			ifTrue: [ VTermOutputDriver stdout green: 'Version ', each, ' deleted.', newLine ]
			ifFalse: [ VTermOutputDriver stdout red: 'Error while trying to remove ', each, '!', newLine ] ].
"