ad-hoc tests
testObjStackDo
	| size them seqA seqB seqC rs |
	ExpensiveAsserts := true.
	self initializeWeaklingStack; emptyObjStack: weaklingStack.
	self assert: (self topOfObjStack: weaklingStack) isNil.
	self assert: (self capacityOfObjStack: weaklingStack) >= ObjStackLimit.
	seqA := (1 to: ObjStackLimit * 5 // 2) collect: [:i| self integerObjectOf: i].
	seqA do: [:it| self noCheckPush: it onObjStack: weaklingStack].
	them := Set new.
	size := self objStack: weaklingStack from: 0 do: [:it| them add: it].
	self assert: size = seqA size.
	self assert: (them asSortedCollection asArray = seqA).
	self assert: (self isValidObjStack: weaklingStack).
	seqB := (ObjStackLimit * 5 // 2 + 1 to: ObjStackLimit * 10 // 2) collect: [:i| self integerObjectOf: i].
	self assert: seqA size = seqB size.
	rs := seqB readStream.
	them := Set new.
	size := self objStack: weaklingStack from: 0 do:
				[:it|
				them add: it.
				self noCheckPush: rs next onObjStack: weaklingStack].
	self assert: size = seqA size.
	self assert: rs atEnd.
	self objStack: weaklingStack from: size do:
		[:it| them add: it].
	seqC := (seqA, seqB) sort.
	self assert: them asSortedCollection asArray = seqC