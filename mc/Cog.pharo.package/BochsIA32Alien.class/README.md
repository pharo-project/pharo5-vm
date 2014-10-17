I am a wrapper around the Bochs C++ IA32 CPU emulator.  Note that currently I provide no access to the x87/mmx FPU state, only providing access to the SSE/xmm registers.

Here is the configure script for the configuration this code assumes.  Offsets of fields will change with different configurations so they must agree.

----8<---- conf.COG ----8<----
#!/bin/sh

# this sets up the compile for Cog.  Disable as much inessential stuff
# as possible leaving only the cpu/fpu & memory interface

set echo
# CFLAGS="-pipe -O3 -fomit-frame-pointer -finline-functions -falign-loops=16 -falign-jumps=16 -falign-functions=16 -falign-labels=16 -falign-loops-max-skip=15 -falign-jumps-max-skip=15 -fprefetch-loop-arrays $CFLAGS"
CFLAGS="-m32 $CFLAGS"
CFLAGS="-Dlongjmp=_longjmp -Dsetjmp=_setjmp $CFLAGS"
CFLAGS="-pipe -O3 -fomit-frame-pointer -finline-functions $CFLAGS"
CFLAGS="-g $CFLAGS"
CPATH="/sw/include"
CPPFLAGS=""
CXXFLAGS="$CFLAGS"
LDFLAGS="-L/sw/lib"

export CFLAGS
export CPATH
export CPPFLAGS
export CXXFLAGS
export LDFLAGS

./configure --enable-Cog \
	--enable-cpu-level=6 \
	--enable-sse=2 \
	--enable-assert-checks \
	--with-nogui \
		--disable-x86-64 \
		--disable-pae \
		--disable-large-pages \
		--disable-global-pages \
		--disable-mtrr \
		--disable-sb16 \
		--disable-ne2000 \
		--disable-pci \
		--disable-acpi \
		--disable-apic \
		--disable-clgd54xx \
		--disable-usb \
		--disable-plugins \
	${CONFIGURE_ARGS}

# apic == Advanced programmable Interrupt Controller
# acpi == Advanced Configuration and Power Interface
# pci == Peripheral Component Interconnect local bus
# clgd54xx == Cirrus Logic GD54xx video card
----8<---- conf.COG ----8<----