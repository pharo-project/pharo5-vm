initialization
moveMethodCacheToMemoryAt: address
	| oldMethodCache |
	oldMethodCache := methodCache.
	"In the VM the methodCache is written as a normal array with 1-relative addressing.
	 In C this works by allocating an extra element in the methodCache array (see
	 class-side declareCVarsIn:).  In simulation simply position the start of the methodCache
	 one word lower, achieving the same effect.  -1 because CArrayAccessor is 0-relative
	 and adds 1 on accesses itself."
	methodCache := CMethodCacheAccessor new
						objectMemory: objectMemory
						at: address
						array: oldMethodCache
						functionPointerIndex: MethodCachePrimFunction
						entrySize: MethodCacheEntrySize.
	self assert: address - objectMemory wordSize = self methodCacheAddress.
	1 to: MethodCacheSize do:
		[:i|
		self assert: (methodCache at: i) = 0].
	methodCache at: 1 put: 16rC4EC4.
	self assert: (objectMemory longAt: address) = 16rC4EC4.
	1 to: MethodCacheSize do:
		[:i|
		methodCache at: i put: (oldMethodCache at: i)]