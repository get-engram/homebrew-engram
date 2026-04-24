class Engram < Formula
  desc "Persistent memory for AI agents — auto-captures and searches conversations"
  homepage "https://getengram.app"
  url "https://registry.npmjs.org/@getengram/cli/-/cli-0.2.1.tgz"
  sha256 "9fe2094e50cbfeb51b1c70a73648d11c9b198b6b560b475a0550a8e0808e0c23"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  service do
    run [opt_bin/"engram", "start", "--foreground"]
    keep_alive successful_exit: false
    log_path var/"log/engram.log"
    error_log_path var/"log/engram.log"
    environment_variables PATH: std_service_path_env,
                          HOME: Dir.home
  end

  def caveats
    <<~EOS
      To start capturing AI conversations automatically:
        brew services start engram

      First, authenticate:
        engram auth login <your-api-key>

      Get your API key at https://getengram.app

      The daemon watches ~/.claude/projects/ for Claude Code transcripts
      and syncs them to your Engram account.

      Logs: #{var}/log/engram.log
    EOS
  end

  test do
    assert_match "engram", shell_output("#{bin}/engram version")
  end
end
