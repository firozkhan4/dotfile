import gi
import os
import subprocess

gi.require_version('Gtk', '4.0')
from gi.repository import Gtk, GdkPixbuf, Gdk

class Config:
    def __init__(self):
        self.config = {
            "width": 400,
            "height": 400,
            "path": os.path.expanduser("~/Pictures/"),
            "count": 0
        }

    def load(self):
        config_dir = os.path.expanduser("~/.config/swappic")
        config_path = os.path.join(config_dir, "swappic.conf")

        if not os.path.exists(config_dir):
            os.makedirs(config_dir)

        if not os.path.exists(config_path):
            with open(config_path, "w") as f:
                for k, v in self.config.items():
                    f.write(f"{k}:{v}\n")

        with open(config_path, "r") as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith("#"):
                    continue
                key, value = line.split(":", 1)
                self.set_config_attr(key.strip(), value.strip())

        return self.config

    def set_config_attr(self, key, value):
        print(f"Setting {key} to {value}")
        if key in self.config:
            if key in ["width", "height", "count"]:
                self.config[key] = int(value)
            elif key == "path":
                if not value.endswith("/"):
                    value += "/"
                self.config[key] = value
        else:
            print(f"Invalid config key: {key}")


class Swapper:
    def __init__(self, app):
        self.config = Config().load()
        self.app = app
        self.window = None
        self.picture = None
        self.label = None
        self.current_image = None

    def on_activate(self, app):
        self.window = Gtk.ApplicationWindow(application=app)
        self.window.set_title("Background Changer")
        self.window.set_default_size(self.config["width"], self.config["height"])

        self.picture = Gtk.Picture()
        self.label = Gtk.Label()

        box = Gtk.Grid()
        box.set_column_spacing(10)
        box.set_row_spacing(10)

        self.show_image_index()
        self.show_image()

        keycont = Gtk.EventControllerKey()
        keycont.connect("key-pressed", self.on_key_pressed)
        self.window.add_controller(keycont)

        self.picture.set_halign(Gtk.Align.CENTER)
        self.picture.set_valign(Gtk.Align.CENTER)
        self.picture.set_content_fit(Gtk.ContentFit.CONTAIN)

        self.label.set_halign(Gtk.Align.START)
        self.label.set_valign(Gtk.Align.START)

        box.attach(self.label, 0, 0, 2, 1)
        box.attach(self.picture, 0, 1, 2, 1)

        box.set_hexpand(True)
        box.set_vexpand(True)

        self.window.set_child(box)
        self.window.present()

    def on_key_pressed(self, controller, keyval, keycode, state):
        files = self.get_image_files()

        if not files:
            return False

        if keyval == ord('l'): 
            self.config["count"] = (self.config["count"] + 1) % len(files)
            self.show_image_index()
            self.show_image()
        elif keyval == ord('h'):
            self.config["count"] = (self.config["count"] - 1) % len(files)
            self.show_image_index()
            self.show_image()
        elif keyval == ord('b'):
            if self.current_image:
                self.change_background(self.current_image)
        elif keyval == ord('q'):
            self.app.quit()

        return True

    def change_background(self, image_path):
        cmd = f"feh --no-fehbg --bg-fill '{image_path}'"
        try:
            subprocess.run(cmd, shell=True, executable="/bin/bash")

            with open(os.path.expanduser("~/.fehbg"), "w") as f:
                f.write(f"feh --no-fehbg --bg-fill '{image_path}'")
        except Exception as e:
            print(f"Error setting background: {e}")

    def get_image_files(self):
        path = self.config["path"]
        if not os.path.exists(path):
            print(f"Directory {path} does not exist")
            return []

        image_extensions = {'.jpg', '.jpeg', '.png', '.gif', '.bmp', '.tiff'}
        files = []

        try:
            for f in os.listdir(path):
                if os.path.isfile(os.path.join(path, f)):
                    _, ext = os.path.splitext(f.lower())
                    if ext in image_extensions:
                        files.append(f)
        except Exception as e:
            print(f"Error reading directory: {e}")
            return []

        return sorted(files)

    def show_image_index(self):
        files = self.get_image_files()
        if files:
            self.label.set_text(f"{self.config['count'] + 1}/{len(files)}")
        else:
            self.label.set_text("No images found")

    def show_image(self):
        path = self.config["path"]
        files = self.get_image_files()

        if not files:
            return

        try:
            image_path = os.path.join(path, files[self.config["count"]])
            pixbuf = GdkPixbuf.Pixbuf.new_from_file(image_path)
            texture = Gdk.Texture.new_for_pixbuf(pixbuf)

            self.picture.set_paintable(texture)
            self.current_image = image_path
        except Exception as e:
            print(f"Error loading image: {e}")
            self.label.set_text(f"Error loading image: {e}")


def main():
    app = Gtk.Application(application_id='com.firozkhan.BackgroundChanger')
    swapper = Swapper(app)
    app.connect('activate', swapper.on_activate)
    app.run(None)


if __name__ == "__main__":
    main()
