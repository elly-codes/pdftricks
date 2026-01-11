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

namespace PDFTricks.Backend {

    private async bool merge_file (string[] inputs, string output_file) {
        bool ret = true;

        all_files = ""
        foreach (var filepath in inputs) {
            all_files = all_files + " " + filepath;
        }

        string output, stderr = "";
        int exit_status = 0;


        try {
            var cmd = "gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=" + "\"" + output_file + "\"" + " -dBATCH " + all_files;
            Process.spawn_command_line_async (cmd, out output, out stderr, out exit_status);

        } catch (Error e) {
            critical (e.message);
            ret = false;
        }
        print (stdout);
        print (stderr);
        print (exit_status.to_string ());

        if (output != "" || exit_status != 0 || stderr != "") {
            if (output.contains ("Error")) {
                ret = false;
            };
            if (exit_status != 0) {
                ret = false;
            };
        };

        return ret;
    }

}
