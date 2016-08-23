primitives - surfaces
primitiveCreateManualSurface
	"arguments: name(type, stack offset)
		width(Integer, 4)
		height(Integer, 3)
		rowPitch(Integer, 2)
		depth(Integer, 1)
		isMSB(Boolean, 0)"
	| width height rowPitch depth isMSB result |
	<export: true>
	
	interpreterProxy methodArgumentCount = 5 ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].
	width := interpreterProxy stackIntegerValue: 4.
	height := interpreterProxy stackIntegerValue: 3.
	rowPitch := interpreterProxy stackIntegerValue: 2.
	depth := interpreterProxy stackIntegerValue: 1.
	isMSB := interpreterProxy stackObjectValue: 0.
	isMSB := interpreterProxy booleanValueOf: isMSB. 
	interpreterProxy failed ifTrue: [^nil].
	
	result := self cCode: 'createManualSurface(width, height, rowPitch, depth, isMSB)'
				inSmalltalk: [self create: width Man: height ual: rowPitch Surf: depth ace: isMSB].
	result < 0 ifTrue:
		[^interpreterProxy primitiveFail].
	result := interpreterProxy signedMachineIntegerFor: result.
	^interpreterProxy pop: 6 thenPush: result
	