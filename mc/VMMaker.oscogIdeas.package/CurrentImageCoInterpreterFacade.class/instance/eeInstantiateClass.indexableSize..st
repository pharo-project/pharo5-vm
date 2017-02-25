accessing
eeInstantiateClass: classOop indexableSize: numSlots
	^self oopForObject: ((self objectForOop: classOop) new: numSlots)