other filters
primitiveWhirl

	| inOop outOop width degrees in out sz height centerX centerY radius scaleX scaleY whirlRadians radiusSquared dx dy d factor ang sina cosa pix |
	<export: true>
	<var: 'in' declareC: 'unsigned int *in'>
	<var: 'out' declareC: 'unsigned int *out'>
	<var: 'scaleX' declareC: 'double scaleX'>
	<var: 'scaleY' declareC: 'double scaleY'>
	<var: 'whirlRadians' declareC: 'double whirlRadians'>
	<var: 'radiusSquared' declareC: 'double radiusSquared'>
	<var: 'dx' declareC: 'double dx'>
	<var: 'dy' declareC: 'double dy'>
	<var: 'd' declareC: 'double d'>
	<var: 'factor' declareC: 'double factor'>
	<var: 'ang' declareC: 'double ang'>
	<var: 'sina' declareC: 'double sina'>
	<var: 'cosa' declareC: 'double cosa'>

	inOop := interpreterProxy stackValue: 3.
	outOop := interpreterProxy stackValue: 2.
	width := interpreterProxy stackIntegerValue: 1.
	degrees := interpreterProxy stackIntegerValue: 0.
	in := self checkedUnsignedIntPtrOf: inOop.
	out := self checkedUnsignedIntPtrOf: outOop.
	sz := interpreterProxy stSizeOf: inOop.
	interpreterProxy success: ((interpreterProxy stSizeOf: outOop) = sz).
	interpreterProxy failed ifTrue: [^ nil].

	"calculate height, center, scales, radius, whirlRadians, and radiusSquared"
	height := sz // width.
	centerX := width // 2.
	centerY := height // 2.
	centerX < centerY
		ifTrue: [
			radius := centerX.
			scaleX := centerY asFloat / centerX. 
			scaleY := 1.0]
		ifFalse: [
			radius := centerY.
			scaleX := 1.0.
			centerY < centerX
				ifTrue: [scaleY := centerX asFloat / centerY]
				ifFalse: [scaleY := 1.0]].
	whirlRadians := (-3.141592653589793 * degrees) / 180.0.
	radiusSquared := (radius * radius) asFloat.

	0 to: width - 1 do: [:x |
		0 to: height - 1 do: [:y |
			dx := scaleX * (x - centerX) asFloat.
			dy := scaleY * (y - centerY) asFloat.
			d := (dx * dx) + (dy * dy).
			d < radiusSquared ifTrue: [  "inside the whirl circle"
				factor := 1.0 - (d sqrt / radius).
				ang := whirlRadians * (factor * factor).
				sina := ang sin.
				cosa := ang cos.
				pix := self interpolatedFrom: in
					x: (1024.0 * ((((cosa * dx) - (sina * dy)) / scaleX) + centerX)) asInteger
					y: (1024.0 * ((((sina * dx) + (cosa * dy)) / scaleY) + centerY)) asInteger
					width: width
					height: height.
				out at: ((width * y) + x "for Squeak: + 1") put: pix]]].

	interpreterProxy pop: 4.  "pop args, leave rcvr on stack"
	^ 0
