debug support
checkOkayInterpreterObjects: writeBack
	<api>
	| ok oopOrZero oop |
	ok := true.
	ok := ok & (self checkOkayFields: objectMemory nilObject).
	ok := ok & (self checkOkayFields: objectMemory falseObject).
	ok := ok & (self checkOkayFields: objectMemory trueObject).
	ok := ok & (self checkOkayFields: objectMemory specialObjectsOop).
	ok := ok & (self checkOkayFields: messageSelector).
	ok := ok & (self checkOkayFields: newMethod).
	ok := ok & (self checkOkayFields: lkupClass).
	0 to: MethodCacheEntries - 1 by: MethodCacheEntrySize do:
		[ :i |
		oopOrZero := methodCache at: i + MethodCacheSelector.
		oopOrZero = 0 ifFalse:
			[ok := ok & (self checkOkayFields: (methodCache at: i + MethodCacheSelector)).
			objectMemory hasSpurMemoryManagerAPI ifFalse:
				[ok := ok & (self checkOkayFields: (methodCache at: i + MethodCacheClass))].
			ok := ok & (self checkOkayFields: (methodCache at: i + MethodCacheMethod))]].
	1 to: objectMemory remapBufferCount do:
		[ :i |
		oop := objectMemory remapBuffer at: i.
		(objectMemory isImmediate: oop) ifFalse:
			[ok := ok & (self checkOkayFields: oop)]].
	ok := ok & (self checkOkayStackZone: writeBack).
	^ok