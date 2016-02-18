bootstrap image
recreateSpecialObjectsArray
	"This is tricky.  We want to recreate the specialObjectsArray according to
	 the class side SmalltalkImagePROTOTYPErecreateSpecialObjectsArray.
	 But that version destroys the CompactClassesArray upon which the V3
	 image depends.  The bootstrap will get rid of it later.  So save it before
	 the recreation and restore it."
	self withExecutableInterpreter: oldInterpreter
		do: [| compactClassesArray |
			compactClassesArray := oldHeap splObj: CompactClasses.
			self
				interpreter: oldInterpreter
				object: (oldHeap splObj: 8)
				perform: (self findSymbol: #recreateSpecialObjectsArray)
				withArguments: #().
			oldHeap splObj: CompactClasses put: compactClassesArray]