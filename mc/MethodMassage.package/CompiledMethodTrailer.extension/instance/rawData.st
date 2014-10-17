*MethodMassage-raw data
rawData
	^(ByteArray new: size)
		replaceFrom: 1
		to: size
		with: method
		startingAt: method size - size + 1