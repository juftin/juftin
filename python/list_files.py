import collections
from json import loads
from os import environ, system, walk
from os.path import isdir
from os.path import join as path_join
from os.path import sep
from pathlib import Path
from pprint import pprint
from shutil import copy

from pandas import DataFrame, merge

from sql import SQL


def get_file_paths(local_path):
    """INGEST FILE NAMES AND FOLDER STRUCTURE INTO SQLITE DATABASE."""
    file_list = []
    for root, dirs, files in walk(local_path):
        for name in files:
            json_file = path_join(root, name)
            if Path(json_file).suffix.upper() == ".JSON":
                file_list.append(json_file)
    df = DataFrame(file_list, columns=["file_path"])
    df2 = df["file_path"].str.split("/", expand=True)
    df3 = merge(df, df2, left_index=True,
                right_index=True, validate="one_to_one")
    return df3


def walklevel(some_dir, level=3):
    some_dir = some_dir.rstrip(sep)
    assert isdir(some_dir)
    num_sep = some_dir.count(sep)
    file_list = []
    for root, dirs, files in walk(some_dir):
        for name in files:
            json_file = path_join(root, name)
            file_list.append(json_file)
        num_sep_this = root.count(sep)
        if num_sep + level <= num_sep_this:
            del dirs[:]
    df = DataFrame(file_list, columns=["file_path"])
    df2 = df["file_path"].str.split("/", expand=True)
    df3 = merge(df, df2, left_index=True,
                right_index=True, validate="one_to_one")
    df3["file_name"] = df3["file_path"].apply(lambda x: Path(x).name)
    df3.set_index("file_name", drop=True, inplace=True)
    return df3


df = walklevel(environ["HOME"], level=0)
SQL.pretty_print(df)
print(df.at[".bash_aliases", "file_path"])
