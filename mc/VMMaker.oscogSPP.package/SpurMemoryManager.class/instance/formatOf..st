object access
formatOf: objOop
	"0 = 0 sized objects (UndefinedObject True False et al)
	 1 = non-indexable objects with inst vars (Point et al)
	 2 = indexable objects with no inst vars (Array et al)
	 3 = indexable objects with inst vars (MethodContext AdditionalMethodState et al)
	 4 = weak indexable objects with inst vars (WeakArray et al)
	 5 = weak non-indexable objects with inst vars (ephemerons) (Ephemeron)
	 6 unused, reserved for exotic pointer objects?
	 7 Forwarded Object, 1st field is pointer, rest of fields are ignored
	 8 unused, reserved for exotic non-pointer objects?
	 9 64-bit indexable
	 10 - 11 32-bit indexable	(11 unused in 32 bits)
	 12 - 15 16-bit indexable	(14 & 15 unused in 32-bits)
	 16 - 23 byte indexable		(20-23 unused in 32-bits)
	 24 - 31 compiled method	(28-31 unused in 32-bits)"
	"A note on performance.  Since the format field is, by design, aligned on a byte boundary
	 in the fourth byte of the header we could access it via
		^(self byteAt: objOop + 3) bitAnd: self formatMask
	 but al least on e.g. Core i7 x86-64 using the clang 6 compiler, this makes no difference,
	 or at least any change is in the noise."
	^(self longAt: objOop) >> self formatShift bitAnd: self formatMask