primitive support
getStackPointer
	"For Alien FFI"
	<api>
	<returnTypeC: #'sqInt *'>
	^self cCoerce: stackPointer to: #'sqInt *'