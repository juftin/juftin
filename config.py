from os import environ
from os.path import abspath
from os.path import join as path_join
from pathlib import Path


class directories:
    home = environ["HOME"]
    # BASH
    bash = path_join(Path(abspath(__file__)).parent, "bash")
    bash_backup = path_join(bash, "backup")
    bash_macbook = path_join(bash, "macbook")
    # PYTHON
    python = bash = path_join(Path(abspath(__file__)).parent, "python")
