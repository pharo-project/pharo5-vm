primitives
primitiveAddBitmapFill

	| failureCode nrmOop dirOop originOop tileFlag fill xIndex cmOop formOop |
	<export: true>
	<inline: false>

	"Fail if we have the wrong number of arguments"
	interpreterProxy methodArgumentCount = 7 
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].

	xIndex := interpreterProxy stackIntegerValue: 0.
	xIndex <= 0 ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	nrmOop := interpreterProxy stackObjectValue: 1.
	dirOop := interpreterProxy stackObjectValue: 2.
	originOop := interpreterProxy stackObjectValue: 3.
	tileFlag := interpreterProxy booleanValueOf: (interpreterProxy stackValue: 4).
	cmOop := interpreterProxy stackObjectValue: 5.
	formOop := interpreterProxy stackObjectValue: 6.
	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 7)
						requiredState: GEStateUnlocked) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	self loadPoint: self point1Get from: originOop.
	self loadPoint: self point2Get from: dirOop.
	self loadPoint: self point3Get from: nrmOop.
	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: GEFBadPoint].

	fill := self loadBitmapFill: formOop 
				colormap: cmOop
				tile: (tileFlag ifTrue:[1] ifFalse:[0])
				from: self point1Get 
				along: self point2Get 
				normal: self point3Get 
				xIndex: xIndex-1.
	engineStopped ifTrue:[
		"Make sure the stack is okay"
		^interpreterProxy primitiveFailFor: GEFEngineStopped].

	interpreterProxy failed
		ifTrue:[^interpreterProxy primitiveFailFor: GEFEntityLoadFailed].
	self storeEngineStateInto: engine.
	interpreterProxy pop: 8 thenPush: (interpreterProxy positive32BitIntegerFor: fill)