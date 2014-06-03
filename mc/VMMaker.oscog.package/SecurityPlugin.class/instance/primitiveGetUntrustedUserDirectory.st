primitives
primitiveGetUntrustedUserDirectory
	"Primitive. Return the untrusted user directory name."
	| dirName dirLen dirOop dirPtr |
	<export: true>
	<var: #dirName type: 'char *'>
	<var: #dirPtr type: 'char *'>
	dirName := self cCode:'ioGetUntrustedUserDirectory()' inSmalltalk:[nil].
	(dirName == nil or:[interpreterProxy failed]) 
		ifTrue:[^interpreterProxy primitiveFail].
	dirLen := self strlen: dirName.
	dirOop := interpreterProxy instantiateClass: interpreterProxy classString indexableSize: dirLen.
	interpreterProxy failed ifTrue:[^nil].
	dirPtr := interpreterProxy firstIndexableField: dirOop.
	0 to: dirLen-1 do:[:i|
		dirPtr at: i put: (dirName at: i)].
	interpreterProxy pop: 1 thenPush: dirOop.