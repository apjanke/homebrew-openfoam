class Openfoam < Formula
  desc "Computational Fluid Dynamics simulation software"
  homepage "https://www.openfoam.com/"
  url "https://dl.openfoam.com/source/v2106/OpenFOAM-v2106.tgz"
  sha256 "11e41e5b9a253ef592a8f6b79f6aded623b28308192d02cec1327078523b5a37"
  license "GPL-3.0-or-later"

  depends_on xcode: :build

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "cgal"
  depends_on "fftw"
  depends_on "flex"
  depends_on "gnuplot"
  depends_on "metis"
  depends_on "openmpi"
  # Nope; can't actually take a dependency on Casks.
  # depends_on "paraview"
  depends_on "scotch"

  # Third-party patch to get OpenFOAM building on macOS
  # Let's just see if this works!
  # Will need to copy this to Homebrew to get the formula accepted in Homebrew Core.
  # May need to get license resolved, first:
  #   https://github.com/mrklein/openfoam-os-x/issues/74
  patch do
    url "https://raw.githubusercontent.com/mrklein/openfoam-os-x/master/OpenFOAM-v2106.patch"
    sha256 "08cf5c07a7a51001c90b2857c3f633e9d30499e89af95790e6791f4007be3f5d"
  end

  def install
    # The CPU count gets baked in to the source code at build time?
    # Guess something conservative.
    ENV["WM_NCOMPPROCS"] = "4"
    # The OpenFOAM build does this weird thing with a custom env setup
    # Use a non-parallel (no "-j") build to get better logs, until we get the basic build working
    system "source ./etc/bashrc; ./Allwmake"
    # system "source ./etc/bashrc; ./Allwmake -j"


    # TODO: Probly delete everything below here

    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    # system "./configure", *std_configure_args, "--disable-silent-rules"
    # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
  end

  def caveats
    <<~EOS
      OpenFOAM has been installed to #{opt_prefix}. To make it available, add the following
      to your ~/.bashrc:
        source #{opt_prefix}/etc/bashrc
    EOS
  end

  test do
    system "source ./etc/bashrc && foamInstallationTest && foamTestTutorial -full incompressible/simpleFoam/pitzDaily"
  end
end
