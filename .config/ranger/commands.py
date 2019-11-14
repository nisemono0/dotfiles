# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

from __future__ import (absolute_import, division, print_function)

# You can import any python module as needed.
import os
import shutil

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command
from ranger.core.loader import CommandLoader

# Any class that is a subclass of "Command" will be integrated into ranger as a command.

class archive_view(Command):
    """ Unpacks image archives into /tmp and displays them with feh """
    
    def execute(self):
        tmp_folder = "/tmp/archive_view"
        self._show(tmp_folder)
        self._extract(self.fm.thisfile, tmp_folder)
    
    def _show(self, folder):
        descr = "Opening"    
        obj = CommandLoader(args=['feh'] + ["/tmp/archive_view"], descr=descr, read=False)
        self.fm.loader.add(obj)

    def _extract(self, archive, folder):
        if not os.path.exists(folder): # If folder does not exist, create it
            os.mkdir(folder)
        else:                              # Otherwise delete w/e is inside
            for the_file in os.listdir(folder):
                file_path = os.path.join(folder, the_file)
                try:
                    if os.path.isfile(file_path):
                        os.unlink(file_path)
                    elif os.path.isdir(file_path): 
                        shutil.rmtree(file_path)
                except Exception as e:
                    self.fm.notify(e)
        au_flags = ['-X', folder]
        descr = "Extracting: " + os.path.basename(archive.path)
        obj = CommandLoader(args=['aunpack'] + au_flags + [archive.path], descr=descr, read=True)
        self.fm.loader.add(obj)

class compress(Command):
    """ Compress marked files (.zip, .tar.gz, .rar, .7z)"""

    def execute(self):
        if not self.arg(1):
            self.fm.notify("Please give archive name")
            return
        cwd = self.fm.thisdir
        archive = self.arg(1)
        marked_files = cwd.get_selection()
        
        if not marked_files:
            return

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        original_path = cwd.path
        au_flags = ['-a', archive]

        descr = "compressing files in: " + archive
        obj = CommandLoader(args=['apack'] + au_flags + [os.path.relpath(f.path, cwd.path) for f in marked_files], descr=descr, read=True)
        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)

    def tab(self, tabnum):
        """ Complete with extension """
        extension = ['.zip', '.tar.gz', '.rar', '.7z']
        return ['compress ' + self.arg(1) + ext for ext in extension]


class extracthere(Command):
    """ Extract copied files to current directory """
    def execute(self):
        copied_files = tuple(self.fm.copy_buffer)

        if not copied_files:
            return

        def refresh(_):
            cwd = self.fm.get_directory(original_path)
            cwd.load_content()

        one_file = copied_files[0]
        cwd = self.fm.thisdir
        original_path = cwd.path
        au_flags = ['-X', cwd.path]
        au_flags += self.line.split()[1:]
        au_flags += ['-e']

        self.fm.copy_buffer.clear()
        self.fm.cut_buffer = False
        if len(copied_files) == 1:
            descr = "extracting: " + os.path.basename(one_file.path)
        else:
            descr = "extracting files from: " + os.path.basename(one_file.dirname)
        obj = CommandLoader(args=['aunpack'] + au_flags \
                + [f.path for f in copied_files], descr=descr, read=True)

        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)
