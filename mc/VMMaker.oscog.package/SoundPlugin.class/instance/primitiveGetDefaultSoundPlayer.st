primitives
primitiveGetDefaultSoundPlayer
	"Answer a String with the operating system name of the default output device, or nil"
	"no arguments"
	| cDeviceName sz newString newStringPtr |
	<export: true>
	<var: #cDeviceName type: 'char*'>
	<var: #newStringPtr type: 'char*'>

	"Parse arguments"
	interpreterProxy methodArgumentCount = 0 
		ifFalse:[^interpreterProxy primitiveFail].
	
	"Get the answer."
	cDeviceName := self cCode: 'getDefaultSoundPlayer()'.
	cDeviceName == 0 ifTrue: [
		^interpreterProxy pop: 1 thenPush: interpreterProxy nilObject
		].

	"Copy the answer to a Squeak String."
	sz :=  self cCode: 'strlen(cDeviceName)'.
	newString := interpreterProxy 
								instantiateClass: interpreterProxy classString
								indexableSize: sz.
	newStringPtr := interpreterProxy firstIndexableField: newString.
	self cCode: 'strncpy(newStringPtr, cDeviceName, sz)'.

	self touch: newStringPtr.
	self touch: cDeviceName.
	"Pop the receiver, and answer the new string."
	^interpreterProxy pop: 1 thenPush: newString