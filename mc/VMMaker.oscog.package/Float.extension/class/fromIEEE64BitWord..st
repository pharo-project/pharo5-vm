*VMMaker-instance creation
fromIEEE64BitWord: anInteger
	| value |
	value := self basicNew: 2.
	value
		basicAt: 1 put: (anInteger bitShift: -32);
		basicAt: 2 put: (anInteger bitAnd: 16rFFFFFFFF).
	^value isFinite
		ifTrue: [value * 1.0] "reduce to SmallFloat64 if possible"
		ifFalse: [value]

	"[| r |
	 r := Random new.
	 100000 timesRepeat:
		[| h l f |
		h := (r next * 16r100000000) rounded bitAnd: 16rFFFFFFFF.
		l := (r next * 16r100000000) rounded bitAnd: 16rFFFFFFFF.
		f := Float fromIEEE64BitWord: (h bitShift: 32) + l.
		self assert: h = (f basicAt: 1).
		self assert: l = (f basicAt: 2)]] timeToRun"