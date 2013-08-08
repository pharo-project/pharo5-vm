scripts generation
loaderScript

"
Gofer new
	squeaksource: 'MetacelloRepository';
	package: 'ConfigurationOfCog';
	load.
	
((Smalltalk at: #ConfigurationOfCog) project
	version: '1.7') load.

(Smalltalk saveAs: 'generator.image') ifFalse: [
				 Smalltalk snapshot: false andQuit: true]
"

" i put it into comment to avoid double quoting "

^  thisContext  method methodNode comment first

