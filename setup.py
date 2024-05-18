from setuptools import setup,find_packages

try:
    import pypandoc
    long_description = pypandoc.convert_file('README.md', 'rst')
except(IOError, ImportError):
    long_description = open('README.md').read()

setup(
    name='2ez',
    description='a less is more approach to sequential model optimization'
    long_description=long_description,
    version='0.1.0',
    license="BSD2",
    py_modules=['2ez'],
    url='https://github.com/timm/2ez',
    author='Tim Menzies',
    author_email='timm@ieee.org',
    install_requires=[],
    packages=find_packages(),
    classifiers=[
    'Programming Language :: Python :: 3',
    'License :: OSI Approved :: BSD License',
    'Development Status :: 2 - Pre-Alpha',
    'Operating System :: OS Independent',
    ],
    entry_points='''
        [console_scripts]
        2ez=2ez:main
    ''',
)
