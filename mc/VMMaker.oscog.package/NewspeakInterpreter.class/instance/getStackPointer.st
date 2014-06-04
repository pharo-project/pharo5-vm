primitive support
getStackPointer
	"For Newsqueak FFI"
	<export: true>
	<returnTypeC: #'sqInt *'>
	^self cCoerce: stackPointer to: #'sqInt *'