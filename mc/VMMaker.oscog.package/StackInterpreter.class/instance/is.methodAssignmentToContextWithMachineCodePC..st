internal interpreter access
is: fieldIndex methodAssignmentToContextWithMachineCodePC: anOop
	"This is a hook for the CoInterpreter.  It is a noop in the StackInterpreter."
	<inline: true>
	^false