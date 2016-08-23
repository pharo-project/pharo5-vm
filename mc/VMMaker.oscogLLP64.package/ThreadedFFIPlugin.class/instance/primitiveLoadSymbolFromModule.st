primitives
primitiveLoadSymbolFromModule
	"Attempt to find the address of a symbol in a loaded library.
	loadSymbol: aSymbol fromModule: moduleName
		<primitive: 'primitiveLoadSymbolFromModule' error: errorCode module: 'SqueakFFIPrims'>
	"
	<export: true>

	| symbol module moduleHandle address oop ptr |

	<var: #address type: #'void *'>
	<var: #ptr type: #'void **'>
	
	interpreterProxy methodArgumentCount = 2 ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadNumArgs].	

	module := interpreterProxy stackValue: 0.
	symbol := interpreterProxy stackValue: 1.

	module ~= interpreterProxy nilObject 
		ifTrue: [ moduleHandle := self ffiLoadCalloutModule: module ]
		ifFalse: [ moduleHandle := nil ].
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNotFound].
	address := interpreterProxy
					ioLoadSymbol: (self cCoerce: (interpreterProxy firstIndexableField: symbol) to: #sqInt)
					OfLength: (interpreterProxy byteSizeOf: symbol)
					FromModule: moduleHandle.
	(interpreterProxy failed
	 or: [address = 0]) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNotFound].
	
	oop := interpreterProxy 
			instantiateClass: interpreterProxy classExternalAddress 
			indexableSize: (self sizeof: #'void *').
	ptr := interpreterProxy firstIndexableField: oop.
	ptr at: 0 put: address.
	
	^interpreterProxy methodReturnValue: oop