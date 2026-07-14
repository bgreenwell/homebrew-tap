class GitEgo < Formula
  desc "Git identity manager with directory-based profile switching"
  homepage "https://github.com/bgreenwell/git-ego"
  url "https://github.com/bgreenwell/git-ego/releases/download/v0.2.2/git-ego-v0.2.2-macos-x86_64.tar.gz"
  sha256 "65e1a1379b1a00a22ec02caab242f0996ed5954d62b186ed18461c294e0396f6"
  license "MIT"
  def install
    bin.install "git-ego"
  end
  test do
    assert_match "0.2.2", shell_output("#{bin}/git-ego --version")
  end
end
