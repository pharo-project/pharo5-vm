primitives
primitiveExecutableModulesAndOffsets
	"Answer an Array of quads for executable modules (the VM executable
	 and loaded libraries).  Each quad is the module's name, its vm address
	 relocation in memory, the (unrelocated) start address, and the size."
	| present nimages resultObj name valueObj nameObjData slide start size h s |
	<export: true>
	<var: #name type: 'const char *'>
	<var: #nameObjData type: #'char *'>
	<var: #h type: 'const struct mach_header *'>
	<var: #s type: 'const struct section *'>
	<var: #start type: 'unsigned long'>
	<var: #size type: 'unsigned long'>
	present := self cCode: '_dyld_present()' inSmalltalk: [false].
	present ifFalse:
		[^interpreterProxy primitiveFail].
	nimages := self cCode: '_dyld_image_count()' inSmalltalk: [0].
	resultObj := interpreterProxy instantiateClass: interpreterProxy classArray indexableSize: nimages * 4.
	resultObj = 0 ifTrue:
		[^interpreterProxy primitiveFail].

	interpreterProxy pushRemappableOop: resultObj.
	0 to: nimages - 1 do:
		[:i|
		start := size := -1. "impossible start & size"
		name := self cCode: '_dyld_get_image_name(i)' inSmalltalk: [0].
		slide   := self cCode: '_dyld_get_image_vmaddr_slide(i)' inSmalltalk: [0].
		h        := self cCode: '_dyld_get_image_header(i)' inSmalltalk: [0].
		h ~= nil ifTrue:
			[s := self cCode: 'getsectbynamefromheader(h,SEG_TEXT,SECT_TEXT)' inSmalltalk: [0].
			 s ~= nil ifTrue:
				[start := self cCode: 's->addr' inSmalltalk: [0].
				 size := self cCode: 's->size' inSmalltalk: [0]]].

		valueObj := interpreterProxy
						instantiateClass: interpreterProxy classString
						indexableSize: (self cCode: 'strlen(name)' inSmalltalk: [name size]).
		interpreterProxy failed ifTrue:
			[interpreterProxy pop: 1.
			 ^interpreterProxy primitiveFail].
		interpreterProxy storePointer: i * 4 ofObject: interpreterProxy topRemappableOop withValue: valueObj.
		nameObjData := interpreterProxy arrayValueOf: valueObj.
		self cCode: 'memcpy(nameObjData, name, strlen(name))' inSmalltalk: [nameObjData].

		valueObj := interpreterProxy signed32BitIntegerFor: slide.
		interpreterProxy failed ifTrue:
			[interpreterProxy pop: 1.
			 ^interpreterProxy primitiveFail].
		interpreterProxy storePointer: i * 4 + 1 ofObject: interpreterProxy topRemappableOop withValue: valueObj.

		valueObj := interpreterProxy positive32BitIntegerFor: start.
		interpreterProxy failed ifTrue:
			[interpreterProxy pop: 1.
			 ^interpreterProxy primitiveFail].
		interpreterProxy storePointer: i * 4 + 2 ofObject: interpreterProxy topRemappableOop withValue: valueObj.

		valueObj := interpreterProxy positive32BitIntegerFor: size.
		interpreterProxy failed ifTrue:
			[interpreterProxy pop: 1.
			 ^interpreterProxy primitiveFail].
		interpreterProxy storePointer: i * 4 + 3 ofObject: interpreterProxy topRemappableOop withValue: valueObj].

	resultObj := interpreterProxy popRemappableOop.
	^interpreterProxy pop: 1 thenPush: resultObj