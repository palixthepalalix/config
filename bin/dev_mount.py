#!/usr/bin/env python
from subprocess import call
import os
import sys
 
# TODO: Update with your information (these options won't work)
servers = [
  {
    'name': 'centos_devbox',
    'host': '1052.acook.user.nym2.adnexus.net',
    'dir' : '/home/acook'
  },
  {
    'name': 'ubuntu_devbox',
    'host': '1397.acook.user.nym2.adnexus.net',
    'dir' : '/home/acook'
  }
]
user = os.environ['USER']
 
def connect():
  """
  Connect SSHFS's
  """
  for server in servers:
    try:
      call(["sudo", "umount", "/Volumes/%s" % (server['name'])])
      print("connecting to %s" %(server['host']))
      print("------------------------------")
      call(["sudo", "mkdir", "-p", "/Volumes/%s" % (server['name'])])
      call(["sudo", "chown", "-R", user, "/Volumes/%s" % (server['name'])])
      status = call(["sshfs",
                     "%s:%s" % (server['host'], server['dir']),
                     "/Volumes/%s" %(server['name'])])
 
      if status == 0:
        print("connected")
        print("mounted locally at /Volumes/%s" % (server['name']))
        print("mounted remotely at %s" % (server['dir']))
    except:
      print "Unexpected error:", sys.exc_info()[0]
    finally:
      print("\n")
 
 
def get_sudo():
  call(["echo", "Running as root. Beware!! (mwahahahaha)"])
  call(["sudo", "echo"])
 
 
get_sudo()
connect()
