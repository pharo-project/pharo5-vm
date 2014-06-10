private-support
index: byteIndex length: length inRange: rcvr
	"Answer if the indices byteIndex to byteIndex + length - 1 are valid zero-relative indices into the rcvr.
	 N.B.  This code only works when translated because asUnisgnedInteger only works for non-negative
	 values. Hence the override in NewsqueakIA32ABIPluginSimulator."
	| dataSize |
	<inline: true>
	^(dataSize := self sizeField: rcvr) = 0
	   or: [byteIndex asUnsignedInteger + length <= dataSize abs]