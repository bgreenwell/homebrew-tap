class GitEgo < Formula
  desc "Git identity manager with directory-based profile switching"
  homepage "https://github.com/bgreenwell/git-ego"
  url "https://github.com/bgreenwell/git-ego/releases/download/v0.2.4/git-ego-v0.2.4-macos-x86_64.tar.gz"
  sha256 "c9b4e2b44591c47351a4495c5627062840815cde06a930cc980b586f61843044"
  license "MIT"
  def install
    bin.install "git-ego"
  end
  test do
    assert_match "0.2.4", shell_output("#{bin}/git-ego --version")
  end
end
