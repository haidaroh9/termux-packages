TERMUX_PKG_HOMEPAGE=https://github.com/biomejs/biome
TERMUX_PKG_DESCRIPTION="performant toolchain for web projects"
TERMUX_PKG_LICENSE="Apache-2.0,MIT"
TERMUX_PKG_LICENSE_FILE="LICENSE-APACHE,LICENSE-MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.6.3"
TERMUX_PKG_SRCURL=https://github.com/biomejs/biome/archive/refs/tags/cli/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=306d7662994e06e23d25587246fa3fb1f528579e42a84f5128e75feec635a370

termux_step_make() {
	termux_setup_rust
	export JEMALLOC_SYS_WITH_LG_PAGE=16 
  RUSTFLAGS: "-C strip=symbols" cargo build --jobs $TERMUX_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

termux_step_make_install() {
	install -Dm700 -t $TERMUX_PREFIX/bin target/${CARGO_TARGET_NAME}/release/biome

}


	

