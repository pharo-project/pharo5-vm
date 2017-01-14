translation
printTypedefOn: aStream
	aStream nextPutAll: 'typedef struct '.
	self needsTypeTag ifTrue:
		[aStream nextPutAll: self structTagName; space].
	aStream nextPut: ${; cr.
	self instVarNamesAndTypesForTranslationDo:
		[:ivn :typeArg| | type |
		type := typeArg.
		#(BytesPerWord BaseHeaderSize BytesPerOop) do:
			[:sizeConstant| | index sizeConstantSize |
			(type notNil
			and: [(index := type indexOf: sizeConstant ifAbsent: 0) > 0]) ifTrue:
				[sizeConstantSize  := VMBasicConstants classPool at: sizeConstant.
				type := (type at: index + 1) = sizeConstantSize ifTrue:
							[type := type copyReplaceFrom: index to: index + 1 with: #().
							 type size = 1 ifTrue: [type first] ifFalse: [type]]]].
		type ifNotNil:
			[type isArray
				ifTrue:
					[aStream tab: 1.
					 aStream nextPutAll: type first.
					 (type first last isSeparator or: [type first last = $*]) ifFalse:
						[aStream tab: 2].
					 aStream nextPutAll: ivn.
					 type last first isSeparator ifFalse:
						[aStream space].
					 aStream
						nextPutAll: type last;
						nextPut: $;;
						cr]
				ifFalse:
					[aStream tab: 1.
					 aStream nextPutAll: type.
					 (type last isSeparator or: [type last = $*]) ifFalse:
						[aStream tab: 1].
					 aStream
						nextPutAll: ivn;
						nextPut: $;;
						cr]]].
	aStream
		nextPutAll: ' } ';
		nextPutAll: self structTypeName;
		nextPut: $;;
		cr.
	self name ~= self structTypeName ifTrue:
		[(self withAllSuperclasses copyUpThrough: (self class whichClassIncludesSelector: #structTypeName) theNonMetaClass) do:
			[:structClass|
			 aStream cr; nextPutAll: '#define '; nextPutAll: structClass name; space; nextPutAll: self structTypeName].
		 aStream cr].
	aStream flush