translation
printTypedefOn: aStream
	aStream nextPutAll: 'typedef struct '.
	self needsTypeTag ifTrue:
		[aStream nextPutAll: self structTagName; space].
	aStream nextPut: ${; cr.
	self instVarNamesAndTypesForTranslationDo:
		[:ivn :typeArg| | type index |
		type := typeArg.
		(index := type indexOf: #BytesPerWord ifAbsent: 0) > 0 ifTrue:
			[type := (type at: index + 1) = BytesPerWord ifTrue:
						[type := type copyReplaceFrom: index to: index + 1 with: #().
						 type size = 1 ifTrue: [type first] ifFalse: [type]]].
		type ifNotNil:
			[type isArray
				ifTrue:
					[aStream tab: 1.
					aStream nextPutAll: type first.
					(type first last isSeparator or: [type first last = $*]) ifFalse:
						[aStream tab: 2].
					aStream nextPutAll: ivn.
					 type last first = $: ifTrue:
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
		[aStream cr; nextPutAll: '#define '; nextPutAll: self name; space; nextPutAll: self structTypeName; cr].
	aStream flush