class Cshell < Formula
  desc "CLI for managing AWS CloudShell environments and opening a session"
  homepage "https://github.com/avoidik/cshell"
  url "https://github.com/avoidik/cshell.git", tag: "v0.1.0", revision: "c7342df73e724ad270a552860e8a5e6eceb4afae"
  license "MIT"
  head "https://github.com/avoidik/cshell.git", branch: "master"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X main.version=#{version}
    ]
    system "go", "build", "-trimpath", *std_go_args(ldflags: ldflags), "."
  end

  def caveats
    <<~EOS
      cshell hands the interactive session off to the AWS session-manager-plugin.
      Install it separately, e.g.:
        brew install --cask session-manager-plugin
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cshell version")
  end
end
