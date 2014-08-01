utilities
bootstrapPharoImage: imageFileBaseName
	| oldCompilerClass |
	
	oldCompilerClass := SmalltalkImage compilerClass.
	[ 
		SmalltalkImage compilerClass: Compiler. 
		self bootstrapImage: imageFileBaseName type: 'pharo' ]
	ensure: [ SmalltalkImage compilerClass: oldCompilerClass ].
	