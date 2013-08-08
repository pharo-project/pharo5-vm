tests
testMultiplicativeOperators
	"CogVMTests new setUp testMultiplicativeOperators"
	self runningOnCogit ifTrue:
		[thisContext xrayIsExecutingMachineCode ifFalse:
			[^self testMultiplicativeOperators]].
	1 to: 3 do: "Running 3 times should ensure all operators are compiled to machine code"
		[:ignored| | values |
		self assert: (1 / 2 literalEqual: (Fraction numerator: 1 denominator: 2)).
		self assert: 1 // 2 == 0.
		self assert: (1 quo: 2) == 0.
		self assert: 3 * 4 == 12.

		self assert: 65536 / 2 == 32768.
		self assert: 65536 // 2 == 32768.
		self assert: (65536 quo: 2) == 32768.
		self assert: 65536 * 2 == 131072.
		#(1 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536
		   131072 262144 524288 1048576 2097152 4194304 8388608 16777216 33554432
		   67108864 134217728 268435456 536870912 1073741824 2147483648 4294967296) withIndexDo:
			[:value :index| | power | "test that integer overflow is detected in multiplication"
			power := index - 1.
			self assert: value * value = (2 raisedTo: power + power)].

		self assert: SmallInteger minVal / -1 = (SmallInteger maxVal + 1).
		self assert: SmallInteger minVal // -1 = (SmallInteger maxVal + 1).
		self assert: (SmallInteger minVal quo: -1) = (SmallInteger maxVal + 1).
		self assert: (SmallInteger minVal \\ -1) = 0.

		values := Integer primesUpTo: 1000.
		values := (values reverse collect: [:ea| ea negated]), values.
		values do:
			[:dividend|
			values do:
				[:divisor|
				self assert: (dividend quo: divisor) * divisor + (dividend rem: divisor) = dividend.
				self assert: (dividend // divisor) * divisor + (dividend \\ divisor) = dividend]]]