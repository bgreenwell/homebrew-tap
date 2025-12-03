class Xleak < Formula
  desc "A fast terminal Excel viewer with interactive TUI, search, formulas, and export capabilities"
  homepage "https://github.com/bgreenwell/xleak"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.0/xleak-aarch64-apple-darwin.tar.xz"
      sha256 "26f10eba5117955ab43b8320c2f9ff27af6f3d0e1b2d0784d3781bd7cd4a7238"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.0/xleak-x86_64-apple-darwin.tar.xz"
      sha256 "868abbce291d5d8fd0f845e1a278942cd4bfd18cd40f040e53a0e6bf4b269f9f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.0/xleak-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a7907e067c4a76e32a5f53f8caff579b7eb139458c760efe0188cd2e4a69df59"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.0/xleak-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a814f80cd3c4a469384ecc2d9f940ba68916d4efefdbc41415c51d99b1dd957b"
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
