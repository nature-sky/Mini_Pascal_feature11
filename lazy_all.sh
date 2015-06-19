#!/usr/bin/python
import subprocess
import os
import shutil
import sys

FEATURE11_DIR = "feature11_test"

def execute(cmd):
    print cmd
    sys.stdout.flush()
    sys.stderr.flush()
    return os.system(cmd)

#move feature11 to current dir
if os.system("rm -f -r %s" % FEATURE11_DIR) or os.system("rm -f standard_mpc"):
    print "cannot rm %s/standard_mpc" % FEATURE11_DIR
    exit(1)
if os.system("cp -r /home/public/%s ."%FEATURE11_DIR) or os.system("cp /home/public/standard_mpc ."):
    print "cannot copy %s/standard_mpc" % FEATURE11_DIR
    exit(1)

if execute("make clean"):
    print "make clean failed"

if execute("make"):
    print "make failed"
    exit(1)

for testcase in next(os.walk(FEATURE11_DIR))[2]:
    tname = testcase.split(".")[0]
    print "---------- [ Feature %s Start ] ----------" % tname
    s = (FEATURE11_DIR, tname, FEATURE11_DIR, tname)
    print s
    if execute("./standard_mpc -pt %s/%s.pas %s/%s_correct.s" % s):
        print "standard_mpc execute error"
        print "It should not happend"
        exit(1)

if execute("./mpc -acpt %s/%s %s/%s.s" % s):
    print "mpc execute error"
else:
    execute("diff %s/%s.token %s/%s_correct.token" % s)
    execute("diff %s/%s.parse %s/%s_correct.parse" % s)
    if execute("nasm -f elf -i ./lib/ %s/%s_correct.s -o %s/%s_correct.o" % s):
        print "answer nasm error"
        print "It should not happend"
        exit(1)
    elif execute("nasm -f elf -i ./lib/ %s/%s.s -o %s/%s.o" % s):                                                  print "nasm error"
    elif execute("ld -m elf_i386 %s/%s_correct.o lib/libasm.a -o %s/%s_correct" % s):
        print "answer load error"
        print "It should not happend"
        exit(1)
    elif execute("ld -m elf_i386 %s/%s.o lib/libasm.a -o %s/%s" % s):
        print "load error"
        continue

    elif execute("%s/%s_correct > %s/%s_correct.res"%s):
        print "answer execute error"
        print "It should not happend"
        exit(1)
    elif execute("%s/%s_correct > %s/%s.res"%s):
        print "execute error"
        continue
    else:
        execute("diff %s/%s_correct.res %s/%s.res" % s)
        print "---------- [  Feature %s End  ] ----------" % tname

