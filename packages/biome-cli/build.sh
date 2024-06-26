TERMUX_PKG_HOMEPAGE=https://github.com/biomejs/biome
TERMUX_PKG_DESCRIPTION="performant toolchain for web projects"
TERMUX_PKG_LICENSE="Apache-2.0,MIT"
TERMUX_PKG_LICENSE_FILE="LICENSE-APACHE,LICENSE-MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.6.4"
TERMUX_PKG_DEPENDS="zlib"
TERMUX_PKG_SRCURL=https://github.com/biomejs/biome/archive/refs/tags/cli/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=a613e2f782bb93e1dfa2b03d09d8c8f74020704dd218e50e17d7e9af97c0d4f7
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
RUSTFLAGS+=" -C link-arg=$(${CC} -print-libgcc-file-name)"
termux_setup_rust

	: "${CARGO_HOME:=$HOME/.cargo}"
	export CARGO_HOME

	cargo fetch --target "${CARGO_TARGET_NAME}"


 }

termux_step_make() {

	export JEMALLOC_SYS_WITH_LG_PAGE=16
 
	cargo build --jobs $TERMUX_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}


termux_step_make_install() {
	install -Dm700 -t $TERMUX_PREFIX/bin target/${CARGO_TARGET_NAME}/release/biome

}


	
