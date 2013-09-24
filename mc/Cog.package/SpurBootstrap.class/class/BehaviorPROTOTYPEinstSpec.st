method prototypes
BehaviorPROTOTYPEinstSpec
	"Answer the instance specification part of the format that defines what kind of object
	 an instance of the receiver is.  The formats are0 = 0 sized objects (UndefinedObject True False et al)
		1 = non-indexable objects with inst vars (Point et al)
		2 = indexable objects with no inst vars (Array et al)
		3 = indexable objects with inst vars (MethodContext AdditionalMethodState et al)
		4 = weak indexable objects with inst vars (WeakArray et al)
		5 = weak non-indexable objects with inst vars (ephemerons) (Ephemeron)
		6 unused, reserved for exotic pointer objects?
		7 reserved by the VM
		8 unused, reserved for exotic non-pointer objects?
		9 (?) 64-bit indexable
		10 - 11 32-bit indexable
		12 - 15 16-bit indexable
		16 - 23 byte indexable
		24 - 31 compiled method"
	^(format bitShift: -16) bitAnd: 16r1F