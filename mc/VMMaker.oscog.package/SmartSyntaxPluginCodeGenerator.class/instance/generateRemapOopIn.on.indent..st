translating builtins
generateRemapOopIn: aNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| idList |
	pluginFunctionsUsed add: #pushRemappableOop:; add: #popRemappableOop.
	idList := aNode args first nameOrValue.
	idList class == Array ifFalse: [idList := Array with: idList].
	idList do:
		[:each | 
		 aStream 
			nextPutAll: 'pushRemappableOop(';
			nextPutAll: each asString;
			nextPutAll: ');']
		separatedBy: [aStream crtab: level].
	aStream cr.
	aNode args second emitCCodeOn: aStream level: level generator: self.
	level timesRepeat: [aStream tab].
	idList reversed do:
		[:each |
		 aStream 
			nextPutAll: each asString;
			nextPutAll: ' = popRemappableOop()']
		separatedBy: [aStream nextPut: $;; crtab: level].