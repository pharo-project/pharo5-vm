public
computeKernelReturnTypes
	^Dictionary newFromPairs:
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
				long32At: #sqInt long32At:put: #sqInt

		 longLongAt: #sqLong longLongAt:put: #sqLong
			longLongAtPointer: #sqLong longLongAtPointer:put: #sqLong
				long64At: #sqLong long64At:put: #sqLong
		
		 fetchFloatAt:into: #void storeFloatAt:from: #void
			fetchFloatAtPointer:into: #void storeFloatAtPointer:from: #void
		 fetchSingleFloatAt:into: #void storeSingleFloatAt:from: #void
			fetchSingleFloatAtPointer:into: #void storeSingleFloatAtPointer:from: #void

		 pointerForOop: #'char *' oopForPointer: #sqInt)