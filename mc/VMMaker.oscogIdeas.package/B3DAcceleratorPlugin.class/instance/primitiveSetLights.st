primitives-renderer
primitiveSetLights
	| lightArray lightCount light handle |
	<export: true>
	<inline: false>
	<var: #light type: 'void*'>

	interpreterProxy methodArgumentCount = 2
		ifFalse:[^interpreterProxy primitiveFail].

	lightArray := self stackLightArrayValue: 0.
	handle := interpreterProxy stackIntegerValue: 1.
	interpreterProxy failed ifTrue:[^nil].
	(self b3dxDisableLights: handle)
		ifFalse:[^interpreterProxy primitiveFail].
	lightArray == nil ifTrue:[^nil].
	lightCount := interpreterProxy slotSizeOf: lightArray.
	"For each enabled light source"
	0 to: lightCount-1 do:[:i|
		light := self fetchLightSource: i ofObject: lightArray.
		(self cCode:'b3dxLoadLight(handle, i, light)' inSmalltalk:[false])
			ifFalse:[^interpreterProxy primitiveFail].
	].
	^interpreterProxy pop: 2. "args; return rcvr"