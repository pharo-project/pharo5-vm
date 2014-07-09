cleanup obsolete classes
cleanupClassHierarchyFor: aClassDescription
	| myName mySuperclass |
	mySuperclass := aClassDescription superclass.
	(self isReallyObsolete: aClassDescription)
		ifTrue: [ 
			"Remove class >>>from SystemDictionary if it is obsolete"
			myName := aClassDescription name asString.
			Smalltalk keys asArray
				do: [ :each | 
					(each asString = myName and: [ (Smalltalk globals at: each) == aClassDescription ])
						ifTrue: [ Smalltalk removeKey: each ] ].	"Make class officially obsolete if it is not"
			(aClassDescription name asString beginsWith: 'AnObsolete')
				ifFalse: [ aClassDescription obsolete ].
			aClassDescription isObsolete
				ifFalse: [ self error: 'Something wrong!' ].	"Add class to obsoleteSubclasses of its superclass"
			mySuperclass ifNil: [ self error: 'Obsolete subclasses of nil cannot be stored' ].
			(mySuperclass obsoleteSubclasses includes: aClassDescription)
				ifFalse: [ mySuperclass addObsoleteSubclass: aClassDescription ] ]
		ifFalse: [ 
			"check if superclass has aClassDescription in its obsolete subclasses"
			mySuperclass ifNil: [ mySuperclass := Class ].	"nil subclasses"
			mySuperclass removeObsoleteSubclass: aClassDescription ].	"And remove its obsolete subclasses if not actual superclass"
	aClassDescription obsoleteSubclasses
		do: [ :obs | 
			obs superclass == aClassDescription
				ifFalse: [ aClassDescription removeObsoleteSubclass: obs ] ]