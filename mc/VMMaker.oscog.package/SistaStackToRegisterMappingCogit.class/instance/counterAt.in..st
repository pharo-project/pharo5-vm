method introspection
counterAt: index in: cogMethod
	<var: #cogMethod type: #'CogMethod *'>
	"zero-relative counter access"
	^objectMemory longAt: cogMethod asUnsignedInteger + cogMethod blockSize - (cogMethod numCounters - index * CounterBytes)