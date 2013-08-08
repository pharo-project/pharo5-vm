testing
testPrimJPEGReadImage

	| form |
	form := JPEGReadWriter2 formFromStream: self formBytes readStream.
	self should: form bits first = 16rFF808080

"[Vm-dev] JPEGReadWriter2Plugin
Bert Freudenberg bert at freudenbergs.de
Mon Sep 27 15:22:43 UTC 2010

Hi,

have there been changes lately to the jpeg plugin?

On a Mac 4.2.4 VM I see an off-by-one error, all pixels are moved to the right, the first pixel is transparent. On a Mac 5.8.1 Cog VM it works as expected though.

Here's my little test:

(JPEGReadWriter2 formFromStream: #[16rFF 16rD8 16rFF 16rE0 16r00 16r10 16r4A 16r46 16r49 16r46 16r00 16r01 16r01 16r01 16r00 16r48 16r00 16r48 16r00 16r00 16rFF 16rDB 16r00 16r43 16r00 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rFF 16rC2 16r00 16r0B 16r08 16r00 16r01 16r00 16r01 16r01 16r01 16r11 16r00 16rFF 16rC4 16r00 16r14 16r10 16r01 16r00 16r00 16r00 16r00 16r00 16r00 16r00 16r00 16r00 16r00 16r00 16r00 16r00 16r00 16r00 16r00 16rFF 16rDA 16r00 16r08 16r01 16r01 16r00 16r01 16r3F 16r10] readStream) bits first hex

On 5.8.11 I get 16rFF808080 as expected, on 4.2.4 I get 0.
"