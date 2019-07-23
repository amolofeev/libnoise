from distutils.core import setup
from distutils.extension import Extension

from Cython.Build import cythonize

ext_modules = [
    Extension("libnoise",
              sources=["libnoise.pyx", 'noiseutils.cpp'],
              libraries=["noise"],
              language='c++'
              )
]

setup(
    name="libnoise",
    ext_modules=cythonize(ext_modules)
)
