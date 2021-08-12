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
    download_all_packages('out.json')