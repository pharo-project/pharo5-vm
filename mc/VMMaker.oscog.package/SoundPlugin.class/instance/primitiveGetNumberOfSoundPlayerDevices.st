primitives
primitiveGetNumberOfSoundPlayerDevices
	"arguments: name(type, stack offset)
		dialString(String, 0)"
	"answers an Integer"
	| result |
	<export: true>

	"Parse arguments"
	interpreterProxy methodArgumentCount = 0 
		ifFalse:[^interpreterProxy primitiveFail].
	
	"get result"
	result := self cCode: 'getNumberOfSoundPlayerDevices()'.

	"answer it"
	result := interpreterProxy signed32BitIntegerFor: result.
	^interpreterProxy pop: 1 thenPush: result. "pop receiver, return result"