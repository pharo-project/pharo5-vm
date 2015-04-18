*Cog-method prototypes
ContextPROTOTYPEisPrimFailToken: anObject
	^ anObject class == Array
	  and: [anObject size = 2
	  and: [anObject first == PrimitiveFailToken]]