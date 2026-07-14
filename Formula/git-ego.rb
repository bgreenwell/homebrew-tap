class GitEgo < Formula
  desc "Git identity manager with directory-based profile switching"
  homepage "https://github.com/bgreenwell/git-ego"
  url "https://github.com/bgreenwell/git-ego/releases/download/v0.2.3/git-ego-v0.2.3-macos-x86_64.tar.gz"
  sha256 "7df1bf2a0b90689ad3c116f5606ac42cbd94a021f0d68a934a0c2e9d160f1430"
  license "MIT"
  def install
    bin.install "git-ego"
  end
  test do
    assert_match "0.2.3", shell_output("#{bin}/git-ego --version")
  end
end
