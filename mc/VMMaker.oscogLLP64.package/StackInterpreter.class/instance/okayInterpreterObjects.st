debug support
okayInterpreterObjects

	| oopOrZero oop |
	self okayFields: objectMemory nilObject.
	self okayFields: objectMemory falseObject.
	self okayFields: objectMemory trueObject.
	self okayFields: objectMemory specialObjectsOop.
	self okayFields: messageSelector.
	self okayFields: newMethod.
	self okayFields: lkupClass.
	0 to: MethodCacheEntries - 1 by: MethodCacheEntrySize do: [ :i |
		oopOrZero := methodCache at: i + MethodCacheSelector.
		oopOrZero = 0 ifFalse: [
			self okayFields: (methodCache at: i + MethodCacheSelector).
			self okayFields: (methodCache at: i + MethodCacheClass).
			self okayFields: (methodCache at: i + MethodCacheMethod).
		].
	].
	1 to: objectMemory remapBufferCount do: [ :i |
		oop := objectMemory remapBuffer at: i.
		(objectMemory isImmediate: oop) ifFalse: [
			self okayFields: oop.
		].
	].
	self okayStackZone.