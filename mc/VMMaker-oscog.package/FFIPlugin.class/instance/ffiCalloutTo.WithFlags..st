callout support
ffiCalloutTo: address WithFlags: callType
	"Go out, call this guy and create the return value"
	| retVal |
	<inline: false>
	"Note: Order is important here since FFIFlagPointer + FFIFlagStructure is used to represent 'typedef void* VoidPointer' and VoidPointer must be returned as pointer *not* as struct"
	(ffiRetHeader anyMask: FFIFlagPointer) ifTrue:[
		retVal := self ffiCallAddressOf: address WithPointerReturn: callType.
		^self ffiCreateReturnPointer: retVal.
	].
	(ffiRetHeader anyMask: FFIFlagStructure) ifTrue:[
		self 
			ffiCallAddressOf: address 
			With: callType 
			Struct: (self cCoerce: ffiRetSpec to:'int*')
			Return: ffiRetSpecSize.
		^self ffiCreateReturnStruct.
	].
	retVal := self ffiCallAddressOf: address With: callType ReturnType: ffiRetHeader.
	^self ffiCreateReturn: retVal.