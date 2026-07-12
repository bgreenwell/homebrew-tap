class Lstr < Formula
  desc "A blazingly fast, minimalist directory tree viewer, written in Rust."
  homepage "https://github.com/bgreenwell/lstr"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bgreenwell/lstr/releases/download/v0.3.0/lstr-aarch64-apple-darwin.tar.xz"
      sha256 "2fa95b3670ab3346444025db0b9ed6d242513f7dc230452aa42be7b3565e7eb1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bgreenwell/lstr/releases/download/v0.3.0/lstr-x86_64-apple-darwin.tar.xz"
      sha256 "1389906b18644adebe9effd9c1fa76ab82a1919e55572afe4aec0581b49770ac"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bgreenwell/lstr/releases/download/v0.3.0/lstr-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c047c5cf09a99d88bbb550749e71096dbb35f244b2c8a83cc4aa5c157376c27c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bgreenwell/lstr/releases/download/v0.3.0/lstr-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c4dcd4d43ee2af773ab2d52d96e99b1ee5a4ca6ce403dc14d1c8c8adf09f6ae6"
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
    bin.install "lstr" if OS.mac? && Hardware::CPU.arm?
    bin.install "lstr" if OS.mac? && Hardware::CPU.intel?
    bin.install "lstr" if OS.linux? && Hardware::CPU.arm?
    bin.install "lstr" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
