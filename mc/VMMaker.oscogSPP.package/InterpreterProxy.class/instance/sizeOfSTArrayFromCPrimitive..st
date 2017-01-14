object access
sizeOfSTArrayFromCPrimitive: cPtr
	"Note: Only called by translated primitive code."
	<var: #cPtr type: 'void *'>
	^self shouldNotImplement