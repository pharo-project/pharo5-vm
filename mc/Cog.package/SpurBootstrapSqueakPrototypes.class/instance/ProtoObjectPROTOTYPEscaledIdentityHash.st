method prototypes
ProtoObjectPROTOTYPEscaledIdentityHash
	"For identityHash values returned by primitive 75, answer
	 such values times 2^8.  Otherwise, match the existing
	 identityHash implementation"

	^self identityHash * 256 "bitShift: 8"