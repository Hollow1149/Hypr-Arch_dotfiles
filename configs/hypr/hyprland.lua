-- ---------------------------------------------------------
-- EDIT THIS LUA CONFIG ACCORDING TO THE WIKI INSTRUCTIONS.
-- ---------------------------------------------------------
-- ██╗  ██╗██╗   ██╗██████╗ ██████╗ ██╗     ██╗   ██╗ █████╗
-- ██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██║     ██║   ██║██╔══██╗
-- ███████║ ╚████╔╝ ██████╔╝██████╔╝██║     ██║   ██║███████║
-- ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗██║     ██║   ██║██╔══██║
-- ██║  ██║   ██║   ██║     ██║  ██║███████╗╚██████╔╝██║  ██║
-- ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!!) split this configuration into multiple files
-- Create your files separately and then link them to this file like this:
-- require("myColors")
--
-- Functionality settings
require("configs.hyprfunc")
--
-- Decortaion/Animation setttings
require("configs.hyprdeco")
--
-- Keybinds
require("configs.hyprbinds")
--
-- Window and Layerrules
require("configs.hyprwinlayrules")
