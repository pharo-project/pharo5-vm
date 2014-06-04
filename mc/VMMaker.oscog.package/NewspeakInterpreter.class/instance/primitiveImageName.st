other primitives
primitiveImageName
	"When called with a single string argument, record the string as the current image file name. When called with zero arguments, return a string containing the current image file name."

	| s sz sCRIfn okToRename |
	<var: #sCRIfn type: 'void *'>
	argumentCount = 1 ifTrue: [
		"If the security plugin can be loaded, use it to check for rename permission.
		If not, assume it's ok"
		sCRIfn := self ioLoadFunction: 'secCanRenameImage' From: 'SecurityPlugin'.
		sCRIfn ~= 0 ifTrue:[okToRename := self cCode:' ((sqInt (*)(void))sCRIfn)()'.
			okToRename ifFalse:[^self primitiveFail]].
		s := self stackTop.
		self assertClassOf: s is: (self splObj: ClassByteString).
		self successful ifTrue: [
			sz := self stSizeOf: s.
			self imageNamePut: (s + BaseHeaderSize) Length: sz.
			self pop: 1.  "pop s, leave rcvr on stack"
		].
	] ifFalse: [
		sz := self imageNameSize.
		s := self instantiateClass: (self splObj: ClassByteString) indexableSize: sz.
		self imageNameGet: (s + BaseHeaderSize) Length: sz.
		self pop: 1.  "rcvr"
		self push: s.
	].
