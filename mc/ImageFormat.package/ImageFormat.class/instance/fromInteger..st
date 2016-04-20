initialize-release
fromInteger: anInteger
	"Initialize a new instance from anInteger obtained from an image file header."

	| baseVersion capabilitiesBits |
	(anInteger bitAnd: ReservedBitsMask) ~= 0
		ifTrue: [self error: 'invalid format number ', anInteger printString].
	baseVersion := self  baseVersionBitsOf: anInteger.
	((baseVersion = 6504 or: [baseVersion = 68002]) or: [baseVersion = 68004])
		ifTrue: [requiresClosureSupport := true].
	(baseVersion = 6502 or: [baseVersion = 6504])
		ifTrue: [wordSize := 4]
		ifFalse: [((baseVersion = 68000 or: [baseVersion = 68002]) or: [baseVersion = 68004])
			ifTrue: [wordSize := 8.
					baseVersion = 68004
						ifTrue: [self setRequiresNewSpur64TagAssignmentRequirement: true]]
			ifFalse: [self error: 'invalid format number ', anInteger printString]].
	capabilitiesBits := anInteger bitAnd: CapabilitiesBitsMask.
	(capabilitiesBits bitAt: PlatformByteOrderBit) = 1
		ifTrue: [requiresNativeFloatWordOrder := true.
			requiresClosureSupport
				ifFalse: [self error: 'Images requiring platform byte order also require closure support (Cog)'].
			capabilitiesBits := capabilitiesBits bitAt: PlatformByteOrderBit put: 0].
	(capabilitiesBits bitAt: SpurObjectBit) = 1
		ifTrue: [requiresSpurSupport := true.
			requiresClosureSupport
				ifFalse: [self error: 'Images requiring Spur also require closure support'].
			requiresNativeFloatWordOrder
				ifFalse: [self error: 'Images requiring Spur also require native float word order support'].
			capabilitiesBits := capabilitiesBits bitAt: SpurObjectBit put: 0].
	"add additional capability bit handling here"
	capabilitiesBits == 0
		ifFalse: [self error: 'invalid format number ', anInteger printString]
	
