C translation
generateV3RemapOopIn: aNode on: aStream indent: level
	"Generate call on remapOop: for the variable oopOrList (or all of the
	 variables in oopOrList) before evaluating aBlock, and restore them after.
	 This keeps the oops valid if, as V3 will, there is a GC on allocation."

	| idList |
	pluginFunctionsUsed add: #pushRemappableOop:; add: #popRemappableOop.
	idList := aNode args first nameOrValue.
	idList class == Array ifFalse: [idList := Array with: idList].
	idList do:
		[:each | 
		 aStream
			tab: level;
			nextPutAll: 'pushRemappableOop(';
			nextPutAll: each asString;
			nextPutAll: ');']
		separatedBy: [aStream cr].
	aStream cr.
	aNode args second emitCCodeOn: aStream level: level generator: self.
	level timesRepeat: [aStream tab].
	idList reversed do:
		[:each |
		 aStream 
			nextPutAll: each asString;
			nextPutAll: ' = popRemappableOop()']
		separatedBy: [aStream nextPut: $;; crtab: level]