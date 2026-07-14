class Lstr < Formula
  desc "A blazingly fast, minimalist directory tree viewer, written in Rust."
  homepage "https://github.com/bgreenwell/lstr"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bgreenwell/lstr/releases/download/v0.4.0/lstr-aarch64-apple-darwin.tar.xz"
      sha256 "9d6fce9723c073c408ce038d7b74b3e4547cd60fbb37cd58bf5e8f1783be4f6c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bgreenwell/lstr/releases/download/v0.4.0/lstr-x86_64-apple-darwin.tar.xz"
      sha256 "6bbf8ded91aef271cf63245fb8a65a1040164218211491d44cea2ecdf7e6280d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bgreenwell/lstr/releases/download/v0.4.0/lstr-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2f35a1a49307739957128c459e797fcbf9a19d23dc7eaac0c09e828ef4e8b08d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bgreenwell/lstr/releases/download/v0.4.0/lstr-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "748b78f0c10996cfc3e0b6a49242d4e318313ff4e15b5ddf4bfa630b078bf898"
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
