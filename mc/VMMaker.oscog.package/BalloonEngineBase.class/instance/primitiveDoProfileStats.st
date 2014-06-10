primitives-other
primitiveDoProfileStats
	"Turn on/off profiling. Return the old value of the flag."
	| oldValue newValue |
	<inline: false>
	<export: true>
	oldValue := doProfileStats.
	newValue := interpreterProxy stackObjectValue: 0.
	newValue := interpreterProxy booleanValueOf: newValue.
	interpreterProxy failed ifFalse:[
		doProfileStats := newValue.
		interpreterProxy pop: 2. "Pop rcvr, arg"
		interpreterProxy pushBool: oldValue.
	].