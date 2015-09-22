primitives
"cpuAlien <GdbARMAlien>" primitiveDisassembleAt: address "<Integer>" InMemory: memory "<Bitmap|ByteArray|WordArray>"
	"Return an Array of the instruction length and its decompilation as a string for the instruction at address in memory."
	| cpuAlien cpu instrLenOrErr resultObj log logLen logObj logObjData |
	<var: #cpu type: #'void *'>
	cpuAlien := self primitive: #primitiveDisassembleAtInMemory
					parameters: #(Unsigned WordsOrBytes)
					receiver: #Oop.
	(cpu := self startOfData: cpuAlien) = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	instrLenOrErr := self disassembleFor: cpu
						At: address
						In: memory
						Size: (interpreterProxy byteSizeOf: memory cPtrAsOop).
	instrLenOrErr < 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrInappropriate].
	log := self getlog: (self cCode: [self addressOf: logLen] inSmalltalk: [logLen := 0]).
	resultObj := interpreterProxy instantiateClass: interpreterProxy classArray indexableSize: 2.
	resultObj = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoMemory].

	"Easier keeping the damn thing on the stack than using pushRemappableOop:/popRemappableOop.
	 Where is topRemappableOop when you need it?"
	interpreterProxy pushRemappableOop: resultObj.
	logObj := interpreterProxy
				instantiateClass: interpreterProxy classString
				indexableSize: logLen.
	interpreterProxy failed ifTrue:
		[interpreterProxy popRemappableOop.
		 ^interpreterProxy primitiveFailFor: PrimErrNoMemory].
	logObjData := interpreterProxy arrayValueOf: logObj.
	self mem: logObjData cp: log y: logLen.
	resultObj := interpreterProxy popRemappableOop.
	interpreterProxy
		storePointer: 0
		ofObject: resultObj
		withValue: (interpreterProxy integerObjectOf: instrLenOrErr).
	interpreterProxy storePointer: 1 ofObject: resultObj withValue: logObj.

	^resultObj