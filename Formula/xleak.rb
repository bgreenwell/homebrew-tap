class Xleak < Formula
  desc "A fast terminal Excel viewer with interactive TUI, search, formulas, and export capabilities"
  homepage "https://github.com/bgreenwell/xleak"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.1/xleak-aarch64-apple-darwin.tar.xz"
      sha256 "032b330a8391745b424d5974838f2795a633041ee8f521d4eef4842fbf92d610"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.1/xleak-x86_64-apple-darwin.tar.xz"
      sha256 "35bde27d9bc452747f29a485673f9c089b165b9a65346e04f48a395ecd129358"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.1/xleak-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c342f63cbfc57eb38561ad5b5d805909d498670dbf99a72505f0f26a6ee9cf0e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.1/xleak-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9f41a03251102dae5e07327edba70f5c71d5889ae9d3175aa8ca4f43a79d9ac5"
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
