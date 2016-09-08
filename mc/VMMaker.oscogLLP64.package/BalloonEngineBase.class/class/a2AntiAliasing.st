documentation
a2AntiAliasing
	"The engine currently used a very simple, but efficient anti-aliasing scheme. It is based on a square unweighted filter of size 1, 2, or 4 resulting in three levels of anti-aliasing:

	* No anti-aliasing (filter size 1)
	This simply draws each pixel 'as is' on the screen

	* Slight anti-aliasing (filter size 2)
	Doubles the rasterization size in each direction and assembles the pixel value as the medium of the four sub-pixels falling into the full pixel

	* Full anti-aliasing (filter size 4)
	Quadruples the rasterization in each direction and assembles the pixel value as the medium of the sixteen sub-pixels falling into the full pixel


The reason for using these three AA levels is simply efficiency of computing. Since the above filters (1x1, 2x2, 4x4) have all power of two elements (1, 4, and 16) we can compute the weighted sum of the final pixel by computing

	destColor := destColor + (srcColor // subPixels)

And, since we're only working on 32bit destination buffer we do not need to compute the components of each color separately but can neatly put the entire color into a single formula:

	destPixel32 := destPixel32 + ((srcPixel32 bitAnd: aaMask) >> aaShift).

with aaMask = 16rFFFFFFFF for aaLevel = 1, aaMask = 16rFCFCFCFC for aaLevel = 2, aaMask = 16rF0F0F0F0 for aaLevel = 4 and aaShift = 0, 2, or 4 for the different levels. However, while the above is efficient to compute, it also drops accuracy. So, for the 4x4 anti-aliasing we're effectively only using the high 4 bits of each color component. While is generally not a problem (we add 16 sub-pixels into this value) there is a simple arithmetic difficulty because the above cannot fill the entire range of values, e.g.,

	16 * (255 // 16) = 16 * 15 = 240

and not 255 as expected. We solve this problem by replicating the top n (n=0, 2, 4) bits of each component as the low bits in an adjustment step before blitting to scan line to the screen. This has the nice effect that a zero pixel value (e.g., transparent) will remain zero, a white pixel (as computed above) will result in a value of 255 for each component (defining opaque white) and each color inbetween linearly mapped between 0 and 255. 

"
	^self error:'Comment only'