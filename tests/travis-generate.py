#!/usr/bin/env python
import yaml, os

def create_init_file( f ):
  f.write('---\n')
  f.write('sudo: required\n')
  f.write('services:\n')
  f.write('  - docker\n\n')
  f.write('jobs:\n')
  f.write('  include:\n')

def create_stage( f , stage ):
  f.write('    - stage: ' + stage + '\n')
  f.write('      script: \n')

def add_script( f , script ):
  f.write('      - '+ script +'\n')

def create_end_file( f ):
  f.write('\nnotifications:\n')
  f.write('  email: false\n')
  f.write('  webhooks: https://galaxy.ansible.com/api/v1/notifications/\n')
  f.close()

travis_file = '../.travis.yml'

if os.path.exists(travis_file):
  os.remove(travis_file)

f = open(travis_file, 'w')
create_init_file(f)

stream = yaml.load(open("distributions.yml", "r"))
for distro, values in stream.items():
  create_stage(f, distro)
  for image in values:
    add_script(f, 'docker run -it --rm -v `pwd`:/runner '+ image + ' ansible-playbook -i tests/inventory tests/test.yml')

create_end_file(f)
