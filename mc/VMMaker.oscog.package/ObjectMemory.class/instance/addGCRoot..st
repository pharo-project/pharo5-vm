plugin support
addGCRoot: varLoc
	"Add the given variable location to the extra roots table"
	<export: true>
	<var: #varLoc type: #'sqInt *'>
	extraRootCount >= ExtraRootSize ifTrue:[^false]. "out of space"
	extraRoots at: (extraRootCount := extraRootCount+1) put: varLoc.
	^true