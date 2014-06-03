loading state
loadWordTransformFrom: transformOop into: destPtr length: n
	"Load a float array transformation from the given oop"
	| srcPtr |
	<inline: false>
	<var: #srcPtr type:'float *'>
	<var: #destPtr type:'float *'>
	srcPtr := self cCoerce: (interpreterProxy firstIndexableField: transformOop) to: 'float *'.
	0 to: n-1 do:[:i| destPtr at: i put: (srcPtr at: i)].