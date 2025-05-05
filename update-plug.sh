#!/usr/bin/env bash

set -ex

nvim --headless -c 'PlugUpgrade --sync' -c qa
nvim --headless -c 'PlugUpdate --sync' -c qa
nvim --headless -c UpdateRemotePlugins -c qa
nvim --headless -c 'TSInstallSync! rust c cpp python lua bash' -c qa
