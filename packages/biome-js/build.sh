TERMUX_PKG_HOMEPAGE=https://github.com/biomejs/biome
TERMUX_PKG_DESCRIPTION="performant toolchain for web projects"
TERMUX_PKG_LICENSE="Apache-2.0,MIT"
TERMUX_PKG_LICENSE_FILE="LICENSE-APACHE,LICENSE-MIT"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION="1.6.3"
TERMUX_PKG_SRCURL=https://github.com/biomejs/biome/archive/refs/tags/cli/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=a7172467bb0a15fa4c1138f5540493f8cb80297958b3d98ad80d18232cbb9537

termux_step_pre_configure() {
termux_setup_rust
}


termux_step_configure() {
local env_host=$(printf $CARGO_TARGET_NAME | tr a-z A-Z | sed s/-/_/g)
export CARGO_TARGET_${env_host}_RUSTFLAGS="-C strip=symbols"
export JEMALLOC_SYS_WITH_LG_PAGE=16

}

termux_step_make() {
        source "$HOME/.cargo/env"
	cargo build --jobs $TERMUX_MAKE_PROCESSES --target $CARGO_TARGET_NAME --release
}

termux_step_make_install() {
	install -Dm700 -t $TERMUX_PREFIX/bin target/${CARGO_TARGET_NAME}/release/biome

}


	

