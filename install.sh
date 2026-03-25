#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="$SCRIPT_DIR/bin"
LIB_DIR="$SCRIPT_DIR/lib"
INSTALL_BIN="/usr/local/bin"
INSTALL_LIB="/usr/local/lib/kaldi"
LD_CONF="/etc/ld.so.conf.d/kaldi.conf"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

if [ "$(uname -m)" != "aarch64" ]; then
    error "This package is for aarch64 only. Detected: $(uname -m)"
fi

if [ "$EUID" -ne 0 ]; then
    error "Please run with sudo: sudo ./install.sh"
fi

if [ ! -d "$BIN_DIR" ] || [ ! -d "$LIB_DIR" ]; then
    error "bin/ or lib/ directory not found. Run this script from the repo root."
fi

BIN_COUNT=$(find "$BIN_DIR" -maxdepth 1 -type f -executable | wc -l)
LIB_COUNT=$(find "$LIB_DIR" -maxdepth 1 -name '*.so*' -type f | wc -l)

echo ""
echo "=========================================="
echo "  Kaldi ARM aarch64 Installer"
echo "=========================================="
echo ""
info "Found $BIN_COUNT binaries and $LIB_COUNT shared libraries"
info "Installing to $INSTALL_BIN and $INSTALL_LIB"
echo ""

info "Installing shared libraries..."
mkdir -p "$INSTALL_LIB"
cp -a "$LIB_DIR"/*.so* "$INSTALL_LIB/"
info "Libraries installed to $INSTALL_LIB"

info "Registering library path..."
echo "$INSTALL_LIB" > "$LD_CONF"
ldconfig
info "ldconfig updated"

info "Installing binaries..."
cp "$BIN_DIR"/* "$INSTALL_BIN/"
info "$BIN_COUNT binaries installed to $INSTALL_BIN"

echo ""
info "Verifying installation..."
if acc-lda --help >/dev/null 2>&1; then
    info "acc-lda: OK"
else
    warn "acc-lda: FAILED (check library dependencies)"
fi

if decode-faster --help >/dev/null 2>&1; then
    info "decode-faster: OK"
else
    warn "decode-faster: FAILED (check library dependencies)"
fi

echo ""
echo "=========================================="
echo -e "  ${GREEN}Installation complete!${NC}"
echo "=========================================="
echo ""
echo "  Binaries:  $INSTALL_BIN"
echo "  Libraries: $INSTALL_LIB"
echo ""
echo "  Try: acc-lda --help"
echo "       decode-faster --help"
echo ""
