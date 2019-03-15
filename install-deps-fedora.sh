#!/bin/bash -ex

sudo dnf install -y \
    jq \
    clang-tools-extra \
    python3-flake8 \
    python3-mypy \
    python3-vulture \
    bandit

pip3 install -U --user yapf

if which rustup >/dev/null; then
    rustup update
    rustup component add rls clippy rustfmt
    rustup toolchain install nightly
fi
