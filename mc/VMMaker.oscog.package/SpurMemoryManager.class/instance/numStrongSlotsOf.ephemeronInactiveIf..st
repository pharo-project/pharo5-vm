object access
numStrongSlotsOf: objOop ephemeronInactiveIf: criterion
	"Answer the number of strong pointer fields in the given object.
	 Works with CompiledMethods, as well as ordinary objects."
	<var: 'criterion' declareC: 'int (*criterion)(sqInt key)'>
	<inline: true>
	<asmLabel: false>
	| fmt |
	fmt := self formatOf: objOop.
	^self numStrongSlotsOf: objOop format: (self formatOf: objOop) ephemeronInactiveIf: criterion