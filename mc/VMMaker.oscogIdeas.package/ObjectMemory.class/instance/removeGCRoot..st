plugin support
removeGCRoot: varLoc
	"Remove the given variable location to the extra roots table"
	<export: true>
	<var: #varLoc type: #'sqInt *'>
	1 to: extraRootCount do:
		[:i|
		varLoc = (extraRoots at: i) ifTrue: "swap varLoc with last entry"
			[extraRoots at: i put: (extraRoots at: extraRootCount).
			 extraRootCount := extraRootCount-1.
			 ^true]].
	^false "not found"