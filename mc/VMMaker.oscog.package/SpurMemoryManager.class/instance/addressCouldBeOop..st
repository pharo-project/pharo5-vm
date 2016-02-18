debug support
addressCouldBeOop: address
	<api>
	"Answer if address appears to be that of either an immediate or an object.
	 For code disassembly and assertions."
	^(self isImmediate: address)
	  or: [self addressCouldBeObj: address]