private-accessing
compiledMethodClassDefinition
	^MCAddition of: 
		(MCClassDefinition new
			initializeWithName: #CompiledMethod
			superclassName: #ByteArray
			category: #'Kernel-Methods'
			instVarNames: #()
			classVarNames: #(LargeFrame PrimaryBytecodeSetEncoderClass SecondaryBytecodeSetEncoderClass SmallFrame)
			poolDictionaryNames: #()
			classInstVarNames: #()
			type: #compiledMethod
			comment:
'CompiledMethod instances are methods suitable for interpretation by the virtual machine.  Instances of CompiledMethod and its subclasses are the only objects in the system that have both indexable pointer fields and indexable 8-bit integer fields.  The first part of a CompiledMethod is pointers, the second part is bytes.  CompiledMethod inherits from ByteArray to avoid duplicating some of ByteArray''s methods, not because a CompiledMethod is-a ByteArray.

Class variables:
SmallFrame								- the number of stack slots in a small frame Context
LargeFrame							- the number of stack slots in a large frame Context
PrimaryBytecodeSetEncoderClass		- the encoder class that defines the primary instruction set
SecondaryBytecodeSetEncoderClass	- the encoder class that defines the secondary instruction set

The current format of a CompiledMethod is as follows:

	header (4 or 8 bytes, SmallInteger)
	literals (4 or 8 bytes each, Object, see "The last literal..." below)
	bytecodes  (variable, bytes)
	trailer (variable, bytes)

The header is a SmallInteger (which in the 32-bit system has 31 bits, and in the 64-bit system, 61 bits) in the following format:

	(index 0)		15 bits:	number of literals (#numLiterals)
	(index 15)		  1 bit:	is optimized - reserved for methods that have been optimized by Sista
	(index 16)		  1 bit:	has primitive
	(index 17)		  1 bit:	whether a large frame size is needed (#frameSize => either SmallFrame or LargeFrame)
	(index 18)		  6 bits:	number of temporary variables (#numTemps)
	(index 24)		  4 bits:	number of arguments to the method (#numArgs)
	(index 28)		  2 bits:	reserved for an access modifier (00-unused, 01-private, 10-protected, 11-public), although accessors for bit 29 exist (see #flag).
	sign bit:			  1 bit: selects the instruction set, >= 0 Primary, < 0 Secondary (#signFlag)

If the method has a primitive then the first bytecode of the method must be a callPrimitive: bytecode that encodes the primitive index.

The trailer is an encoding of an instance of CompiledMethodTrailer.  It is typically used to encode the index into the source files array of the method''s source, but may be used to encode other values, e.g. tempNames, source as a string, etc.  See the class CompiledMethodTrailer.

The last literal in a CompiledMethod must be its methodClassAssociation, a binding whose value is the class the method is installed in.  The methodClassAssociation is used to implement super sends.  If a method contains no super send then its methodClassAssociation may be nil (as would be the case for example of methods providing a pool of inst var accessors).  By convention the penultimate literal of a method is either its selector or an instance of AdditionalMethodState.  AdditionalMethodState holds any pragmas and properties of a method, but may also be used to add instance variables to a method, albeit ones held in the method''s AdditionalMethodState.  Subclasses of CompiledMethod that want to add state should subclass AdditionalMethodState to add the state they want, and implement methodPropertiesClass on the class side of the CompiledMethod subclass to answer the specialized subclass of AdditionalMethodState.'
			commentStamp: 'eem 1/22/2015 15:47')