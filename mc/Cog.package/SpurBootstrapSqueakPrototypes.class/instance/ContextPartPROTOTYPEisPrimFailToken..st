method prototypes
ContextPartPROTOTYPEisPrimFailToken: anObject
	^(self objectClass: anObject) == Array
	  and: [anObject size = 2
	  and: [anObject first == PrimitiveFailToken]]