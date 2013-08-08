system primitives
primitiveDisposeMenuBar: menuHandleOop 
	| menuBarHandle |
	self primitive: 'primitiveDisposeMenuBar'
		parameters: #(Oop).
	self var: 'menuBarHandle' type: 'Handle'.
	
	menuBarHandle := self cCoerce: (interpreterProxy positive32BitValueOf: menuHandleOop) to: 'Handle'.
	self cCode: '#if TARGET_API_MAC_CARBON
	DisposeMenuBar(menuBarHandle);
	#else
	DisposeHandle(menuBarHandle);
	#endif
	' 
		inSmalltalk:[menuBarHandle].
	^nil
