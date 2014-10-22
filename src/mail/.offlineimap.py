#!/usr/bin/python
import re, os
import subprocess

def get_output(cmd, input=None, cwd=None, env=None):
    # Bunch of boilerplate to catch the output of a command:
    pipe = subprocess.Popen(cmd, shell=True, cwd=cwd, env=env, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    (output, errout) = pipe.communicate(input=input)
    assert not errout
    assert pipe.returncode == 0
    return output

def get_password_emacs(machine, login, port):
    cmd = "emacsclient --eval '(offlineimap-get-password \"%s\" \"%s\" \"%s\")'" % (machine,port,login)
    return get_output(cmd).strip().lstrip('"').rstrip('"')
