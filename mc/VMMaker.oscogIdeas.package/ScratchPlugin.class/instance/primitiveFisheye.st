other filters
primitiveFisheye

	| inOop outOop width in out sz height centerX centerY dx dy ang pix power r srcX srcY scaledPower |
	<export: true>
	<var: 'in' type: #'unsigned int *'>
	<var: 'out' type: #'unsigned int *'>
	<var: 'dx' type: #double>
	<var: 'dy' type: #double>
	<var: 'ang' type: #double>
	<var: 'r' type: #double>
	<var: 'scaledPower' type: #double>

	inOop := interpreterProxy stackValue: 3.
	outOop := interpreterProxy stackValue: 2.
	width := interpreterProxy stackIntegerValue: 1.
	power := interpreterProxy stackIntegerValue: 0.
	in := self checkedUnsignedIntPtrOf: inOop.
	out := self checkedUnsignedIntPtrOf: outOop.
	sz := interpreterProxy stSizeOf: inOop.
	interpreterProxy success: ((interpreterProxy stSizeOf: outOop) = sz).
	interpreterProxy failed ifTrue: [^ nil].

	"calculate height, center, scales, radius, whirlRadians, and radiusSquared"
	height := sz // width.
	centerX := width // 2.
	centerY := height // 2.

	height := sz // width.
	centerX := width // 2.
	centerY := height // 2.
	scaledPower := power / 100.0.

	0 to: width - 1 do: [:x |
		0 to: height - 1 do: [:y |
			dx := (x - centerX) / centerX asFloat.
			dy := (y - centerY) / centerY asFloat.
			r := ((dx * dx) + (dy * dy)) sqrt raisedTo: scaledPower.
			r <= 1.0
				ifTrue: [
					ang := self cCode: 'atan2(dy,dx)'.
					srcX := (1024 * (centerX + ((r * ang cos) * centerX))) asInteger.
					srcY := (1024 * (centerY + ((r * ang sin) * centerY))) asInteger]
				ifFalse: [
					srcX := 1024 * x.
					srcY := 1024 * y].
			pix := self interpolatedFrom: in
					x: srcX
					y: srcY
					width: width
					height: height.
			out at: ((y * width) + x "+ 1 for Squeak") put: pix]].

	interpreterProxy pop: 4.  "pop args, leave rcvr on stack"
	^ 0
