bootstrap methods
modifyCharacterMethods
	| cc md mda |
	cc := oldHeap classCharacter.
	md := oldHeap fetchPointer: MethodDictionaryIndex ofObject: cc.
	mda := oldHeap fetchPointer: MethodArrayIndex ofObject: md..
	0 to: (oldHeap numSlotsOf: mda) - 1 do:
		[:i| | method |
		method := oldHeap fetchPointer: i ofObject: mda.
		method ~= oldHeap nilObject ifTrue:
			[(self replacementForCharacterMethod: method) ifNotNil:
				[:replacement|
				Transcript
					cr;
					nextPutAll: 'replacing Character>>#';
					nextPutAll: (oldHeap stringOf: (oldHeap fetchPointer: i + SelectorStart ofObject: md));
					flush. 
				oldHeap
					storePointer: i
					ofObject: mda
					withValue: replacement]]]