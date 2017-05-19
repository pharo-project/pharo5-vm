primitives
primitiveGetSoundPlayerDeviceName
	"arguments: name(type, stack offset)
		deviceNumber(Integer, 0)"
	"answers a string or nil"
	| deviceNumber sz cDeviceName newString newStringPtr |
	<export: true>
	<var: #cDeviceName type: 'char*'>
	<var: #newStringPtr type: 'char*'>

	"Parse arguments" 
	interpreterProxy methodArgumentCount = 1 
		ifFalse:[^interpreterProxy primitiveFail].

	deviceNumber := interpreterProxy positive32BitValueOf: (interpreterProxy stackValue: 0).
	interpreterProxy failed ifTrue: [^nil].
	
	"Get the answer."
	cDeviceName := self cCode: 'getSoundPlayerDeviceName(deviceNumber - 1)'.
	cDeviceName == 0 ifTrue: [
		^interpreterProxy pop: 2 thenPush: interpreterProxy nilObject
		].

	"Copy the answer to a Squeak String."
	sz :=  self cCode: 'strlen(cDeviceName)'.
	newString := interpreterProxy 
								instantiateClass: interpreterProxy classString
								indexableSize: sz.
	newStringPtr := interpreterProxy firstIndexableField: newString.
	self cCode: 'strncpy(newStringPtr, cDeviceName, sz)'.

	self touch: deviceNumber.
	self touch: newStringPtr.
	self touch: cDeviceName.
	"Pop the receiver and arg, and answer the new string."
	^interpreterProxy pop: 2 thenPush: newString