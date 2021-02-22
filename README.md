# Rusty Server Installation

This script will help you install and manage your local dedicated Rust server. Rust is a video game created by Facepunch Studios. This script and its author have no claim or rights to any content that Facepunch or Valve owns, operates or disseminates to the public.

![](https://i.imgur.com/fmAIQwP.png)

# Installation & Walkthrough

## First Installation

Download the current release by clicking on the link below.

https://github.com/DJRedNight/RustyInstaller/releases/latest/download/RustyServerInstall.rar

Unzip to a desired location on your hard drive.

Run the RustyServerInstaller.bat file.

Once your Rust server is installed, make sure to select **OPTION 1** when it asks you to load a procedural map or a custom map. You want to run the procedural map first!

## Running Your Rust Server

You can edit the startup parameters of your rust server by editing the JSON files in the root directory. If you want to use a custom map, be sure that the `levelurl` value is set to the absolute path including drive letter to your map file if its on your local machine. Relative paths will not work.

**Good:**

`F:\Gaming\RustServer\.serverscript\RustyServerInstall\CustomMaps\NoobIslandV3_5.map`

**Bad:**

`CustomMaps\NoobislandV3_5.map`

## Updating, Backing Up, & Reinstallation of Files

You can choose to backup, reinstall, update or wipe files from your server using the main menu. However, to ensure that things do not break, **STOP or QUIT** your server first. This will ensure that no rollbacks, or corrupted files will be in your server.