I/O primitives
primitiveClipboardText
	"When called with a single string argument, post the string to 
	the clipboard. When called with zero arguments, return a 
	string containing the current clipboard contents."
	| s sz |
	argumentCount = 1
		ifTrue: [s := self stackTop.
			(objectMemory isBytes: s) ifFalse: [^ self primitiveFail].
			self successful
				ifTrue: [sz := self stSizeOf: s.
					self clipboardWrite: sz From: s + BaseHeaderSize At: 0.
					self pop: 1]]
		ifFalse: [sz := self clipboardSize.
			(objectMemory sufficientSpaceToAllocate: sz) ifFalse:[^self primitiveFail].
			s := objectMemory instantiateClass: (objectMemory splObj: ClassByteString) indexableSize: sz.
			self clipboardRead: sz Into: s + BaseHeaderSize At: 0.
			self pop: 1 thenPush: s]