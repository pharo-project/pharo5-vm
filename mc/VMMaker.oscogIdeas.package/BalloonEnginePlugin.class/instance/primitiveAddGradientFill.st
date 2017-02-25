primitives
primitiveAddGradientFill

	| failureCode isRadial nrmOop dirOop originOop rampOop fill |
	<export: true>
	<inline: false>

	"Fail if we have the wrong number of arguments"
	interpreterProxy methodArgumentCount = 5 
		ifFalse:[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].

	isRadial := interpreterProxy booleanValueOf: (interpreterProxy stackValue: 0).
	nrmOop := interpreterProxy stackValue: 1.
	dirOop := interpreterProxy stackValue: 2.
	originOop := interpreterProxy stackValue: 3.
	rampOop := interpreterProxy stackValue: 4.
	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	(failureCode := self quickLoadEngineFrom: (interpreterProxy stackValue: 5)
						requiredState: GEStateUnlocked) = 0
		ifFalse:[^interpreterProxy primitiveFailFor: failureCode].

	self loadPoint: self point1Get from: originOop.
	self loadPoint: self point2Get from: dirOop.
	self loadPoint: self point3Get from: nrmOop.
	interpreterProxy failed ifTrue:[^interpreterProxy primitiveFailFor: GEFBadPoint].

	fill := self loadGradientFill: rampOop 
				from: self point1Get 
				along: self point2Get 
				normal: self point3Get 
				isRadial: isRadial.
	engineStopped ifTrue:[
		"Make sure the stack is okay"
		^interpreterProxy primitiveFailFor: GEFEngineStopped].

	interpreterProxy failed
		ifTrue: [^interpreterProxy primitiveFailFor: GEFEntityLoadFailed].
	self storeEngineStateInto: engine.
	interpreterProxy pop: 6 thenPush: (interpreterProxy positive32BitIntegerFor: fill)