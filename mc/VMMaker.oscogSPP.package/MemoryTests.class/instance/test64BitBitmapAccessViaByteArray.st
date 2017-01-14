testing
test64BitBitmapAccessViaByteArray
	"MemoryTests new test64BitBitmapAccessViaByteArray"
	"(1 to: bits size) collect: [:i| (bits at: i) hex] #('16r23456700' '16rABCDEF01' '16r89' '16r0')"
	| bigPositive littlePositive bigNegative littleNegative |
	ByteArray adoptInstance: ((bigPositive := Bitmap new: 2)
									at: 1 put: 16r01234567;
									at: 2 put: 16r89ABCDEF;
									yourself).
	ByteArray adoptInstance: ((bigNegative := Bitmap new: 2)
									at: 1 put: 16rFEDCBA98;
									at: 2 put: 16r76543210;
									yourself).
	ByteArray adoptInstance: ((littlePositive := LittleEndianBitmap new: 2)
									at: 1 put: 16r89ABCDEF;
									at: 2 put: 16r01234567;
									yourself).
	ByteArray adoptInstance: ((littleNegative := LittleEndianBitmap new: 2)
									at: 1 put: 16r76543210;
									at: 2 put: 16rFEDCBA98;
									yourself).
	1 to: 8 do:
		[:i|
		(0 to: 7) do: [:j| | bytes bits | "In a true block so that one can restart"
			"BigEndian is just plain perverse, sigh..."
			i + j - 1 \\ 4 = 0 ifTrue:
				[(bytes := ByteArray new: 32)
					replaceFrom: i + j
					to: i + j + 7
					with: bigPositive
					startingAt: 1.
				Bitmap adoptInstance: (bits := bytes copy).
				self assert: 16r0123456789ABCDEF equals: (bits unsignedLong64At: i + j).
				self assert: 16r0123456789ABCDEF equals: (bits long64At: i + j).
				(bytes := ByteArray new: 32)
					replaceFrom: i + j
					to: i + j + 7
					with: bigNegative
					startingAt: 1.
				Bitmap adoptInstance: (bits := bytes copy).
				self assert: 16rFEDCBA9876543210 equals: (bits unsignedLong64At: i + j).
				self assert: (bits long64At: i + j) < 0.
				self assert: 16rFEDCBA9876543210 equals: ((bits long64At: i + j) bitAnd: 16rFFFFFFFFFFFFFFFF)].
			(bytes := ByteArray new: 32)
				replaceFrom: i + j
				to: i + j + 7
				with: littlePositive
				startingAt: 1.
			LittleEndianBitmap adoptInstance: (bits := bytes copy).
			self assert: 16r0123456789ABCDEF equals: (bits unsignedLong64At: i + j).
			self assert: 16r0123456789ABCDEF equals: (bits long64At: i + j).
			(bytes := ByteArray new: 32)
				replaceFrom: i + j
				to: i + j + 7
				with: littleNegative
				startingAt: 1.
			LittleEndianBitmap adoptInstance: (bits := bytes copy).
			self assert: 16rFEDCBA9876543210 equals: (bits unsignedLong64At: i + j).
			self assert: (bits long64At: i + j) < 0.
			self assert: 16rFEDCBA9876543210 equals: ((bits long64At: i + j) bitAnd: 16rFFFFFFFFFFFFFFFF)]]