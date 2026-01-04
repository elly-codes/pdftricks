


public class PDFTricks.Ghostscript : Object {

    public signal void returned (int? exit_status = 1, string? message = "");

    private static Ghostscript? instance;
    public static Ghostscript get_default () {
        if (instance == null) {
            instance = new Ghostscript ();
        }
        return instance;
    }

    private async void run_command (string cmd) {
        string stdout, stderr = "";
        int exit_status = 1;

        try {
            Process.spawn_command_line_sync (cmd, out stdout, out stderr, out exit_status);

        } catch (Error e) {
            critical (e.message);
        }
        print (stdout);
        print (stderr);
        print (exit_status.to_string ());

        if (exit_status != 0) {
            returned (exit_status, stderr);
        } else {
            returned (exit_status, stdout);
        };
    }

    private void convert_file (PDFTricks.Format format_output, string input, string output_file) {  

        var format_input = Format.from_file (File.new_for_path (input));

        string cmd = "";
        if (format_input == PDF) {
            if (format_output == JPG) {
                var extension = output_file.split (".")[-1];
                var n_output_file = output_file.replace (extension, "-%03d.jpg");
                cmd = "gs -sDEVICE=jpeg -r144 -dNOPAUSE -dQUIET -dBATCH -sOutputFile=\"%s\" \"%s\"".printf (n_output_file, input);

            } else if (format_output == PNG) {
                var extension = output_file.split (".")[-1];
                var n_output_file = output_file.replace (extension, "-%03d.png");
                cmd = "gs -sDEVICE=png16m -r144 -dNOPAUSE -dQUIET -dBATCH -sOutputFile=\"%s\" \"%s\"".printf (n_output_file, input);

            } else if (format_output == TXT) {

                var n_output_file = output_file;
                cmd = "gs -ps2ascii -sDEVICE=txtwrite -dNOPAUSE -dQUIET -dBATCH -sOutputFile=\"%s\" \"%s\"".printf (output_file, input);
            }

        } else if (format_input == JPG) {
            var n_output_file = output_file;
            cmd = "convert \"" + input + "\" \"" + n_output_file + "\"";

        } else if (format_input == PNG) {
            var n_output_file = output_file;
            cmd = "convert -verbose \"" + input + "\" \"" + n_output_file + "\"";

        } else if (format_input == SVG) {
            var n_output_file = output_file;
            cmd = "convert \"" + input + "\" \"" + n_output_file + "\"";

        } else if (format_input == BMP){
            var n_output_file = output_file;
            cmd = "convert \"" + input + "\" \"" + n_output_file + "\"";
        }
        run_command.begin (cmd);
    }

    private void compress_file (PDFTricks.Compression compression, string input, string output_file) {        
        var resolution = compression.to_parameter ();
        var cmd = "gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/%s".printf (resolution)
                         + " -dNOPAUSE -dQUIET -dBATCH -sOutputFile=\"%s\"".printf (output_file) +  " \"%s\"".printf (input);

        run_command.begin (cmd);
    }


    private void merge_file (string[] inputs, string output_file) {
        string all_files = "";
        foreach (var filepath in inputs) {
            all_files = all_files + " " + filepath;
        }

        var cmd = "gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=\"%s\" -dBATCH \"%s\"".printf (output_file, all_files);
        run_command.begin (cmd);
    }

    private void split_file (PDFTricks.SplitType split_type, string input, string output_file) {  

        string cmd = "";
        switch (split_type) {
            case SplitType.ALL: 
            break;

            case SplitType.RANGE: 
            break;

            case SplitType.COLORS: 
            break;

            default:
            break;
        }

        run_command.begin (cmd);
    }
}