from libcpp cimport bool
from libcpp.string cimport string

# Unsigned integer type.
ctypedef unsigned int uint
# 32-bit unsigned integer type.
ctypedef unsigned int uint32
# 16-bit unsigned integer type.
ctypedef unsigned short uint16

# 8-bit unsigned integer type.
ctypedef unsigned char uint8

# 32-bit signed integer type.
ctypedef int int32

# 16-bit signed integer type.
ctypedef short int16

#8-bit signed integer type.
ctypedef char int8


cdef extern from 'noise/noise.h' namespace 'noise::module':
    cdef cppclass Module:
        Module()

    cdef cppclass Perlin(Module):
        Perlin()
        void SetSeed(int seed)
        double GetValue(double x, double y, double z)
        void SetOctaveCount(int count)
        void SetFrequency(double freq)
        void SetPersistence(double pers)

    cdef cppclass Voronoi(Module):
        Voronoi ()
        void 	EnableDistance (bool enable=True)
        double 	GetDisplacement () const
        double 	GetFrequency () const
        int GetSourceModuleCount () const
        int GetSeed () const
        bool IsDistanceEnabled () const
        double GetValue (double x, double y, double z) const
        void SetDisplacement (double displacement)
        void SetFrequency (double frequency)
        void SetSeed (int seed)


cdef extern from 'noiseutils.h' namespace 'noise::utils':
    cdef cppclass NoiseMap:
        NoiseMap()
        float GetValue(int x, int y)

    cdef cppclass NoiseMapBuilderPlane:
        NoiseMapBuilderPlane()
        void SetBounds(double lowerXBound, double upperXBound, double lowerZBound, double upperZBound)
        void SetSourceModule(Module& sourceModule)
        void SetDestNoiseMap(NoiseMap& destNoiseMap)
        void SetDestSize(int destWidth, int destHeight)
        void Build()

    cdef cppclass Color:
        Color()
        Color(uint8 r, uint8 g, uint8 b, uint8 a)

    cdef cppclass Image:
        Image()
        Image (int width, int height)

    cdef cppclass WriterBMP:
        WriterBMP()
        void SetDestFilename (const string& filename)
        void SetSourceImage (Image& sourceImage)
        void WriteDestFile ()

    cdef cppclass RendererImage:
        RendererImage()
        void AddGradientPoint (double gradientPos, const Color& gradientColor)
        void BuildGrayscaleGradient()
        void BuildTerrainGradient()
        void ClearGradient()
        void EnableLight(bool enable = True)
        void EnableWrap(bool enable = True)
        double GetLightAzimuth() const
        double GetLightBrightness() const
        Color GetLightColor() const
        double GetLightContrast() const
        double GetLightElev() const
        double GetLightIntensity() const
        bool IsLightEnabled() const
        bool IsWrapEnabled() const
        void Render()
        void SetBackgroundImage(const Image& backgroundImage)
        void SetDestImage(Image& destImage)
        void SetLightAzimuth(double lightAzimuth)
        void SetLightBrightness(double lightBrightness)
        void SetLightColor(const Color& lightColor)
        void SetLightContrast(double lightContrast)
        void SetLightElev(double lightElev)
        void SetLightIntensity(double lightIntensity)
        void SetSourceNoiseMap(const NoiseMap& sourceNoiseMap)
