class initialization
ensureInSpecialObjectsArray
	"Alien must be in the specialObjectsArray to enable the Newsqueak FFI.  Because of
	 the bootstrap the specialObjectsArray may already have been partially initialized with
	 the callback selector and to be large enough (as part of loading immutability), but
	 it will be missing Alien until Alien is loaded.  So check if the specialObjectsArray is
	 of the expected size before recreating and slam Alien in if the specialObjectsArray
	 is already large enough."

	| index registeredObject pool |
	
	"older version of vmmaker defines ClassAlien in own pool, while newer in VMObjectIndices shared pool "
	
	"be sure it is initialized before we accessing these values"
	Smalltalk at: #ObjectMemory ifPresent: [:om | om initializeSpecialObjectIndices ].
	
	pool := Smalltalk at: #VMObjectIndices ifAbsent: [ 
		Smalltalk at: #ObjectMemory ifAbsent: nil ].
	
	index := self specialObjectsArrayIndex.
	
	"if pool is nil, we should just ignore and install.. "
	(pool notNil and: [(pool classPool at: #ClassAlien ifAbsent: []) ~~ (index - 1)]) ifTrue:
		[self error: 'index probably wrong'].

	(Smalltalk specialObjectsArray at: self specialObjectsArrayIndex ifAbsent: [nil]) == nil ifTrue:
		[Smalltalk recreateSpecialObjectsArray].

	registeredObject := Smalltalk specialObjectsArray at: index ifAbsent: [nil].
	
	(registeredObject == nil 
	 or: [registeredObject ~~ nil
		and: [registeredObject ~~ self]]) ifTrue:
		[self error: 'SmalltalkImage>>recreateSpecialObjectsArray appears incompatible'].

	registeredObject == nil ifTrue:
		[Smalltalk specialObjectsArray at: index put: self]