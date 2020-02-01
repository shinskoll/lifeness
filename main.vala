using Gtk;

class ElementaryNess : Window {
    private Listing listing;
    private Editor editor;

    public ElementaryNess() {
        var header = new Gtk.HeaderBar();
        header.set_show_close_button(true);
    
        set_titlebar(header);
        destroy.connect(Gtk.main_quit);
        set_default_size(400,200);
        border_width = 0;
        set_title("Hellow Lord");
        Image openIcon = new Image.from_icon_name("document-open", IconSize.SMALL_TOOLBAR);
        var openButton = new ToolButton(openIcon, "Open");
        openButton.clicked.connect(onOpenClicked);
        header.add(openButton);

        setupUI();
    }

    private void setupUI() {
        Gtk.Box bigBox = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);

        this.listing = new Listing();
        bigBox.pack_start(this.listing, false, false, 0);

        Gtk.ScrolledWindow scroller = new Gtk.ScrolledWindow(null, null);

        this.editor = new Editor();
        scroller.add(editor);

        bigBox.pack_start(scroller, true, true, 0);

        add(bigBox);
    }

    private void onOpenClicked() {
        var dialog = new Gtk.FileChooserNative("Open file", this, Gtk.FileChooserAction.OPEN, null, null);
        dialog.set_select_multiple(false);
        var ff = new FileFilter();
        ff.set_name("Text files");
        ff.add_mime_type("text/plain");
        dialog.set_filter(ff);
        
        if (dialog.run () == ResponseType.ACCEPT) {
            open_file(dialog.get_filename());
            //open_file(dialog.get_file());
        }
        dialog.destroy();
    }

    private void open_file (string filename) {
        try {
            string text;
            FileUtils.get_contents(filename, out text);
            this.editor.setText(text);
        } catch (Error e) {
            stderr.printf ("Error: %s\n", e.message);
        }
    }
}

class Listing : ListBox {

    public Listing() {
        set_selection_mode(SINGLE);
        var row0 = new Gtk.ListBoxRow();
        row0.add(new Gtk.Label("JUST DO IT, DOOOO IIIT"));
        var row1 = new Gtk.ListBoxRow();
        row1.add(new Gtk.Label("DO IT"));
        var row2 = new Gtk.ListBoxRow();
        row2.add(new Gtk.Label("JUST"));
        prepend(row0);
        prepend(row1);
        prepend(row2);
    }

    public void addRow(string str) {
        var row1 = new Gtk.ListBoxRow();
        row1.add(new Gtk.Label(str));
        prepend(row1);
    }
}

class Editor : TextView {
    Gtk.TextBuffer textvBuffer;

    public Editor() {
        set_editable(true);
        set_wrap_mode(WORD);
        textvBuffer = this.get_buffer();
        this.setText("It's pretty empty here :/");
    }

    public void setText(string text) {
        textvBuffer.set_text(text);
    }

}

static int main(string[] args){
    Gtk.init(ref args);
    
    Gtk.Window window = new ElementaryNess();
    
    window.show_all();
    Gtk.main();

    return 0;
}