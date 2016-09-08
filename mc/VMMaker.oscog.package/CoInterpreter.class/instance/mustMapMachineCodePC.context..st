frame access
mustMapMachineCodePC: theIP context: aOnceMarriedContext
	"Map the native pc theIP into a bytecode pc integer object and answer it.
	 See contextInstructionPointer:frame: for the explanation."
	| maybeClosure methodObj cogMethod startBcpc bcpc |
	<inline: false>
	<var: #cogMethod type: #'CogMethod *'>
	theIP = HasBeenReturnedFromMCPC ifTrue:
		[^objectMemory nilObject].
	maybeClosure := objectMemory fetchPointer: ClosureIndex ofObject: aOnceMarriedContext.
	methodObj := objectMemory fetchPointer: MethodIndex ofObject: aOnceMarriedContext.
	(maybeClosure ~= objectMemory nilObject
	and: [self isVanillaBlockClosure: maybeClosure])
		ifTrue: [self assert: (theIP signedBitShift: -16) < -1.
				startBcpc := self startPCOfClosure: maybeClosure]
		ifFalse: [self assert: (theIP signedBitShift: -16) = -1.
				startBcpc := self startPCOfMethod: methodObj].
	cogMethod := self ensureMethodIsCogged: methodObj.
	bcpc := self bytecodePCFor: theIP cogMethod: cogMethod startBcpc: startBcpc.
	self assert: bcpc >= (self startPCOfMethod: methodObj).
	"If there's a CallPrimitive we need to skip it."
	(bcpc = startBcpc
	 and: [maybeClosure = objectMemory nilObject
	 and: [self methodHeaderHasPrimitive: cogMethod methodHeader]]) ifTrue:
		[bcpc := bcpc + (self sizeOfCallPrimitiveBytecode: cogMethod methodHeader)].
	^objectMemory integerObjectOf: bcpc + 1