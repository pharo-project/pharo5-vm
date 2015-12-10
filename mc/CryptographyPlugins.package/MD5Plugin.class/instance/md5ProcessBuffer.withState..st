generated
md5ProcessBuffer: buffer withState: state
	"This method is generated. See #compileMethods on the class side."
	
	| a b c d |
	<static: false>
	<var: #buffer type: #'unsigned int*'>
	<var: #state type: #'unsigned int*'>
	<var: #a type: #'unsigned int'>
	<var: #b type: #'unsigned int'>
	<var: #c type: #'unsigned int'>
	<var: #d type: #'unsigned int'>
	a := state at: 0.
	b := state at: 1.
	c := state at: 2.
	d := state at: 3.
	a := a + (((b bitAnd: c) bitOr: (b bitInvert32 bitAnd: d)) + (buffer at: 0) + 3614090360).
	a := ((a << 7) bitOr: (a >> (32 - 7))) + b.
	d := d + (((a bitAnd: b) bitOr: (a bitInvert32 bitAnd: c)) + (buffer at: 1) + 3905402710).
	d := ((d << 12) bitOr: (d >> (32 - 12))) + a.
	c := c + (((d bitAnd: a) bitOr: (d bitInvert32 bitAnd: b)) + (buffer at: 2) + 606105819).
	c := ((c << 17) bitOr: (c >> (32 - 17))) + d.
	b := b + (((c bitAnd: d) bitOr: (c bitInvert32 bitAnd: a)) + (buffer at: 3) + 3250441966).
	b := ((b << 22) bitOr: (b >> (32 - 22))) + c.
	a := a + (((b bitAnd: c) bitOr: (b bitInvert32 bitAnd: d)) + (buffer at: 4) + 4118548399).
	a := ((a << 7) bitOr: (a >> (32 - 7))) + b.
	d := d + (((a bitAnd: b) bitOr: (a bitInvert32 bitAnd: c)) + (buffer at: 5) + 1200080426).
	d := ((d << 12) bitOr: (d >> (32 - 12))) + a.
	c := c + (((d bitAnd: a) bitOr: (d bitInvert32 bitAnd: b)) + (buffer at: 6) + 2821735955).
	c := ((c << 17) bitOr: (c >> (32 - 17))) + d.
	b := b + (((c bitAnd: d) bitOr: (c bitInvert32 bitAnd: a)) + (buffer at: 7) + 4249261313).
	b := ((b << 22) bitOr: (b >> (32 - 22))) + c.
	a := a + (((b bitAnd: c) bitOr: (b bitInvert32 bitAnd: d)) + (buffer at: 8) + 1770035416).
	a := ((a << 7) bitOr: (a >> (32 - 7))) + b.
	d := d + (((a bitAnd: b) bitOr: (a bitInvert32 bitAnd: c)) + (buffer at: 9) + 2336552879).
	d := ((d << 12) bitOr: (d >> (32 - 12))) + a.
	c := c + (((d bitAnd: a) bitOr: (d bitInvert32 bitAnd: b)) + (buffer at: 10) + 4294925233).
	c := ((c << 17) bitOr: (c >> (32 - 17))) + d.
	b := b + (((c bitAnd: d) bitOr: (c bitInvert32 bitAnd: a)) + (buffer at: 11) + 2304563134).
	b := ((b << 22) bitOr: (b >> (32 - 22))) + c.
	a := a + (((b bitAnd: c) bitOr: (b bitInvert32 bitAnd: d)) + (buffer at: 12) + 1804603682).
	a := ((a << 7) bitOr: (a >> (32 - 7))) + b.
	d := d + (((a bitAnd: b) bitOr: (a bitInvert32 bitAnd: c)) + (buffer at: 13) + 4254626195).
	d := ((d << 12) bitOr: (d >> (32 - 12))) + a.
	c := c + (((d bitAnd: a) bitOr: (d bitInvert32 bitAnd: b)) + (buffer at: 14) + 2792965006).
	c := ((c << 17) bitOr: (c >> (32 - 17))) + d.
	b := b + (((c bitAnd: d) bitOr: (c bitInvert32 bitAnd: a)) + (buffer at: 15) + 1236535329).
	b := ((b << 22) bitOr: (b >> (32 - 22))) + c.
	a := a + (((b bitAnd: d) bitOr: (c bitAnd: d bitInvert32)) + (buffer at: 1) + 4129170786).
	a := ((a << 5) bitOr: (a >> (32 - 5))) + b.
	d := d + (((a bitAnd: c) bitOr: (b bitAnd: c bitInvert32)) + (buffer at: 6) + 3225465664).
	d := ((d << 9) bitOr: (d >> (32 - 9))) + a.
	c := c + (((d bitAnd: b) bitOr: (a bitAnd: b bitInvert32)) + (buffer at: 11) + 643717713).
	c := ((c << 14) bitOr: (c >> (32 - 14))) + d.
	b := b + (((c bitAnd: a) bitOr: (d bitAnd: a bitInvert32)) + (buffer at: 0) + 3921069994).
	b := ((b << 20) bitOr: (b >> (32 - 20))) + c.
	a := a + (((b bitAnd: d) bitOr: (c bitAnd: d bitInvert32)) + (buffer at: 5) + 3593408605).
	a := ((a << 5) bitOr: (a >> (32 - 5))) + b.
	d := d + (((a bitAnd: c) bitOr: (b bitAnd: c bitInvert32)) + (buffer at: 10) + 38016083).
	d := ((d << 9) bitOr: (d >> (32 - 9))) + a.
	c := c + (((d bitAnd: b) bitOr: (a bitAnd: b bitInvert32)) + (buffer at: 15) + 3634488961).
	c := ((c << 14) bitOr: (c >> (32 - 14))) + d.
	b := b + (((c bitAnd: a) bitOr: (d bitAnd: a bitInvert32)) + (buffer at: 4) + 3889429448).
	b := ((b << 20) bitOr: (b >> (32 - 20))) + c.
	a := a + (((b bitAnd: d) bitOr: (c bitAnd: d bitInvert32)) + (buffer at: 9) + 568446438).
	a := ((a << 5) bitOr: (a >> (32 - 5))) + b.
	d := d + (((a bitAnd: c) bitOr: (b bitAnd: c bitInvert32)) + (buffer at: 14) + 3275163606).
	d := ((d << 9) bitOr: (d >> (32 - 9))) + a.
	c := c + (((d bitAnd: b) bitOr: (a bitAnd: b bitInvert32)) + (buffer at: 3) + 4107603335).
	c := ((c << 14) bitOr: (c >> (32 - 14))) + d.
	b := b + (((c bitAnd: a) bitOr: (d bitAnd: a bitInvert32)) + (buffer at: 8) + 1163531501).
	b := ((b << 20) bitOr: (b >> (32 - 20))) + c.
	a := a + (((b bitAnd: d) bitOr: (c bitAnd: d bitInvert32)) + (buffer at: 13) + 2850285829).
	a := ((a << 5) bitOr: (a >> (32 - 5))) + b.
	d := d + (((a bitAnd: c) bitOr: (b bitAnd: c bitInvert32)) + (buffer at: 2) + 4243563512).
	d := ((d << 9) bitOr: (d >> (32 - 9))) + a.
	c := c + (((d bitAnd: b) bitOr: (a bitAnd: b bitInvert32)) + (buffer at: 7) + 1735328473).
	c := ((c << 14) bitOr: (c >> (32 - 14))) + d.
	b := b + (((c bitAnd: a) bitOr: (d bitAnd: a bitInvert32)) + (buffer at: 12) + 2368359562).
	b := ((b << 20) bitOr: (b >> (32 - 20))) + c.
	a := a + (((b bitXor: c) bitXor: d) + (buffer at: 5) + 4294588738).
	a := ((a << 4) bitOr: (a >> (32 - 4))) + b.
	d := d + (((a bitXor: b) bitXor: c) + (buffer at: 8) + 2272392833).
	d := ((d << 11) bitOr: (d >> (32 - 11))) + a.
	c := c + (((d bitXor: a) bitXor: b) + (buffer at: 11) + 1839030562).
	c := ((c << 16) bitOr: (c >> (32 - 16))) + d.
	b := b + (((c bitXor: d) bitXor: a) + (buffer at: 14) + 4259657740).
	b := ((b << 23) bitOr: (b >> (32 - 23))) + c.
	a := a + (((b bitXor: c) bitXor: d) + (buffer at: 1) + 2763975236).
	a := ((a << 4) bitOr: (a >> (32 - 4))) + b.
	d := d + (((a bitXor: b) bitXor: c) + (buffer at: 4) + 1272893353).
	d := ((d << 11) bitOr: (d >> (32 - 11))) + a.
	c := c + (((d bitXor: a) bitXor: b) + (buffer at: 7) + 4139469664).
	c := ((c << 16) bitOr: (c >> (32 - 16))) + d.
	b := b + (((c bitXor: d) bitXor: a) + (buffer at: 10) + 3200236656).
	b := ((b << 23) bitOr: (b >> (32 - 23))) + c.
	a := a + (((b bitXor: c) bitXor: d) + (buffer at: 13) + 681279174).
	a := ((a << 4) bitOr: (a >> (32 - 4))) + b.
	d := d + (((a bitXor: b) bitXor: c) + (buffer at: 0) + 3936430074).
	d := ((d << 11) bitOr: (d >> (32 - 11))) + a.
	c := c + (((d bitXor: a) bitXor: b) + (buffer at: 3) + 3572445317).
	c := ((c << 16) bitOr: (c >> (32 - 16))) + d.
	b := b + (((c bitXor: d) bitXor: a) + (buffer at: 6) + 76029189).
	b := ((b << 23) bitOr: (b >> (32 - 23))) + c.
	a := a + (((b bitXor: c) bitXor: d) + (buffer at: 9) + 3654602809).
	a := ((a << 4) bitOr: (a >> (32 - 4))) + b.
	d := d + (((a bitXor: b) bitXor: c) + (buffer at: 12) + 3873151461).
	d := ((d << 11) bitOr: (d >> (32 - 11))) + a.
	c := c + (((d bitXor: a) bitXor: b) + (buffer at: 15) + 530742520).
	c := ((c << 16) bitOr: (c >> (32 - 16))) + d.
	b := b + (((c bitXor: d) bitXor: a) + (buffer at: 2) + 3299628645).
	b := ((b << 23) bitOr: (b >> (32 - 23))) + c.
	a := a + ((c bitXor: (b bitOr: d bitInvert32)) + (buffer at: 0) + 4096336452).
	a := ((a << 6) bitOr: (a >> (32 - 6))) + b.
	d := d + ((b bitXor: (a bitOr: c bitInvert32)) + (buffer at: 7) + 1126891415).
	d := ((d << 10) bitOr: (d >> (32 - 10))) + a.
	c := c + ((a bitXor: (d bitOr: b bitInvert32)) + (buffer at: 14) + 2878612391).
	c := ((c << 15) bitOr: (c >> (32 - 15))) + d.
	b := b + ((d bitXor: (c bitOr: a bitInvert32)) + (buffer at: 5) + 4237533241).
	b := ((b << 21) bitOr: (b >> (32 - 21))) + c.
	a := a + ((c bitXor: (b bitOr: d bitInvert32)) + (buffer at: 12) + 1700485571).
	a := ((a << 6) bitOr: (a >> (32 - 6))) + b.
	d := d + ((b bitXor: (a bitOr: c bitInvert32)) + (buffer at: 3) + 2399980690).
	d := ((d << 10) bitOr: (d >> (32 - 10))) + a.
	c := c + ((a bitXor: (d bitOr: b bitInvert32)) + (buffer at: 10) + 4293915773).
	c := ((c << 15) bitOr: (c >> (32 - 15))) + d.
	b := b + ((d bitXor: (c bitOr: a bitInvert32)) + (buffer at: 1) + 2240044497).
	b := ((b << 21) bitOr: (b >> (32 - 21))) + c.
	a := a + ((c bitXor: (b bitOr: d bitInvert32)) + (buffer at: 8) + 1873313359).
	a := ((a << 6) bitOr: (a >> (32 - 6))) + b.
	d := d + ((b bitXor: (a bitOr: c bitInvert32)) + (buffer at: 15) + 4264355552).
	d := ((d << 10) bitOr: (d >> (32 - 10))) + a.
	c := c + ((a bitXor: (d bitOr: b bitInvert32)) + (buffer at: 6) + 2734768916).
	c := ((c << 15) bitOr: (c >> (32 - 15))) + d.
	b := b + ((d bitXor: (c bitOr: a bitInvert32)) + (buffer at: 13) + 1309151649).
	b := ((b << 21) bitOr: (b >> (32 - 21))) + c.
	a := a + ((c bitXor: (b bitOr: d bitInvert32)) + (buffer at: 4) + 4149444226).
	a := ((a << 6) bitOr: (a >> (32 - 6))) + b.
	d := d + ((b bitXor: (a bitOr: c bitInvert32)) + (buffer at: 11) + 3174756917).
	d := ((d << 10) bitOr: (d >> (32 - 10))) + a.
	c := c + ((a bitXor: (d bitOr: b bitInvert32)) + (buffer at: 2) + 718787259).
	c := ((c << 15) bitOr: (c >> (32 - 15))) + d.
	b := b + ((d bitXor: (c bitOr: a bitInvert32)) + (buffer at: 9) + 3951481745).
	b := ((b << 21) bitOr: (b >> (32 - 21))) + c.
	state at: 0 put: (state at: 0) + a.
	state at: 1 put: (state at: 1) + b.
	state at: 2 put: (state at: 2) + c.
	state at: 3 put: (state at: 3) + d.