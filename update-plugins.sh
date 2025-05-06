#!/usr/bin/env bash
set -ex

nvim --headless "+Lazy! sync" +qa
nvim --headless -c 'TSInstallSync! rust c cpp python lua bash' -c qa
