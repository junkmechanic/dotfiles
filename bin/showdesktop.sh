#!/usr/bin/env python

# Show desktop system tray launcher for use with Openbox & tint2 (or other panels)
# Ankur : Seems to be unstable. At least was in on my lab desktop

import gtk
import os

class StatusIcon:
    def __init__(self):
        self.statusicon = gtk.StatusIcon()
        self.statusicon.set_from_file("/usr/share/icons/gnome/22x22/apps/preferences-desktop-remote-desktop.png")
        self.statusicon.set_tooltip("Show Desktop")

        self.statusicon.connect("activate", self.left_click_event)
        self.statusicon.connect("popup-menu", self.right_click_event)

    def right_click_event(self, icon, button, time):
        menu = gtk.Menu()
        about = gtk.ImageMenuItem(gtk.STOCK_ABOUT)
        quit = gtk.ImageMenuItem(gtk.STOCK_QUIT)

        about.connect("activate", self.show_about_dialog)
        quit.connect("activate", gtk.main_quit)

        menu.append(about)
        menu.append(quit)

        menu.show_all()

        menu.popup(None, None, gtk.status_icon_position_menu, button, time, self.statusicon)

    def left_click_event(self, event):
        os.system('xdotool key super+d')

    def show_about_dialog(self, widget):
        about_dialog = gtk.AboutDialog()

        about_dialog.set_destroy_with_parent(True)
        about_dialog.set_program_name("Tint2 Show Desktop Icon")
        about_dialog.set_version("0.1")
        about_dialog.set_comments('A simple system tray icon so that you can show the desktop and iconify all open windows.\n\nDesigned specifically for tint2 and Openbox.\n\nYou will need the keybinding Super+D set up to ToggleShowDesktop in your Openbox rc.xml, but this is the default.')
        about_dialog.set_authors(["richjack, 2010 \nReleased under GPL v2 or later"])

        about_dialog.run()
        about_dialog.destroy()

StatusIcon()
gtk.main()
