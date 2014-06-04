plugin support
addToExternalPrimitiveTable: functionAddress
	"Add the given function address to the external primitive table and return the index where it's stored. This function doesn't need to be fast since it is only called when an external primitive has been looked up (which takes quite a bit of time itself). So there's nothing specifically complicated here.
	Note: Return index will be one-based (ST convention)"

	<var: #functionAddress declareC: 'void *functionAddress'>

	0 to: MaxExternalPrimitiveTableSize-1 do: [ :i |
		(externalPrimitiveTable at: i) = 0 ifTrue: [
			externalPrimitiveTable at: i put: functionAddress.
			^i+1]].
	"if no space left, return zero so it'll looked up again"
	^0