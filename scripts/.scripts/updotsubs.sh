#!/bin/bash
###################################################################################################
# ██╗   ██╗██████╗ ██████╗  ██████╗ ████████╗███████╗██╗   ██╗██████╗ ███████╗   ███████╗██╗  ██╗ #
# ██║   ██║██╔══██╗██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║   ██║██╔══██╗██╔════╝   ██╔════╝██║  ██║ #
# ██║   ██║██████╔╝██║  ██║██║   ██║   ██║   ███████╗██║   ██║██████╔╝███████╗   ███████╗███████║ #
# ██║   ██║██╔═══╝ ██║  ██║██║   ██║   ██║   ╚════██║██║   ██║██╔══██╗╚════██║   ╚════██║██╔══██║ #
# ╚██████╔╝██║     ██████╔╝╚██████╔╝   ██║   ███████║╚██████╔╝██████╔╝███████║██╗███████║██║  ██║ #
#  ╚═════╝ ╚═╝     ╚═════╝  ╚═════╝    ╚═╝   ╚══════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝╚══════╝╚═╝  ╚═╝ #
###################################################################################################
# update submodules for muh dotfiles

git submodule update --init --recursive --remote /home/$USER/dotfiles/