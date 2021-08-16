import json
import os
import sys
import re
import shutil
from collections import deque
import fileinput
import subprocess
import argparse
import glob

import requests
import requirements
from pip._internal.index.collector import LinkCollector
from pip._internal.index.package_finder import PackageFinder
from pip._internal.models.format_control import FormatControl
from pip._internal.models.search_scope import SearchScope
from pip._internal.models.target_python import TargetPython
from pip._internal.network.session import PipSession
from pip._vendor.packaging.specifiers import SpecifierSet



PREFIX = 'awxrpm'
PACKAGER = 'automates <info@miracle.dk>'
PACKAGES_DIR="/tmp/packages"

def generate_spec_for(package_name, reqs_data, build_reqs_data, pkgs_dir):
    pkg_dir = glob.glob(f'{pkgs_dir}/{package_name}/*/')[0]
    pkg_deps = ' '.join([dep['name']+dep['specifier']+dep['version'] for dep in reqs_data[package_name]['dependencies']])
    pkg_build_deps = ' '.join([dep['name']+dep['specifier']+dep['version'] for dep in build_reqs_data[package_name]['buildrequires']])
    print(pkg_dir)
    command = ["python3", "setup.py", "bdist_rpm", "--spec-only",
               "--build-requires", pkg_build_deps, "--packager", PACKAGER, "--dist-dir", "../"]
    if pkg_deps:
        command += ['--requires', pkg_deps]

    print(' '.join(command))
    subprocess.run(command, cwd=pkg_dir)
    specfile_ = glob.glob(f'{pkgs_dir}/{package_name}/*.spec')[0]
    with open(specfile_, 'r') as specfile:
        temp = specfile.read()
    splitted = temp.split('\n')
    splitted[0] = f'%define name {PREFIX}-{package_name}'
    with open(specfile_, 'w') as specfile:
        specfile.write('\n'.join(splitted))


def get_best_package(package_name, specifier=''):
    print(f'get_best_package: {package_name}')
    allow_yanked = True
    ignore_requires_python = True
    target_python = TargetPython(py_version_info=(3, 8, 3))
    format_control = FormatControl({':all:'}, {})
    link_collector = LinkCollector(
        session=PipSession(),
        search_scope=SearchScope([], ['https://pypi.org/simple']),
    )
    finder = PackageFinder(
        link_collector=link_collector,
        target_python=target_python,
        allow_yanked=allow_yanked,
        format_control=format_control,
        ignore_requires_python=ignore_requires_python,
    )
    cand = finder.find_best_candidate(package_name, SpecifierSet(specifier))
    return cand.best_candidate.name, cand.best_candidate.version, cand.best_candidate.link.url

def download_best_package(package_name, specifier='', path=PACKAGES_DIR):
    print(f'download_best_package: {package_name}')
    name, version, url = get_best_package(package_name, specifier)
    url_split = url.split('#sha256')[0]
    file_split = url_split.split('/')[-1]
    dest = f'{path}/{name}/{file_split}'

    if not os.path.exists(f'{path}/{name}'):
        os.makedirs(f'{path}/{name}')

    # Only download in not done previously
    if not os.path.isfile(dest):
        print(f'Downloading: {url_split}')
        r = requests.get(url_split, allow_redirects=True)
        open(dest, 'wb').write(r.content)
        shutil.unpack_archive(dest, f'{path}/{package_name}')
        extracted = dest.rstrip('.tar.gz')
        os.rename(extracted, extracted.lower())



if __name__ == '__main__':
    f = open("/tmp/awxrpm.requirements.txt", "rt")
    lines = f.readlines()
    for line in lines:
        myname=line.split("==")[0].lower()
        myspec="=="+line.split("==")[1]
        try:
           download_best_package(myname, myspec, "/tmp/awx/packages")
        except:
           print("failed)")



