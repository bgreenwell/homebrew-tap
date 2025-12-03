class Xleak < Formula
  desc "A fast terminal Excel viewer with interactive TUI, search, formulas, and export capabilities"
  homepage "https://github.com/bgreenwell/xleak"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.3/xleak-aarch64-apple-darwin.tar.xz"
      sha256 "55da6800018dc505ca87b33851b859f8d231cb730e857dda48415a18d34fd4e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.3/xleak-x86_64-apple-darwin.tar.xz"
      sha256 "2b0268c73ac18912a5c21ae4cfdba58c14b60ffb2f6a769066eb899326987732"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.3/xleak-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f42c3f8f76ff31b422454f40c184ceb53b0433a53f6c893bc24ad8265f8fdf2d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.3/xleak-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b920e4b12a0464c21d46081063bcc4404eb733c335005c6d5618c350f73ab9af"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "xleak" if OS.mac? && Hardware::CPU.arm?
    bin.install "xleak" if OS.mac? && Hardware::CPU.intel?
    bin.install "xleak" if OS.linux? && Hardware::CPU.arm?
    bin.install "xleak" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
