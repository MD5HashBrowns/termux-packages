TERMUX_PKG_HOMEPAGE=http://proot.me/
TERMUX_PKG_DESCRIPTION="Emulate chroot, bind mount and binfmt_misc for non-root users"
# Just bump commit and version when needed:
_COMMIT=6c2b210e3887386a34bcafa154997aa03c291f7f
TERMUX_PKG_VERSION=5.1.101
TERMUX_PKG_SRCURL=https://github.com/termux/proot/archive/${_COMMIT}.zip
TERMUX_PKG_FOLDERNAME=proot-$_COMMIT
TERMUX_PKG_DEPENDS="libtalloc"

termux_step_pre_configure() {
	export LD=$CC
}

termux_step_make_install () {
	export CROSS_COMPILE=${TERMUX_HOST_PLATFORM}-

	cd $TERMUX_PKG_SRCDIR/src
	make V=1
	make install

	mkdir -p $TERMUX_PREFIX/share/man/man1
	cp $TERMUX_PKG_SRCDIR/doc/proot/man.1 $TERMUX_PREFIX/share/man/man1/proot.1

	cp $TERMUX_PKG_BUILDER_DIR/termux-chroot $TERMUX_PREFIX/bin/
}
