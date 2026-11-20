class Engram < Formula
  desc "Persistent memory for AI agents — auto-captures and searches conversations"
  homepage "https://getengram.app"
  url "https://registry.npmjs.org/@getengram/cli/-/cli-0.7.0.tgz"
  sha256 "93a514184d4cd04eebc10dd1d97b750f680e1018bdd9d27ebf8d535b11e1bf12"
  license "BSL-1.1"
  revision 1

  depends_on "node"

  def install
    # better-sqlite3 builds its native part in its install script, and
    # std_npm_args skips install scripts by default: without that part the
    # daemon can't open its database.
    system "npm", "install", *std_npm_args(ignore_scripts: false)
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

    # The daemon's database needs better-sqlite3's native part.
    sqlite = libexec/"lib/node_modules/@getengram/cli/node_modules/better-sqlite3"
    system Formula["node"].opt_bin/"node", "-e", "new (require(process.argv[1]))(':memory:')", sqlite
  end
end
