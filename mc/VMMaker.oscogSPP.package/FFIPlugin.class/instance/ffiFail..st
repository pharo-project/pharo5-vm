callout support
ffiFail: reason
	<inline: false>
	"Map the FFI error code into a primitive error code.  If reason is negative it encodes one of the
	 standard PrimErr... codes, negated to distinguish it from the FFIError codes.  If it is an FFIError...
	 code then add the size of the primitive error table + 2 to disambiguate it from the PrimErr... codes.
	 For historic reasons the FFIError codes range from -1 on up hence adding size + 2 maps them to
	 size of table + 1 on up.  This OFFSET IS undone by ExternalFunction class>>externalCallFailedWith:.
	 Thus we can communicate back both PrimErr.. and FFIError codes.  Complex but necessary in the ThreadedFFIPlugin."
	self ffiSetLastError: reason.
	^interpreterProxy primitiveFailFor:
		(reason >= FFINoCalloutAvailable
			ifTrue: [reason + 2 + (interpreterProxy slotSizeOf: interpreterProxy primitiveErrorTable)]
			ifFalse: [reason negated])