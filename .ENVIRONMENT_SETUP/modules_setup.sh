export GoochBiotoolRoot=/UCHC/HPC/Gooch/biotoolmodules
export PATH="$GoochBiotoolRoot/Modules/3.2.10/bin:$PATH"
export MODULEPATH=$GoochBiotoolRoot/modulefiles
export MANPATH=$(manpath)
export INFOPATH=":"

shell=`/bin/basename \`/bin/ps -p $$ -ocomm=\``

MODULE_INIT="/UCHC/HPC/Gooch/biotoolmodules/Modules/3.2.10/init"

if [ -f $MODULE_INIT/$shell ]
then
  . $MODULE_INIT/$shell
else
  . $MODULE_INIT/sh
fi

#export MODULES_DEBUG=1

module load autoconf \
binutils \
coreutils \
flex \
gmp \
gnu-make \
libtool \
mpfr \
automake \
cloog \
gcc \
gnu-m4 \
isl \
mpc \
texinfo \
ncurses \
libexpat \
libffi \
perl \
tcl \
tk \
libmpdec \
oraclejava \
diffutils \
gawk \
sed \
grep \
ghostscript \
cmake \
lapack \
cairo \
libjpeg \
libpng \
libsigc++ \
libtiff \
pixman \
pkg-config \
python3 \
python2 \
glib2 \
readline \
R \
c-ares \
libIDN \
libmetalink \
openssl \
libssh2 \
curl \
git \
check \
ATLAS \
libpipeline \
boost/1.55.0 \
eigen \
sam_tools/htslib \
sam_tools/samtools \
sam_tools/bcftools \
libxml2 \
asciidoc \
xz \
bzip2 \
llvm_suite \
tuxedo_tools/bowtie \
tuxedo_tools/bowtie2 \
tuxedo_tools/tophat \
tuxedo_tools/cufflinks

#shell/bash \
#shell/tcsh \
#shell/dash \
#man-db \

