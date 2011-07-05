if [ -f $1 ]
then
exit 0
fi

if [ ! -d freetype2 ]
then
  git clone git://git.sv.gnu.org/freetype/freetype2.git freetype2
fi

cd freetype2
git checkout VER-2-4-4

/bin/sh autogen.sh
./configure CFLAGS="-arch i386" LDFLAGS="-arch i386" --without-zlib

make clean
make
cd ..
cp ./freetype2/objs/.libs/libfreetype.a $1


