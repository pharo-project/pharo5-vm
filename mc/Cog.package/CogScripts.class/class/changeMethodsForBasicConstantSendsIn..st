separate vm scripts
changeMethodsForBasicConstantSendsIn: aClass
	"CogScripts changedMethodsForBasicConstantSendsIn: StackInterpreter"
	| receiver rules model env |
	rules := RBParseTreeRewriter new.
	receiver := ((aClass includesBehavior: ObjectMemory)
				 or: [aClass includesBehavior: SpurMemoryManager])
					ifTrue: ['self']
					ifFalse:
						[#('objectMemory' 'manager' 'interpreterProxy') detect: [:ivn| (aClass instVarIndexFor: ivn ifAbsent: nil) notNil]].
	rules
		replace: 'BaseHeaderSize' with: receiver, ' baseHeaderSize';
		replace: 'BytesPerOop' with: receiver, ' bytesPerOop';
		replace: 'BytesPerWord' with: receiver, ' wordSize';
		replace: 'ShiftForWord' with: receiver, ' shiftForWord'.
	model := RBNamespace new.
	env := RBBrowserEnvironment new forClasses: { aClass }.
	env classesAndSelectorsDo:
		[ :class :selector | | tree |
		tree := class parseTreeFor: selector.
		(rules executeTree: tree) ifTrue:
			[model compile: rules tree newSource in: class classified: (class whichCategoryIncludesSelector: selector)]].

	model changes changes do:
		[:mr|
		aClass
			compile: mr source
			classified: (aClass whichCategoryIncludesSelector: mr selector)
			withStamp: (Utilities changeStamp copyReplaceAll: Utilities authorInitials with: Utilities authorInitials, ' (const to msg rewrite)')
			notifying: nil]