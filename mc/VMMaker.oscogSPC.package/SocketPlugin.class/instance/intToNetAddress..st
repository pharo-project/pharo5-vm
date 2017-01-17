primitives
intToNetAddress: addr
	"Convert the given 32-bit integer into an internet network address represented as a four-byte ByteArray."

	| netAddressOop naPtr |
	<var: #naPtr type: 'char * '>

	netAddressOop :=
		interpreterProxy instantiateClass: interpreterProxy classByteArray
			indexableSize: 4.
	naPtr := netAddressOop asCharPtr.
	naPtr at: 0 put: (self cCoerce: ((addr >> 24) bitAnd: 16rFF) to: 'char').
	naPtr at: 1 put: (self cCoerce: ((addr >> 16) bitAnd: 16rFF) to: 'char').
	naPtr at: 2 put: (self cCoerce: ((addr >> 8) bitAnd: 16rFF) to: 'char').
	naPtr at: 3 put: (self cCoerce: (addr bitAnd: 16rFF) to: 'char').
	^ netAddressOop