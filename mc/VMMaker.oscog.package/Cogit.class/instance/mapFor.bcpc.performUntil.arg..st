method map
mapFor: cogMethod bcpc: startbcpc performUntil: functionSymbol arg: arg
	"Machine-code <-> bytecode pc mapping support.  Evaluate functionSymbol
	 for each mcpc, bcpc pair in the map until the function returns non-zero,
	 answering that result, or 0 if it fails to.  This works only for frameful methods."
	<var: #cogMethod type: #'CogBlockMethod *'>
	<var: #functionSymbol declareC: 'sqInt (*functionSymbol)(BytecodeDescriptor *desc, sqInt isBackwardBranch, char *mcpc, sqInt bcpc, void *arg)'>
	<var: #arg type: #'void *'>
	<inline: true>
	| isInBlock mcpc bcpc endbcpc map mapByte homeMethod aMethodObj result
	  latestContinuation byte descriptor bsOffset nExts |
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<var: #homeMethod type: #'CogMethod *'>
	self assert: cogMethod stackCheckOffset > 0.
	"In both CMMethod and CMBlock cases find the start of the map and
	 skip forward to the bytecode pc map entry for the stack check."
	cogMethod cmType = CMMethod
		ifTrue:
			[isInBlock := false.
			 homeMethod := self cCoerceSimple: cogMethod to: #'CogMethod *'.
			 self assert: startbcpc = (coInterpreter startPCOfMethodHeader: homeMethod methodHeader).
			 map := self mapStartFor: homeMethod.
			 self assert: ((objectMemory byteAt: map) >> AnnotationShift = IsAbsPCReference
						 or: [(objectMemory byteAt: map) >> AnnotationShift = IsObjectReference
						 or: [(objectMemory byteAt: map) >> AnnotationShift = IsRelativeCall
						 or: [(objectMemory byteAt: map) >> AnnotationShift = IsDisplacementX2N]]]).
			 latestContinuation := startbcpc.
			 aMethodObj := homeMethod methodObject.
			 endbcpc := (objectMemory byteLengthOf: aMethodObj) - 1.
			 bsOffset := self bytecodeSetOffsetForHeader: homeMethod methodHeader]
		ifFalse:
			[isInBlock := true.
			 homeMethod := cogMethod cmHomeMethod.
			 map := self findMapLocationForMcpc: cogMethod asUnsignedInteger + (self sizeof: CogBlockMethod)
						inMethod: homeMethod.
			 self assert: map ~= 0.
			 self assert: ((objectMemory byteAt: map) >> AnnotationShift = HasBytecodePC "fiducial"
						 or: [(objectMemory byteAt: map) >> AnnotationShift = IsDisplacementX2N]).
			 [(objectMemory byteAt: map) >> AnnotationShift ~= HasBytecodePC] whileTrue:
				[map := map - 1].
			 map := map - 1. "skip fiducial; i.e. the map entry for the pc immediately following the method header."
			 aMethodObj := homeMethod methodObject.
			 bcpc := startbcpc - (self blockCreationBytecodeSizeForHeader: homeMethod methodHeader).
			 bsOffset := self bytecodeSetOffsetForHeader: homeMethod methodHeader.
			 byte := (objectMemory fetchByte: bcpc ofObject: aMethodObj) + bsOffset.
			 descriptor := self generatorAt: byte.
			 endbcpc := self nextBytecodePCFor: descriptor at: bcpc exts: -1 in: aMethodObj].
	bcpc := startbcpc.
	mcpc := cogMethod asUnsignedInteger + cogMethod stackCheckOffset.
	nExts := 0.
	"The stack check maps to the start of the first bytecode,
	 the first bytecode being effectively after frame build."
	result := self perform: functionSymbol
					with: nil
					with: false
					with: (self cCoerceSimple: mcpc to: #'char *')
					with: startbcpc
					with: arg.
	result ~= 0 ifTrue:
		[^result].
	"Now skip up through the bytecode pc map entry for the stack check." 
	[(objectMemory byteAt: map) >> AnnotationShift ~= HasBytecodePC] whileTrue:
		[map := map - 1].
	map := map - 1.
	[(mapByte := objectMemory byteAt: map) ~= MapEnd] whileTrue: "defensive; we exit on bcpc"
		[mapByte >= FirstAnnotation
			ifTrue:
				[| annotation nextBcpc isBackwardBranch |
				annotation := mapByte >> AnnotationShift.
				mcpc := mcpc + (mapByte bitAnd: DisplacementMask).
				(self isPCMappedAnnotation: annotation alternateInstructionSet: bsOffset > 0) ifTrue:
					[[byte := (objectMemory fetchByte: bcpc ofObject: aMethodObj) + bsOffset.
					  descriptor := self generatorAt: byte.
					  isInBlock
						ifTrue: [bcpc >= endbcpc ifTrue: [^0]]
						ifFalse:
							[(descriptor isReturn and: [bcpc >= latestContinuation]) ifTrue: [^0].
							 (descriptor isBranch or: [descriptor isBlockCreation]) ifTrue:
								[| targetPC |
								 targetPC := self latestContinuationPCFor: descriptor at: bcpc exts: nExts in: aMethodObj.
								 latestContinuation := latestContinuation max: targetPC]].
					  nextBcpc := self nextBytecodePCFor: descriptor at: bcpc exts: nExts in: aMethodObj.
					  descriptor isMapped
					  or: [isInBlock and: [descriptor isMappedInBlock]]] whileFalse:
						[bcpc := nextBcpc.
						 nExts := descriptor isExtension ifTrue: [nExts + 1] ifFalse: [0]].
					isBackwardBranch := descriptor isBranch
										   and: [self isBackwardBranch: descriptor at: bcpc exts: nExts in: aMethodObj].
					result := self perform: functionSymbol
									with: descriptor
									with: isBackwardBranch
									with: (self cCoerceSimple: mcpc to: #'char *')
									with: bcpc
									with: arg.
					 result ~= 0 ifTrue:
						[^result].
					 bcpc := nextBcpc.
					 nExts := descriptor isExtension ifTrue: [nExts + 1] ifFalse: [0]].
				self maybeRememberPrevMap: annotation absPCMcpc: mcpc]
			ifFalse:
				[mcpc := mcpc + (mapByte >= DisplacementX2N
									ifTrue: [mapByte - DisplacementX2N << AnnotationShift]
									ifFalse: [mapByte])].
		 map := map - 1].
	^0