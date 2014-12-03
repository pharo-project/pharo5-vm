Author useAuthor: 'SpurBootstrap' during: [

"Add CompiledMethod variables"
CompiledMethod 
	addClassVarNamed: 'PrimaryBytecodeSetEncoderClass';
	addClassVarNamed: 'SecondaryBytecodeSetEncoderClass'.

"Add needed methods"
EncoderForV3PlusClosures class 
	compile: 'callPrimitiveCode
	^ 139'.

CompiledMethodTrailer compile: 'decodeTempsNamesQCompress
	self qDecompress'.

CompiledMethodTrailer compile: 'decodeTempsNamesZip
	self decodeZip'.

CompiledMethodTrailer compile: 'encodeTempsNamesQCompress
	self encodeUsingQCompress'.

CompiledMethodTrailer compile: 'encodeTempsNamesZip
	self encodeUsingZip'.

].
Smalltalk snapshot: true andQuit: true.
