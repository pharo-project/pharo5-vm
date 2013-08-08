cmake commands
addFrameworks: aCollection 
	"for mac only "
	aCollection
		do: [:each | 
			self cmd: 'find_library' params:  each , '_FMWK ', each.
			self addExternalLibrary: '${', each , '_FMWK}' ]