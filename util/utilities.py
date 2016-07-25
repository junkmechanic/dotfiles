import os
import sys
import json
import codecs
from functools import wraps
from collections import OrderedDict
from contextlib import contextmanager
# import traceback as tb

NEW_LINE = '\n'
BUFFER_MAX = 5000


def to_unicode(text, encoding='utf-8'):
    # provided that the text is not already decoded.
    if not isinstance(text, unicode):
        text = unicode(text, encoding)
    return text


@contextmanager
def ignored(*exceptions):
    try:
        yield
    except exceptions:
        pass


@contextmanager
def redirect_stdout(filename):
    actual_stdout = sys.stdout
    with open(filename, 'w') as f:
        sys.stdout = f
        try:
            yield f
        finally:
            sys.stdout = actual_stdout


# File I/O

def writeToFile(filename, line, mode='a'):
    """
    - mode can have either of 'w' or 'a' as its value
    - this function is not responsible for printing '\n' character
    """
    with codecs.open(filename, mode, encoding='utf-8') as ofile:
        ofile.write(line)


def deleteFiles(file_list, warn=False):
    for fname in file_list:
        with ignored(OSError):
            if warn:
                print "Deleting `{}` if it exists".format(fname)
            os.remove(fname)


class FileWriteBuffer:
    def __init__(self, filename, buffer_max=None, delim=None):
        self.filename = filename
        self.buf_max = buffer_max if buffer_max else BUFFER_MAX
        self.delim = delim if delim else NEW_LINE
        self.Buffer = []

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        if exc_type:
            # No point in handling the error here. Let the caller handle it
            # tb.print_exception(exc_type, exc_value, traceback)
            raise exc_type, exc_value, traceback
        if len(self.Buffer) > 0:
            writeToFile(self.filename, (self.delim).join(
                self.Buffer) + self.delim)
            self.Buffer = []

    def write(self, text):
        self.Buffer.append(text)
        if len(self.Buffer) == self.buf_max:
            writeToFile(self.filename, (self.delim).join(
                self.Buffer) + self.delim)
            self.Buffer = []


# JSON I/O

def loadJSON(filename):
    with open(filename) as ifi:
        json_tree = json.load(ifi)
    return json_tree


def loadAllLines(filename):
    with open(filename) as ifi:
        all_lines = ifi.readlines()
    return all_lines


def saveJSON(obj, filename):
    with open(filename, 'w') as ofi:
        json.dump(obj, ofi)


# REPL

def replIter(repr):

    @wraps(repr)
    def list_iterator(lister):
        for item in lister:
            repr(item)
            q = raw_input()
            if q == 'q':
                break

    return list_iterator


@replIter
def simpleReplIter(item):
    if isinstance(item, dict):
        for key in item:
            print '{} : {}'.format(key, item[key])
    else:
        print item


def simple_file_lister(filename):
    with open(filename) as ifi:
        for line in ifi:
            yield line


def simpleFileIter(filename):
    simpleReplIter(simple_file_lister(filename))


# Cache

def lru_cache(max_size):
    def cache_wrapper(pure_func):
        cache = OrderedDict()

        @wraps(pure_func)
        def func_applier(*args):
            if args in cache:
                return cache[args]
            result = pure_func(*args)
            cache[args] = result
            if len(cache) == max_size + 1:
                cache.popitem(last=False)
            return result
        return func_applier
    return cache_wrapper
