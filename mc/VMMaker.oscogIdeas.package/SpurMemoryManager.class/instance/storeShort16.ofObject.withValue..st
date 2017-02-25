object access
storeShort16: shortIndex ofObject: objOop withValue: value
	^self
		shortAt: objOop + self baseHeaderSize + (shortIndex << 1)
		put: (self cCode: [value] inSmalltalk: [value bitAnd: 16rFFFF])