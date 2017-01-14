plugin support
addGCRoot: varLoc
	"Add the given variable location to the extra roots table."
	<api>
	<var: #varLoc type: #'sqInt *'>
	extraRootCount >= ExtraRootsSize ifTrue: [^false]. "out of space"
	extraRoots at: (extraRootCount := extraRootCount + 1) put: varLoc.
	^true