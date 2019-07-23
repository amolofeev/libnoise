cimport libnoise

cdef class HeightMap2D:
    cdef libnoise.Perlin perlin
    cdef libnoise.NoiseMap map
    cdef libnoise.NoiseMapBuilderPlane plane

    cdef int chunk_width, chunk_height

    def __init__(self, int chunk_width=16, int chunk_height=16):
        self.chunk_height = chunk_height
        self.chunk_width = chunk_width
        self.prepare()

    def prepare(self):
        self.plane.SetSourceModule(self.perlin)
        self.plane.SetDestNoiseMap(self.map)
        self.plane.SetDestSize(self.chunk_width, self.chunk_height)

    def set_seed(self, int seed):
        self.perlin.SetSeed(seed)

    def set_octaves(self, int count):
        self.perlin.SetOctaveCount(count)

    def set_frequency(self, double freq):
        self.perlin.SetFrequency(freq)

    def set_persistence(self, double pers):
        self.perlin.SetPersistence(pers)

    def build(self, double x, double y):
        self.plane.SetBounds(x, x+1.0, y, y+1.0)
        self.plane.Build()

    def value(self, int x, int y):
        return self.map.GetValue(x, y)

    def render(self, libnoise.string filename = 'tutorial.bmp'):
          cdef libnoise.RendererImage renderer
          cdef libnoise.Image image
          renderer.SetSourceNoiseMap (self.map)
          renderer.SetDestImage (image)
          renderer.ClearGradient ()
          renderer.AddGradientPoint (-1.0000, libnoise.Color (  0,   0, 128, 255)) # deeps
          renderer.AddGradientPoint (-0.2500, libnoise.Color (  0,   0, 255, 255)) # shallow
          renderer.AddGradientPoint ( 0.0000, libnoise.Color (  0, 128, 255, 255)) # shore
          renderer.AddGradientPoint ( 0.0625, libnoise.Color (240, 240,  64, 255)) # sand
          renderer.AddGradientPoint ( 0.1250, libnoise.Color ( 32, 160,   0, 255)) # grass
          renderer.AddGradientPoint ( 0.3750, libnoise.Color (224, 224,   0, 255)) # dirt
          renderer.AddGradientPoint ( 0.7500, libnoise.Color (128, 128, 128, 255)) # rock
          renderer.AddGradientPoint ( 1.0000, libnoise.Color (255, 255, 255, 255)) # snow
          renderer.EnableLight ()
          renderer.SetLightContrast (3.0) # Triple the contrast
          renderer.SetLightBrightness (2.0) # Double the brightness
          renderer.Render ()
        
          cdef libnoise.WriterBMP writer
          writer.SetSourceImage (image)
          writer.SetDestFilename (filename)
          writer.WriteDestFile ()
