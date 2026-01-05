/*
* Copyright (c) 2018 Murilo Venturoso
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 3 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Murilo Venturoso <muriloventuroso@gmail.com>
*/

public enum PDFTricks.Compression {
    SCREEN,
    PRINTER,
    EBOOK,
    DEFAULT,
    PREPRESS;

    public string to_friendly_string () {
        switch (this) {
            case SCREEN: return _("Highest compression");
            case PRINTER: return _("Higher compression");
            case EBOOK: return _("Recommended compression");
            case DEFAULT: return _("Lower compression");
            case PREPRESS: return _("Lowest compression");
            default: return _("");
        }
    }

    public string to_comment () {
        switch (this) {
            case SCREEN: return _("Less quality, small file size, adapted for screens and emails");
            case PRINTER: return _("Acceptable quality, smaller file size, optimized for printing");
            case EBOOK: return _("Good quality, reduced file size, optimized for ebooks");
            case DEFAULT: return _("Higher quality and file size, for any usage");
            case PREPRESS: return _("High quality, high file size, for prepress");
            default: return _("");
        }
    }

    public string to_parameter () {
        switch (this) {
            case SCREEN: return "screen";
            case PRINTER: return "printer";
            case EBOOK: return "ebook";
            case DEFAULT: return "default";
            case PREPRESS: return "prepress";
            default: return _("");
        }
    }

    public static string[] choices () {
        return {
            SCREEN.to_friendly_string (),
            PRINTER.to_friendly_string (),
            EBOOK.to_friendly_string (),
            DEFAULT.to_friendly_string (),
            PREPRESS.to_friendly_string ()
        };
    }
}
