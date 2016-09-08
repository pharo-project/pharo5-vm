method map
mapFor: cogMethod bcpc: startbcpc performUntil: functionSymbol arg: arg
	"Machine-code <-> bytecode pc mapping support.  Evaluate functionSymbol
	 for each mcpc, bcpc pair in the map until the function returns non-zero,
	 answering that result, or 0 if it fails to.  To cut down on number of arguments.
	 and to be usable for both pc-mapping and method introspection, we encode
	 the annotation and the isBackwardBranch flag in the same parameter.
	 Guilty as charged."
	<var: #cogMethod type: #'CogBlockMethod *'>
	<var: #functionSymbol declareC: 'sqInt (*functionSymbol)(BytecodeDescriptor *desc, sqInt annotationAndIsBackwardBranch, char *mcpc, sqInt bcpc, void *arg)'>
	<var: #arg type: #'void *'>
	<inline: true>
	| isInBlock mcpc bcpc endbcpc map mapByte homeMethod aMethodObj result
	  latestContinuation byte descriptor bsOffset nExts annotation |
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<var: #homeMethod type: #'CogMethod *'>

	self assert: cogMethod stackCheckOffset > 0.
	mcpc := cogMethod asUnsignedInteger + cogMethod stackCheckOffset.
	"The stack check maps to the start of the first bytecode,
	 the first bytecode being effectively after frame build."
	result := self perform: functionSymbol
					with: nil
					with: 0 + (HasBytecodePC << 1)
					with: (self cCoerceSimple: mcpc to: #'char *')
					with: startbcpc
					with: arg.
	result ~= 0 ifTrue:
		[^result].
	bcpc := startbcpc.
	"In both CMMethod and CMBlock cases find the start of the map and
	 skip forward to the bytecode pc map entry for the stack check."
	cogMethod cmType = CMMethod
		ifTrue:
			[isInBlock := cogMethod cmIsFullBlock.
			 homeMethod := self cCoerceSimple: cogMethod to: #'CogMethod *'.
			 self assert: startbcpc = (coInterpreter startPCOfMethodHeader: homeMethod methodHeader).
			 map := self mapStartFor: homeMethod.
			 annotation := (objectMemory byteAt: map) >> AnnotationShift.
			 self assert: (annotation = IsAbsPCReference
						 or: [annotation = IsObjectReference
						 or: [annotation = IsRelativeCall
						 or: [annotation = IsDisplacementX2N]]]).
			 latestContinuation := startbcpc.
			 aMethodObj := homeMethod methodObject.
			 endbcpc := (objectMemory numBytesOf: aMethodObj) - 1.
			 bsOffset := self bytecodeSetOffsetForHeader: homeMethod methodHeader.
			"If the method has a primitive, skip it and the error code store, if any;
			 Logically. these come before the stack check and so must be ignored."
			 bcpc := bcpc + (self deltaToSkipPrimAndErrorStoreIn: aMethodObj
									header: homeMethod methodHeader)]
		ifFalse:
			[isInBlock := true.
			 self assert: bcpc = cogMethod startpc.
			 homeMethod := cogMethod cmHomeMethod.
			 map := self findMapLocationForMcpc: cogMethod asUnsignedInteger + (self sizeof: CogBlockMethod)
						inMethod: homeMethod.
			 self assert: map ~= 0.
			 annotation := (objectMemory byteAt: map) >> AnnotationShift.
			 self assert: (annotation >> AnnotationShift = HasBytecodePC "fiducial"
						 or: [annotation >> AnnotationShift = IsDisplacementX2N]).
			 [(annotation := (objectMemory byteAt: map) >> AnnotationShift) ~= HasBytecodePC] whileTrue:
				[map := map - 1].
			 map := map - 1. "skip fiducial; i.e. the map entry for the pc immediately following the method header."
			 aMethodObj := homeMethod methodObject.
			 bcpc := startbcpc - (self blockCreationBytecodeSizeForHeader: homeMethod methodHeader).
			 bsOffset := self bytecodeSetOffsetForHeader: homeMethod methodHeader.
			 byte := (objectMemory fetchByte: bcpc ofObject: aMethodObj) + bsOffset.
			 descriptor := self generatorAt: byte.
			 endbcpc := self nextBytecodePCFor: descriptor at: bcpc exts: -1 in: aMethodObj.
			 bcpc := startbcpc].
	nExts := 0.
	self inlineCacheTagsAreIndexes ifTrue:
		[enumeratingCogMethod := homeMethod].
	"Now skip up through the bytecode pc map entry for the stack check." 
	[(objectMemory byteAt: map) >> AnnotationShift ~= HasBytecodePC] whileTrue:
		[map := map - 1].
	map := map - 1.
	[(mapByte := objectMemory byteAt: map) ~= MapEnd] whileTrue: "defensive; we exit on bcpc"
		[mapByte >= FirstAnnotation
			ifTrue:
				[| nextBcpc isBackwardBranch |
				annotation := mapByte >> AnnotationShift.
				mcpc := mcpc + ((mapByte bitAnd: DisplacementMask) * backEnd codeGranularity).
				(self isPCMappedAnnotation: annotation) ifTrue:
					[(annotation = IsSendCall
					  and: [(mapByte := objectMemory byteAt: map - 1) >> AnnotationShift = IsAnnotationExtension]) ifTrue:
						[annotation := annotation + (mapByte bitAnd: DisplacementMask).
						 map := map - 1].
					 [byte := (objectMemory fetchByte: bcpc ofObject: aMethodObj) + bsOffset.
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
									with: (isBackwardBranch ifTrue: [annotation << 1 + 1] ifFalse: [annotation << 1])
									with: (self cCoerceSimple: mcpc to: #'char *')
									with: bcpc
									with: arg.
					 result ~= 0 ifTrue:
						[^result].
					 bcpc := nextBcpc.
					 nExts := descriptor isExtension ifTrue: [nExts + 1] ifFalse: [0]]]
			ifFalse:
				[self assert: (mapByte >> AnnotationShift = IsDisplacementX2N
							or: [mapByte >> AnnotationShift = IsAnnotationExtension]).
				 mapByte < (IsAnnotationExtension << AnnotationShift) ifTrue:
					[mcpc := mcpc + ((mapByte - DisplacementX2N << AnnotationShift) * backEnd codeGranularity)]].
		 map := map - 1].
	^0