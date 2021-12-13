class Openfoam < Formula
  desc "Computational Fluid Dynamics simulation software"
  homepage "https://www.openfoam.com/"
  url "https://dl.openfoam.com/source/v2106/OpenFOAM-v2106.tgz"
  sha256 "11e41e5b9a253ef592a8f6b79f6aded623b28308192d02cec1327078523b5a37"
  license ""

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "cga"
  depends_on "fftw"
  depends_on "flex"
  depends_on "gnuplot"
  depends_on "metis"
  depends_on "openmpi"
  depends_on "paraview"
  depends_on "scotch"

  def install
    # The CPU count gets baked in to the source code at build time?
    # Guess something conservative.
    ENV["WM_NCOMPPROCS"] = "4"
    # The OpenFOAM build does this weird thing with a custom env setup
    system "source ./etc/bashrc; ./Allwmake -j"


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
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test OpenFOAM-v`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
