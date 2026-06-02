class JotdownRs < Formula
  desc "A minimalist, command-line jotting utility that's fast, private, and git-friendly."
  homepage "https://github.com/bgreenwell/jotdown-rs"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bgreenwell/jotdown-rs/releases/download/v0.2.1/jotdown-rs-aarch64-apple-darwin.tar.xz"
      sha256 "cc924557e7974ce066f5342c9155f5d069244a1a4d53d351aaa71a960a695f80"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bgreenwell/jotdown-rs/releases/download/v0.2.1/jotdown-rs-x86_64-apple-darwin.tar.xz"
      sha256 "4eb20e874fc1dbd6e72de53a792b29abe0e85e2572369b400ec5d77d6b39bcf9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bgreenwell/jotdown-rs/releases/download/v0.2.1/jotdown-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "591e36ced9afb10bfbf5ebbd199a346a9304476a679d736441c7c7b1bb743d5b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bgreenwell/jotdown-rs/releases/download/v0.2.1/jotdown-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "03fe3cfb9babc75a9c737b6522683cfae9f18353943bcc9bd2d3865435d7d55b"
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
    bin.install "jd" if OS.mac? && Hardware::CPU.arm?
    bin.install "jd" if OS.mac? && Hardware::CPU.intel?
    bin.install "jd" if OS.linux? && Hardware::CPU.arm?
    bin.install "jd" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
