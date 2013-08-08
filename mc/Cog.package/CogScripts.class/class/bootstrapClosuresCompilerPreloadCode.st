closure scripts
bootstrapClosuresCompilerPreloadCode
	^'
!ClassBuilder methodsFor: ''class format'' stamp: ''eem 6/13/2008 10:03''!
computeFormat: type instSize: newInstSize forSuper: newSuper ccIndex: ccIndex
	"Compute the new format for making oldClass a subclass of newSuper.
	Return the format or nil if there is any problem."
	| instSize isVar isWords isPointers isWeak |
	type == #compiledMethod
		ifTrue:[^CompiledMethod format].
	instSize := newInstSize + (newSuper ifNil:[0] ifNotNil:[newSuper instSize]).
	instSize > 254 ifTrue:[
		self error: ''Class has too many instance variables ('', instSize printString,'')''.
		^nil].
	type == #normal ifTrue:[isVar := isWeak := false. isWords := isPointers := true].
	type == #bytes ifTrue:[isVar := true. isWords := isPointers := isWeak := false].
	type == #words ifTrue:[isVar := isWords := true. isPointers := isWeak := false].
	type == #variable ifTrue:[isVar := isPointers := isWords := true. isWeak := false].
	type == #weak ifTrue:[isVar := isWeak := isWords := isPointers := true].
	(isPointers not and:[instSize > 0]) ifTrue:[
		self error:''A non-pointer class cannot have instance variables''.
		^nil].
	^(self format: instSize 
		variable: isVar 
		words: isWords 
		pointers: isPointers 
		weak: isWeak) + (ccIndex bitShift: 11).! !

!ClassBuilder methodsFor: ''public'' stamp: ''eem 6/13/2008 10:00''!
superclass: aClass
	variableByteSubclass: t instanceVariableNames: f 
	classVariableNames: d poolDictionaries: s category: cat
	"This is the standard initialization message for creating a new class as a 
	subclass of an existing class in which the subclass is to 
	have indexable byte-sized nonpointer variables."
	| oldClassOrNil actualType |
	(aClass instSize > 0)
		ifTrue: [^self error: ''cannot make a byte subclass of a class with named fields''].
	(aClass isVariable and: [aClass isWords])
		ifTrue: [^self error: ''cannot make a byte subclass of a class with word fields''].
	(aClass isVariable and: [aClass isPointers])
		ifTrue: [^self error: ''cannot make a byte subclass of a class with pointer fields''].
	oldClassOrNil := aClass environment at: t ifAbsent:[nil].
	actualType := (oldClassOrNil notNil
				   and: [oldClassOrNil typeOfClass == #compiledMethod])
					ifTrue: [#compiledMethod]
					ifFalse: [#bytes].
	^self 
		name: t
		inEnvironment: aClass environment
		subclassOf: aClass
		type: actualType
		instanceVariableNames: f
		classVariableNames: d
		poolDictionaries: s
		category: cat! !

!Array methodsFor: ''testing'' stamp: ''eem 5/8/2008 11:13''!
isArray
	^true! !

!Object methodsFor: ''testing'' stamp: ''eem 5/8/2008 11:13''!
isArray
	^false! !

!Behavior methodsFor: ''compiling'' stamp: ''eem 5/13/2008 09:50''!
instVarNamesAndOffsetsDo: aBinaryBlock
	"This is part of the interface between the compiler and a class''s instance or field names.
	 The class should enumerate aBinaryBlock with the instance variable name strings and
	 their integer offsets.  The order is important. Names evaluated later will override the
	 same names occurring earlier."

	"Nothing to do here; ClassDescription introduces named instance variables"
	^self! !

!ClassDescription methodsFor: ''compiling'' stamp: ''eem 5/13/2008 09:48''!
instVarNamesAndOffsetsDo: aBinaryBlock
	"This is part of the interface between the compiler and a class''s instance or field names.
	 The class should enumerate aBinaryBlock with the instance variable name strings and
	 their integer offsets.  The order is important. Names evaluated later will override the
	 same names occurring earlier."

	| superInstSize |
	(superInstSize := superclass notNil ifTrue: [superclass instSize] ifFalse: [0]) > 0 ifTrue:
		[superclass instVarNamesAndOffsetsDo: aBinaryBlock].
	1 to: self instSize - superInstSize do:
		[:i| aBinaryBlock value: (instanceVariables at: i) value: i + superInstSize]! !


!Behavior methodsFor: ''compiling'' stamp: ''eem 5/13/2008 09:50''!
variablesAndOffsetsDo: aBinaryBlock
	"This is the interface between the compiler and a class''s instance or field names.  The
	 class should enumerate aBinaryBlock with the field definitions (with nil offsets) followed
	 by the instance variable name strings and their integer offsets.  The order is important.
	 Names evaluated later will override the same names occurring earlier."

	"Only need to do instance variables here.  CProtoObject introduces field definitions."
	self instVarNamesAndOffsetsDo: aBinaryBlock! !

!CProtoObject class methodsFor: ''compiling'' stamp: ''eem 5/13/2008 09:53''!
variablesAndOffsetsDo: aBinaryBlock
	"This is the interface between the compiler and a class''s instance or field names.  The
	 class should enumerate aBinaryBlock with the field definitions (with nil offsets) followed
	 by the instance variable name strings and their integer offsets.  The order is important.
	 Names evaluated later will override the same names occurring earlier."

	self allFieldsReverseDo: [:field| aBinaryBlock value: field value: nil].
	self instVarNamesAndOffsetsDo: aBinaryBlock! !'