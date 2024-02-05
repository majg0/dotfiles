VERSION=3.28.3
NAME=cmake-$VERSION-linux-x86_64
wget -c https://github.com/Kitware/CMake/releases/download/v$VERSION/$NAME.tar.gz -O - | tar -xz
mv $NAME cmake
