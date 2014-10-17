cleanup obsolete classes
checkClassHierarchyConsistencyFor: aClassDescription
	"Check whether aClassDescription has a consistent superclass and consistent regular and obsolete
	subclasses"

	| mySuperclass |
	mySuperclass := aClassDescription superclass.
	(mySuperclass subclasses includes: aClassDescription) = aClassDescription isObsolete
			ifTrue: [self error: 'Something wrong!'].
	mySuperclass ifNil: [^ self].  "Obsolete subclasses of nil cannot be stored"
	(mySuperclass obsoleteSubclasses includes: aClassDescription) = aClassDescription isObsolete
			ifFalse: [self error: 'Something wrong!'].

	aClassDescription subclasses do: [:each |
		each isObsolete ifTrue: [self error: 'Something wrong!'].
		each superclass == aClassDescription ifFalse: [self error: 'Something wrong!']
	].
	aClassDescription obsoleteSubclasses do: [:each |
		each isObsolete ifFalse: [self error: 'Something wrong!'].
		each superclass == aClassDescription ifFalse: [self error: 'Something wrong!']
	].