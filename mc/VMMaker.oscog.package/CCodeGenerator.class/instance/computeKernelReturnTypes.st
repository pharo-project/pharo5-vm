public
computeKernelReturnTypes
	| dictionary |
	dictionary := Dictionary newFromPairs:
		#(oopAt: #sqInt oopAt:put: #sqInt
			oopAtPointer: #sqInt oopAtPointer:put: #sqInt
		 byteAt: #sqInt byteAt:put: #sqInt
			byteAtPointer: #sqInt byteAtPointer:put: #sqInt
		 shortAt: #sqInt shortAt:put: #sqInt
			shortAtPointer: #sqInt shortAtPointer:put: #sqInt
		 intAt: #sqInt intAt:put: #sqInt
			intAtPointer: #sqInt intAtPointer:put: #sqInt
		 longAt: #sqInt longAt:put: #sqInt
			longAtPointer: #sqInt longAtPointer:put: #sqInt
				long32At: #int long32At:put: #int
					unalignedLongAt: #sqInt unalignedLongAt:put: #sqInt
						unalignedLong32At: #int unalignedLong32At:put: #int

		 long64At: #sqLong long64At:put: #sqLong
		 long64AtPointer: #sqLong long64AtPointer:put: #sqLong
	
		singleFloatAtPointer: #float singleFloatAtPointerPut: #float		
		floatAtPointer: #double floatAtPointerPut: #double
				
		 fetchFloatAt:into: #void storeFloatAt:from: #void
			fetchFloatAtPointer:into: #void storeFloatAtPointer:from: #void
		 fetchSingleFloatAt:into: #void storeSingleFloatAt:from: #void
			fetchSingleFloatAtPointer:into: #void storeSingleFloatAtPointer:from: #void

		 pointerForOop: #'char *' oopForPointer: #sqInt
		 baseHeaderSize #sqInt wordSize #sqInt bytesPerOop #sqInt).
	BytesPerWord = 8 ifTrue:
		[#(long32At: long32At:put: unalignedLong32At: unalignedLong32At:put:) do:
			[:accessor|
			dictionary at: accessor put: #int]].
	^dictionary