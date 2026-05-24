class Xleak < Formula
  desc "A fast terminal Excel viewer with interactive TUI, search, formulas, and export capabilities"
  homepage "https://github.com/bgreenwell/xleak"
  version "0.2.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.6/xleak-aarch64-apple-darwin.tar.xz"
      sha256 "c23c0fd2e87f5746f88992757a58006eccc051e49d05a9401dfcd8bedcce98f3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.6/xleak-x86_64-apple-darwin.tar.xz"
      sha256 "7e5a7574096a1c1ecf0d534657aed7e8e502934a5d6e306e82ddee2f17ced44e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.6/xleak-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1081569dfc53d121ee6aad4a8a52b6e96207a17c92aabe16414f87242efca94e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bgreenwell/xleak/releases/download/v0.2.6/xleak-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7b6c7084bcc69ff171dbd90841342271db9a4cc94f9f0a766f15251856926234"
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
