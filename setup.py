from setuptools import find_packages, setup

setup(
    name='thingly',
    version='0.0.1',
    packages=find_packages(),
    include_package_data=True,
    zip_safe=False,
    # TODO add other deps
    install_requires=[
        'flask',
    ],
)
