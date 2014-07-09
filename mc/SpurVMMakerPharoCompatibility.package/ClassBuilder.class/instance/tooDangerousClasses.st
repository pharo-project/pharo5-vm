private
tooDangerousClasses
	"Return a list of class names which will not be modified in the public interface"
	^#(
		"Object will break immediately"
		ProtoObject Object
		"Contexts and their superclasses"
		InstructionStream ContextPart MethodContext BlockClosure
		"Superclasses of basic collections"
		Collection SequenceableCollection ArrayedCollection
		"Collections known to the VM"
		Array Bitmap String Symbol ByteArray CompiledMethod
		"Basic Numbers"
		Magnitude Number SmallInteger Float
		"Misc other"
		LookupKey Association Link Point Rectangle Behavior PositionableStream UndefinedObject
	)
