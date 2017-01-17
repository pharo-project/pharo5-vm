debug support
okayInterpreterObjects

	| oopOrZero oop |
	self okayFields: nilObj.
	self okayFields: falseObj.
	self okayFields: trueObj.
	self okayFields: specialObjectsOop.
	self okayFields: activeContext.
	self okayFields: method.
	self okayFields: receiver.
	self okayFields: theHomeContext.
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
	1 to: remapBufferCount do: [ :i |
		oop := remapBuffer at: i.
		(self isIntegerObject: oop) ifFalse: [
			self okayFields: oop.
		].
	].
	self okayActiveProcessStack.