HOWTO restore NativeBoost
=========================

NatiuveBoost was removed in Spur because we do not want executable memory anymore (and other maintainability issues). Here some notes if you want to restore it. 

Changes in VM
-------------
We need a couple of changes in the VM:

add setjmp.h in Cogit class>#declareCVarsIn:

	...
	aCCodeGenerator
		addHeaderFile:'<stddef.h>'; "for e.g. offsetof"
		addHeaderFile:'<setjmp.h>'; "<-- add this"
	...
	

add executable memory allocation:

in CoInterpreter>>#initStackPagesAndInterpret

	self cppIf: #PHAROVM_USE_EXECUTABLE_MEMORY 
		ifTrue:  [
			self 
				sqMakeMemoryExecutableFrom: objectMemory startOfMemory asUnsignedInteger
				To: objectMemory memoryLimit asUnsignedInteger ]
		ifFalse: [ 
			self 
				sqMakeMemoryNotExecutableFrom: objectMemory startOfMemory asUnsignedInteger
				To: objectMemory memoryLimit asUnsignedInteger ].
	self 
		sqMakeMemoryNotExecutableFrom: theStackMemory asUnsignedInteger
		To: theStackMemory asUnsignedInteger + stackPagesBytes.

in Spur32BitCoMemoryManager>>#assimilateNewSegment:

	self 
		cppIf: #PHAROVM_USE_EXECUTABLE_MEMORY
		ifTrue: [ coInterpreter sqMakeMemoryExecutableFrom: segInfo segStart To: segInfo segLimit ]
		ifFalse: [ coInterpreter sqMakeMemoryNotExecutableFrom: segInfo segStart To: segInfo segLimit ]

in CMakeMaker
-------------

take NBCogCocoaIOSConfig, NBCogUnixConfig and NBCogWindowsConfig as models

