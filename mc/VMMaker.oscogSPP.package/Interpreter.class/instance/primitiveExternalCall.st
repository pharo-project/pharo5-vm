plugin primitives
primitiveExternalCall
	"Call an external primitive. The external primitive methods 
	contain as first literal an array consisting of: 
	* The module name (String | Symbol) 
	* The function name (String | Symbol) 
	* The session ID (SmallInteger) [OBSOLETE] 
	* The function index (Integer) in the externalPrimitiveTable 
	For fast failures the primitive index of any method where the 
	external prim is not found is rewritten in the method cache 
	with zero. This allows for ultra fast responses as long as the 
	method stays in the cache. 
	The fast failure response relies on lkupClass being properly 
	set. This is done in 
	#addToMethodCacheSel:class:method:primIndex: to 
	compensate for execution of methods that are looked up in a 
	superclass (such as in primitivePerformAt). 
	With the latest modifications (e.g., actually flushing the 
	function addresses from the VM), the session ID is obsolete. 
	But for backward compatibility it is still kept around. Also, a 
	failed lookup is reported specially. If a method has been 
	looked up and not been found, the function address is stored 
	as -1 (e.g., the SmallInteger -1 to distinguish from 
	16rFFFFFFFF which may be returned from the lookup). 
	It is absolutely okay to remove the rewrite if we run into any 
	problems later on. It has an approximate speed difference of 
	30% per failed primitive call which may be noticable but if, 
	for any reasons, we run into problems (like with J3) we can 
	always remove the rewrite. 
	"
	| lit addr moduleName functionName moduleLength functionLength index |
	<var: #addr type: 'void *'>
	
	"Fetch the first literal of the method"
	self success: (self literalCountOf: newMethod) > 0. "@@: Could this be omitted for speed?!"
	successFlag ifFalse: [^ nil].

	lit := self literal: 0 ofMethod: newMethod. 
	"Check if it's an array of length 4"
	self success: ((self isArray: lit) and: [(self lengthOf: lit) = 4]).
	successFlag ifFalse: [^ nil].

	"Look at the function index in case it has been loaded before"
	index := self fetchPointer: 3 ofObject: lit.
	index := self checkedIntegerValueOf: index.
	successFlag ifFalse: [^ nil].
	"Check if we have already looked up the function and failed."
	index < 0
		ifTrue: ["Function address was not found in this session, 
			Rewrite the mcache entry with a zero primitive index."
			self
				rewriteMethodCacheSel: messageSelector
				class: lkupClass
				primIndex: 0.
			^ self success: false].

	"Try to call the function directly"
	(index > 0 and: [index <= MaxExternalPrimitiveTableSize])
		ifTrue: [addr := externalPrimitiveTable at: index - 1.
			addr ~= 0
				ifTrue: [self rewriteMethodCacheSel: messageSelector class: lkupClass primIndex: (1000 + index) primFunction: addr.
					self callExternalPrimitive: addr.
					^ nil].
			"if we get here, then an index to the external prim was 
			kept on the ST side although the underlying prim 
			table was already flushed"
			^ self primitiveFail].

	"Clean up session id and external primitive index"
	self storePointerUnchecked: 2 ofObject: lit withValue: ConstZero.
	self storePointerUnchecked: 3 ofObject: lit withValue: ConstZero.

	"The function has not been loaded yet. Fetch module and function name."
	moduleName := self fetchPointer: 0 ofObject: lit.
	moduleName = nilObj
		ifTrue: [moduleLength := 0]
		ifFalse: [self success: (self isBytes: moduleName).
				moduleLength := self lengthOf: moduleName.
				self cCode: '' inSmalltalk:
					[ (#('FloatArrayPlugin' 'Matrix2x3Plugin') includes: (self stringOf: moduleName))
						ifTrue: [moduleLength := 0  "Cause all of these to fail"]]].
	functionName := self fetchPointer: 1 ofObject: lit.
	self success: (self isBytes: functionName).
	functionLength := self lengthOf: functionName.
	successFlag ifFalse: [^ nil].

	addr := self ioLoadExternalFunction: functionName + self baseHeaderSize
				OfLength: functionLength
				FromModule: moduleName + self baseHeaderSize
				OfLength: moduleLength.
	addr = 0
		ifTrue: [index := -1]
		ifFalse: ["add the function to the external primitive table"
			index := self addToExternalPrimitiveTable: addr].
	self success: index >= 0.
	"Store the index (or -1 if failure) back in the literal"
	self storePointerUnchecked: 3 ofObject: lit withValue: (self integerObjectOf: index).

	"If the function has been successfully loaded process it"
	(successFlag and: [addr ~= 0])
		ifTrue: [self rewriteMethodCacheSel: messageSelector class: lkupClass primIndex: (1000 + index) primFunction: addr.
				self callExternalPrimitive: addr]
		ifFalse: ["Otherwise rewrite the primitive index"
			self
				rewriteMethodCacheSel: messageSelector
				class: lkupClass
				primIndex: 0]