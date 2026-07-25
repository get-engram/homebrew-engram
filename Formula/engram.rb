class Engram < Formula
  desc "Persistent memory for AI agents — auto-captures and searches conversations"
  homepage "https://getengram.app"
  url "https://registry.npmjs.org/@getengram/cli/-/cli-0.3.4.tgz"
  sha256 "66a1be3e386f20f9dabf78c35444af7b8cf0119cd681ed28e0ba52e9e6a64af3"
  license "BSL-1.1"

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
        engram signup

      Or with an existing API key:
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
