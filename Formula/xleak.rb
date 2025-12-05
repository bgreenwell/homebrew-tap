class Xleak < Formula
  desc "A fast terminal Excel viewer with interactive TUI, search, formulas, and export capabilities"
  homepage "https://github.com/bgreenwell/xleak"
  version "0.2.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.5/xleak-aarch64-apple-darwin.tar.xz"
      sha256 "225cef5bb34731ae56f0515a1d3be7a49b640c53bdab9d93b461fc7321dfae69"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.5/xleak-x86_64-apple-darwin.tar.xz"
      sha256 "2a8a5c3080059f388eea633a5acd78a946e22efa849929e20c9a5962036a7a59"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.5/xleak-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "64c3f5d8bbd8f51b339fb8227c39808fa3c53a9fbd3373c2b50e7c413e1c3f4f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.5/xleak-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "99144d1ddc6b28fe12264c1d74a2733e2f2d13185689361d85162eaa6cd5d6ae"
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
