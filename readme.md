Cython wrapper of [libnoise](http://libnoise.sourceforge.net/) library.
-
I've implemented wrapper to be able to build 2D height map as described in tutorial 2-5 and be able to process it in your own code.

Currently, there were implemented (more or less): 

    noise::module::Module
        noise::module::Perlin
        noise::module::Voronoi
    
    noise::utils::NoiseMap
    noise::utils::NoiseMapBuilderPlane
    noise::utils::Color
    noise::utils::Image
    noise::utils::WriterBMP
    noise::utils::RendererImage

Build
-
Before use this module you have to [build](http://libnoise.sourceforge.net/tutorials/tutorial1.html) libnoise on your system or install from repo if possible.

Then build python module

```bash
python setup.py build_ext -i
```


Example
-
```python
import random
import libnoise

noise = libnoise.HeightMap2D(256, 256)
noise.set_seed(
    random.randint(-1 << 24, 1 << 24)
)
noise.set_octaves(10)
noise.set_frequency(.75)
noise.set_persistence(.55 )
noise.build(1, 1)
noise.render(b'tutorial.bmp')
# or
print(
    noise.value(10, 10)
)

```


P.S:
-
Actually, you have to write your own `*.pyx` files (and build it) to be able to get expected behavior.
